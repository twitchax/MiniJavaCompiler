using Compiler.Semantics;
using Compiler.Visitors;
using QUT.Gppg;

namespace Compiler.Ast
{
    #region Base

    internal abstract class ExpressionStatement : Expression
    {
        protected ExpressionStatement(string text, LexLocation location) : base(nameof(ExpressionStatement) + " > " + text, location)
        {
        }
    }

    #endregion

    #region Productions

    internal class Assignment : ExpressionStatement
    {
        public string DestinationName { get; private set; }
        public Expression Source { get; private set; }

        public Assignment(string destinationName, Expression source, LexLocation location) : base(nameof(Assignment), location)
        {
            DestinationName = destinationName;
            Source = source;
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

    internal class DeclarationAssignment : ExpressionStatement
    {
        public string DestinationName { get; private set; }
        public AstType AstType { get; private set; }
        public Expression Source { get; private set; }

        public DeclarationAssignment(string destinationName, AstType type, Expression source, LexLocation location) : base(nameof(DeclarationAssignment), location)
        {
            DestinationName = destinationName;
            AstType = type;
            Source = source;
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

    internal class ArrayAssignment : ExpressionStatement
    {
        public Expression Destination { get; private set; }
        public Expression Index { get; private set; }
        public Expression Source { get; private set; }

        public ArrayAssignment(Expression destination, Expression index, Expression source, LexLocation location) : base(nameof(ArrayAssignment), location)
        {
            Destination = destination;
            Index = index;
            Source = source;
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

    internal class MethodCall : ExpressionStatement
    {
        public Expression Source { get; private set; }
        public string Name { get; private set; }
        public ExpressionList Arguments { get; private set; }

        public MethodCall(Expression source, string name, ExpressionList arguments, LexLocation location) : base(nameof(MethodCall), location)
        {
            Source = source;
            Name = name;
            Arguments = arguments;
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

    internal class Incrementer : ExpressionStatement
    {
        public string IdentifierName { get; private set; }
        public string Operator { get; private set; }
        public bool IsPostfix { get; private set; }
        public Expression IncrementExpression { get; private set; }

        public Incrementer(string identifierName, string op, Expression incrementExpression, bool isPostfix, LexLocation location) : base(nameof(Incrementer), location)
        {
            IdentifierName = identifierName;
            Operator = op;
            IncrementExpression = incrementExpression;
            IsPostfix = isPostfix;
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
