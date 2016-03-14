using System.Collections;
using System.Collections.Generic;
using Compiler.Semantics;
using Compiler.Visitors;
using QUT.Gppg;

namespace Compiler.Ast
{
    internal abstract class Node
    {
        public string Text { get; private set; }
        public LexLocation Location { get; private set; }

        protected Node(string text, LexLocation location)
        {
            Text = text;
            Location = location;
        }
    }

    internal abstract class VisitorNode : Node
    {
        protected VisitorNode(string text, LexLocation location) : base(text, location)
        {
        }

        public abstract void Accept(IPlainVisitor v);

        public abstract SemanticAtom Accept(ITypeVisitor v);
    }

    internal abstract class ListNode<T> : Node, IList<T> where T : VisitorNode
    {
        private IList<T> InternalList { get; } = new List<T>();

        protected ListNode(string text, LexLocation location) : base(text, location)
        {
        }

        public IEnumerator<T> GetEnumerator()
        {
            return InternalList.GetEnumerator();
        }

        IEnumerator IEnumerable.GetEnumerator()
        {
            return ((IEnumerable) InternalList).GetEnumerator();
        }

        public void Add(T item)
        {
            InternalList.Add(item);
        }

        public void Clear()
        {
            InternalList.Clear();
        }

        public bool Contains(T item)
        {
            return InternalList.Contains(item);
        }

        public void CopyTo(T[] array, int arrayIndex)
        {
            InternalList.CopyTo(array, arrayIndex);
        }

        public bool Remove(T item)
        {
            return InternalList.Remove(item);
        }

        public int Count => InternalList.Count;

        public bool IsReadOnly => InternalList.IsReadOnly;

        public int IndexOf(T item)
        {
            return InternalList.IndexOf(item);
        }

        public void Insert(int index, T item)
        {
            InternalList.Insert(index, item);
        }

        public void RemoveAt(int index)
        {
            InternalList.RemoveAt(index);
        }

        public T this[int index]
        {
            get { return InternalList[index]; }
            set { InternalList[index] = value; }
        }
    }
}
