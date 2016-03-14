using System.Collections.Generic;
using System.Linq;
using Compiler.Ast;
using QUT.Gppg;

namespace Compiler.Semantics
{
    #region Base

    internal abstract class Symbol : SemanticAtom
    {
        // This is null at creation.  It is filled from the global type table upon verification.
        public SemanticType RealizedType { get; set; }

        // This is always set at creation, as UtilizedType is a thin wrapper around a type that has been "utilized" but not "realized" (look for delcarion later).
        protected UtilizedType UtilizedType { get; set; }

        protected Symbol(string name, UtilizedType utilizedType, LexLocation declarationLocation) : base(name, declarationLocation)
        {
            UtilizedType = utilizedType;
        }
    }

    #endregion

    #region Symbol Types

    internal class Local : Symbol
    {
        public int Position { get; private set; }
        public Local(string name, int position, UtilizedType utilizedType, LexLocation declarationLocation) : base(name, utilizedType, declarationLocation)
        {
            Position = position;
        }
    }

    internal class MethodArgument : Symbol
    {
        public MethodArgument(string name, UtilizedType utilizedType, LexLocation declarationLocation) : base(name, utilizedType, declarationLocation)
        {
        }
    }

    internal abstract class ClassMember : Symbol
    {
        protected ClassMember(string name, UtilizedType utilizedType, LexLocation declarationLocation) : base(name, utilizedType, declarationLocation)
        {
        }
    }

    internal class ClassProperty : ClassMember
    {
        public ClassProperty(string name, UtilizedType utilizedType, LexLocation declarationLocation) : base(name, utilizedType, declarationLocation)
        {
        }
    }

    internal class ClassMethod : ClassMember
    {
        public SemanticType RealizedReturnType
        {
            get { return base.RealizedType; }
            set { base.RealizedType = value; }
        }

        protected UtilizedType UtilizedReturnType
        {
            get { return base.UtilizedType; }
            set { base.UtilizedType = value; }
        }
        
        public ClassMethodBlock MethodBody { get; set; }
        public AstType AstReturnType { get; set; }

        public Dictionary<string, MethodArgument> Arguments = new Dictionary<string, MethodArgument>();

        public int LocalCount => MethodBody.GetLocalCount();

        public string MethodTableName => this.OwnerClass.Name + "$" + this.Name;

        public string ReturnLabelName => MethodTableName + "_Return";

        public Class OwnerClass { get; set; }

        public ClassMethod(string name, UtilizedType utilizedReturnType, LexLocation declarationLocation) : base(name, utilizedReturnType, declarationLocation)
        {
        }
    }

    internal class ClassMethodBlock : SemanticAtom
    {
        public Block AstBlock { get; private set; }
        public ClassMethodBlock OuterBlock { get; }
        public ClassMethod OwnerMethod { get; }

        public List<ClassMethodBlock> SubBlocks { get; } = new List<ClassMethodBlock>(); 

        public Dictionary<string, Local> Locals = new Dictionary<string, Local>();

        public ClassMethodBlock(Block astBlock, ClassMethodBlock outerBlock, ClassMethod ownerMethod, LexLocation declarationLocation) : base("BLOCK", declarationLocation)
        {
            AstBlock = astBlock;
            OuterBlock = outerBlock;
            OwnerMethod = ownerMethod;
        }

        public bool HasLocal(string name)
        {
            return this.Locals.ContainsKey(name) || (OuterBlock != null && OuterBlock.HasLocal(name));
        }

        public Local GetLocal(string name)
        {
            return this.Locals.ContainsKey(name) ? this.Locals[name] : OuterBlock?.GetLocal(name);
        }

        public int GetLocalCount()
        {
            return Locals.Count + SubBlocks.Sum(classMethodBlock => classMethodBlock.GetLocalCount());
        }

        public SemanticType LookupIdentifierType(string identifier, LexLocation location)
        {
            // First check this block.
            if (this.Locals.ContainsKey(identifier) && this.Locals[identifier].DeclarationLocation.StartLine <= location.StartLine)
                return this.Locals[identifier].RealizedType;

            // Next, check the outer block.
            if (OuterBlock != null)
                return OuterBlock.LookupIdentifierType(identifier, location);

            // This is the main method block of the method (no outer block), check the args and class properties.
            if (this.OwnerMethod.Arguments.ContainsKey(identifier))
                return this.OwnerMethod.Arguments[identifier].RealizedType;
            return this.OwnerMethod.OwnerClass.LookupProperty(identifier);
        }
    }

    #endregion
}
