using Compiler.Semantics;
using Compiler.Visitors;
using QUT.Gppg;

namespace Compiler.Ast
{
    #region Lists

    internal class StatementList : ListNode<Statement>
    {
        public StatementList() : base(nameof(StatementList), null)
        {
        }
    }

    #endregion

    #region Base

    internal abstract class Statement : VisitorNode
    {
        protected Statement(string text, LexLocation location) : base(nameof(Statement) + " > " + text, location)
        {
        }
    }

    #endregion

    #region Productions

    internal class VariableDeclaration : Statement
    {
        public AstType AstType { get; private set; }
        public string Name { get; private set; }

        public VariableDeclaration(AstType astType, string name, LexLocation location) : base(nameof(VariableDeclaration), location)
        {
            AstType = astType;
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

    internal class Block : Statement
    {
        public StatementList StatementList { get; private set; }
        public ClassMethodBlock AssociatedSemanticBlock { get; set; }

        public For OptionalFor { get; set; }

        public Block(StatementList statementList, LexLocation location) : base(nameof(Statement), location)
        {
            StatementList = statementList;
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

    internal class If : Statement
    {
        public Expression Test { get; private set; }
        public Statement True { get; private set; }
        public Statement False { get; private set; }

        public If(Expression test, Statement @true, Statement @false, LexLocation location) : base(nameof(If), location)
        {
            Test = test;
            True = @true;
            False = @false;
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

    internal class While : Statement
    {
        public Expression Test { get; private set; }
        public Statement Action { get; private set; }

        public While(Expression test, Statement action, LexLocation location) : base(nameof(While), location)
        {
            Test = test;
            Action = action;
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

    internal class For : Statement
    {
        public ExpressionStatement Initialize { get; private set; }
        public Expression Test { get; private set; }
        public ExpressionStatement Afterthought { get; private set; }
        public Statement Action { get; private set; }

        public For(ExpressionStatement initialize, Expression test, ExpressionStatement afterthought, Statement action, LexLocation location) : base(nameof(For), location)
        {
            Initialize = initialize;
            Test = test;
            Afterthought = afterthought;
            Action = action;
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

    internal class CompilerFunction : ExpressionStatement
    {
        public string FunctionString { get; private set; }
        public Expression Expression { get; private set; }

        public CompilerFunction(Expression expression, string functionString, LexLocation location) : base(nameof(CompilerFunction), location)
        {
            Expression = expression;
            FunctionString = functionString;
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

    internal class Return : Statement
    {
        public Expression Expression { get; private set; }

        public Return(Expression expression, LexLocation location) : base(nameof(Return), location)
        {
            Expression = expression;
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

    internal class ExpressionStatementStatement : Statement
    {
        public ExpressionStatement ExpressionStatement { get; private set; }

        public ExpressionStatementStatement(ExpressionStatement expressionStatement, LexLocation location) : base(nameof(ExpressionStatementStatement), location)
        {
            ExpressionStatement = expressionStatement;
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
