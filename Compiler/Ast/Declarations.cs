using Compiler.Semantics;
using Compiler.Visitors;
using QUT.Gppg;

namespace Compiler.Ast
{
    #region Lists

    internal class ArgumentList : ListNode<Argument>
    {
        public ArgumentList() : base(nameof(ArgumentList), null)
        {
        }
    }

    internal class ContinuedArgumentList : ListNode<Argument>
    {
        public ContinuedArgumentList() : base(nameof(ContinuedArgumentList), null)
        {
        }
    }

    #endregion

    #region Base

    internal abstract class Declaration : VisitorNode
    {
        protected Declaration(string text, LexLocation location) : base("Declaration > " + text, location)
        {
        }
    }

    #endregion

    #region Productions

    internal class Variable : Declaration
    {
        public string Name { get; private set; }
        public AstType AstType { get; private set; }

        public Variable(string name, AstType astType, LexLocation location) : base(nameof(Variable), location)
        {
            Name = name;
            AstType = astType;
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

    internal class Property : Declaration
    {
        public string Name { get; private set; }
        public AstType AstType { get; private set; }

        public Property(string name, AstType astType, LexLocation location) : base(nameof(Variable), location)
        {
            Name = name;
            AstType = astType;
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

    internal class Argument : VisitorNode
    {
        public string Name { get; private set; }
        public AstType AstType { get; private set; }

        public Argument(string name, AstType astType, LexLocation location) : base(nameof(Argument), location)
        {
            Name = name;
            AstType = astType;
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

    internal class Method : Declaration
    {
        public string Name { get; private set; }
        public AstType ReturnAstType { get; private set; }
        public ArgumentList ArgumentList { get; private set; }
        public Statement Statement { get; private set; }

        public Method(string name, AstType returnAstType, ArgumentList argumentList, Statement statement, LexLocation location) : base(nameof(Method), location)
        {
            Name = name;
            ReturnAstType = returnAstType;
            ArgumentList = argumentList;
            Statement = statement;
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
