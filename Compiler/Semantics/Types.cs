using System.Collections.Generic;
using QUT.Gppg;

namespace Compiler.Semantics
{
    #region Base

    internal abstract class SemanticType : SemanticAtom
    {
        public bool IsPrimitive => this is Primitive;

        protected SemanticType(string name, LexLocation declarationLocation) : base(name, declarationLocation)
        {
        }

        public bool IsAssignableFrom(SemanticType other)
        {
            // First check for a primitive.
            if (this.IsPrimitive)
                return this == other;

            // Next, check class hierarchy.
            var next = other as Class;
            if (this == Class.Null || other == Class.Null)
                return true;
            while (next != null)
            {
                if (this == next)
                    return true;
                next = next.BaseClass;
            }

            return false;
        }
    }

    #endregion

    #region Semantic Types

    internal class Primitive : SemanticType
    {
        public static Primitive Int = new Primitive("int", null);
        public static Primitive IntArray = new Primitive("int[]", null);
        public static Primitive StringArray = new Primitive("String[]", null);
        public static Primitive Boolean = new Primitive("boolean", null);
        public static Primitive String = new Primitive("String", null);
        public static Primitive Void = new Primitive("void", null);

        public Primitive(string name, LexLocation declarationLocation) : base(name, declarationLocation)
        {
        }
    }

    internal class Class : SemanticType
    {
        public static Class Unknown = new Class(nameof(Unknown), null, null);
        public static Class Null = new Class(nameof(Null), null, null);

        public Class BaseClass { get; set; }
        protected UtilizedType BaseClassUtilizedType { get; set; }
        public Dictionary<string, ClassProperty> Properties { get; } = new Dictionary<string, ClassProperty>();
        public Dictionary<string, ClassMethod> Methods { get; } = new Dictionary<string, ClassMethod>();

        public string ClassTableName => "$$" + this.Name;
        
        private Dictionary<string, ClassMethod> _methodTable;
        private Dictionary<string, ClassMethod> MethodTable
        {
            get
            {
                if (_methodTable == null)
                {
                    _methodTable = new Dictionary<string, ClassMethod>(this.BaseClass?.MethodTable ?? new Dictionary<string, ClassMethod>());

                    foreach (var m in Methods.EnumerateValues())
                    {
                        if (_methodTable.ContainsKey(m.Name))
                            _methodTable[m.Name] = m;
                        else
                            _methodTable.Add(m.Name, m);
                    }
                }

                return _methodTable;
            }
        }

        private List<ClassProperty> _propertyTable;
        private List<ClassProperty> PropertyTable
        {
            get
            {
                if (_propertyTable == null)
                {
                    _propertyTable = new List<ClassProperty>(this.BaseClass?.PropertyTable ?? new List<ClassProperty>());
                    _propertyTable.AddRange(Properties.EnumerateValues());
                }

                return _propertyTable;
            }
        }

        public bool IsMainClass { get; set; } = false;

        public Class(string name, UtilizedType baseClassUtilizedType, LexLocation declarationLocation) : base(name, declarationLocation)
        {
            BaseClassUtilizedType = baseClassUtilizedType;
        }

        public IEnumerable<ClassMethod> MethodTableEnumerator()
        {
            return MethodTable.EnumerateValues();
        }

        public int GetMethodIndex(string name)
        {
            return MethodTable.GetKeyIndex(name);
        }

        public ClassMethod GetMethod(string name)
        {
            return MethodTable[name];
        }

        public int NumMethods()
        {
            return MethodTable.Count;
        }

        public int GetPropertyIndex(string name)
        {
            for (int k = PropertyTable.Count - 1; k >= 0; k--)
            {
                if (PropertyTable[k].Name == name)
                    return k;
            }

            throw new System.Exception("This should never happen.");
        }

        public ClassProperty GetProperty(string name)
        {
            for (int k = PropertyTable.Count - 1; k >= 0; k--)
            {
                if (PropertyTable[k].Name == name)
                    return PropertyTable[k];
            }

            throw new System.Exception("This should never happen.");
        }

        public int NumProperties()
        {
            return PropertyTable.Count;
        }

        public SemanticType LookupProperty(string propertyName)
        {
            var next = this;
            while (next != null)
            {
                if (next.Properties.ContainsKey(propertyName))
                    return next.Properties[propertyName].RealizedType;
                next = next.BaseClass;
            }

            return Class.Unknown;
        }

        public ClassMethod LookupMethod(string methodName)
        {
            var next = this;
            while (next != null)
            {
                if (next.Methods.ContainsKey(methodName))
                    return next.Methods[methodName];
                next = next.BaseClass;
            }

            return null;
        }

        public bool HasProperty(string propertyName)
        {
            var next = this;
            while (next != null)
            {
                if (next.Properties.ContainsKey(propertyName))
                    return true;
                next = next.BaseClass;
            }

            return false;
        }

        public bool HasMethod(string methodName)
        {
            var next = this;
            while (next != null)
            {
                if (next.Methods.ContainsKey(methodName))
                    return true;
                next = next.BaseClass;
            }

            return false;

        }

        public int? GetAncestorCount()
        {
            var next = this;
            var alreadyProcessed = new HashSet<string>();

            var count = 0;
            while (next != null)
            {
                if (alreadyProcessed.Contains(next.Name))
                    return null;

                alreadyProcessed.Add(next.Name);
                count++;
                next = next.BaseClass;
            }

            return count;
        }
    }

    #endregion
}
