using Compiler.Semantics;
using Compiler.Visitors;
using QUT.Gppg;

namespace Compiler.Ast
{
    #region Base

    internal abstract class AstType : VisitorNode
    {
        public string Name => base.Text;

        protected AstType(string text, LexLocation location) : base(nameof(AstType) + " > " + text, location)
        {
        }
    }

    #endregion

    #region Productions

    internal class IntArray : AstType
    {
        public IntArray(LexLocation location) : base(nameof(IntArray), location)
        {
        }

        public override void Accept(IPlainVisitor v)
        {
            v.Visit(this);
        }

        public override SemanticAtom Accept(ITypeVisitor v)
        {
            return v.Visit(this);
        }
    }

    internal class AstBoolean : AstType
    {
        public AstBoolean(LexLocation location) : base(nameof(AstBoolean), location)
        {
        }

        public override void Accept(IPlainVisitor v)
        {
            v.Visit(this);
        }

        public override SemanticAtom Accept(ITypeVisitor v)
        {
            return v.Visit(this);
        }
    }

    internal class Int : AstType
    {
        public Int(LexLocation location) : base(nameof(Int), location)
        {
        }

        public override void Accept(IPlainVisitor v)
        {
            v.Visit(this);
        }

        public override SemanticAtom Accept(ITypeVisitor v)
        {
            return v.Visit(this);
        }
    }

    internal class AstString : AstType
    {
        public AstString(LexLocation location) : base(nameof(AstString), location)
        {
        }

        public override void Accept(IPlainVisitor v)
        {
            v.Visit(this);
        }

        public override SemanticAtom Accept(ITypeVisitor v)
        {
            return v.Visit(this);
        }
    }

    internal class Custom : AstType
    {
        public new string Name { get; private set; }

        public Custom(string name, LexLocation location) : base(nameof(Custom), location)
        {
            Name = name;
        }

        public override void Accept(IPlainVisitor v)
        {
            v.Visit(this);
        }

        public override SemanticAtom Accept(ITypeVisitor v)
        {
            return v.Visit(this);
        }
    }

    #endregion
}
