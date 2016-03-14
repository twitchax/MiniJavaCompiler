using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;

namespace Compiler
{
    public static class Helpers
    {
        #region Write Helpers

        public static void WriteLine(string s = null)
        {
            Console.WriteLine(s);
        }

        public static void Write(string s)
        {
            Console.Write(s);
        }

        [Conditional("NONE")]
        public static void WriteDebug(string s)
        {
            WriteLine(s);
        }

        public static void WriteLineColor(string s, ConsoleColor foregroundColor, ConsoleColor backgroundColor)
        {
            var oldF = Console.ForegroundColor;
            var oldB = Console.BackgroundColor;
            Console.ForegroundColor = foregroundColor;
            Console.BackgroundColor = backgroundColor;
            Console.WriteLine(s);
            Console.ForegroundColor = oldF;
            Console.BackgroundColor = oldB;
        }
        public static void WriteColor(string s, ConsoleColor foregroundColor, ConsoleColor backgroundColor)
        {
            var oldF = Console.ForegroundColor;
            var oldB = Console.BackgroundColor;
            Console.ForegroundColor = foregroundColor;
            Console.BackgroundColor = backgroundColor;
            Console.Write(s);
            Console.ForegroundColor = oldF;
            Console.BackgroundColor = oldB;
        }

        #endregion

        #region Extensions

        public static IEnumerable<TValue> EnumerateValues<TKey, TValue>(this IDictionary<TKey, TValue> d)
        {
            return d.Select(p => p.Value);
        }

        public static void ForEachWithIndex<TKey, TValue>(this IDictionary<TKey, TValue> d, Action<TKey, TValue, int> action)
        {
            for (int k = 0; k < d.Keys.Count; k++)
                action(d.Keys.ElementAt(k), d.Values.ElementAt(k), k);
        }

        public static int GetKeyIndex<TKey, TValue>(this IDictionary<TKey, TValue> d, TKey key) where TKey : class, IEquatable<TKey>
        {
            var index = -1;

            d.ForEachWithIndex((k, v, i) =>
            {
                if (k.Equals(key))
                    index = i;
            });

            return index;
        }

        public static void ForEach<T>(this IEnumerable<T> list, Action<T> func)
        {
            foreach (var item in list)
            {
                func(item);
            }
        }

        public static void AddRange<T>(this IList<T> list, IEnumerable<T> items)
        {
            foreach (var item in items)
            {
                list.Add(item);
            }
        }

        public static void AddRange<TKey, TValue>(this IDictionary<TKey, TValue> list, IDictionary<TKey, TValue> items)
        {
            foreach (var item in items)
            {
                list.Add(item);
            }
        }

        #endregion
    }
}
