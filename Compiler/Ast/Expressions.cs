using System.Globalization;
using Compiler.Semantics;
using Compiler.Visitors;
using QUT.Gppg;

namespace Compiler.Ast
{
    #region Lists

    internal class ExpressionList : ListNode<Expression>
    {
        public ExpressionList() : base(nameof(ExpressionList), null)
        {
        }
    }

    internal class ContinuedExpressionList : ListNode<Expression>
    {
        public ContinuedExpressionList() : base(nameof(ContinuedExpressionList), null)
        {
        }
    }

    #endregion

    #region Base

    internal abstract class Expression : VisitorNode
    {
        public SemanticType RealizedType { get; set; }

        protected Expression(string text, LexLocation location) : base(nameof(Expression) + " > " + text, location)
        {
        }
    }

    internal abstract class ConstantExpression : Expression
    {
        protected ConstantExpression(string text, LexLocation location) : base(nameof(ConstantExpression) + " > " +  text, location)
        {
        }
    }

    internal abstract class UnaryExpression : Expression
    {
        public Expression Expression { get; private set; }

        protected UnaryExpression(string text, Expression expression, LexLocation location) : base(nameof(UnaryExpression) + " > " + text, location)
        {
            Expression = expression;
        }
    }

    internal abstract class BinaryExpression : Expression
    {
        public Expression LeftExpression { get; private set; }
        public Expression RightExpression { get; private set; }

        protected BinaryExpression(string text, Expression leftExpression, Expression rightExpresion, LexLocation location) : base(nameof(BinaryExpression) + " > " + text, location)
        {
            LeftExpression = leftExpression;
            RightExpression = rightExpresion;
        }
    }

    #endregion

    #region Productions

    internal class And : BinaryExpression
    {
        public And(Expression leftExpression, Expression rightExpresion, LexLocation location) : base(nameof(And), leftExpression, rightExpresion, location)
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

    internal class Or : BinaryExpression
    {
        public Or(Expression leftExpression, Expression rightExpresion, LexLocation location) : base(nameof(Or), leftExpression, rightExpresion, location)
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

    internal class Less : BinaryExpression
    {
        public Less(Expression leftExpression, Expression rightExpresion, LexLocation location) : base(nameof(Less), leftExpression, rightExpresion, location)
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

    internal class Greater : BinaryExpression
    {
        public Greater(Expression leftExpression, Expression rightExpresion, LexLocation location) : base(nameof(Greater), leftExpression, rightExpresion, location)
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

    internal class LessEqual : BinaryExpression
    {
        public LessEqual(Expression leftExpression, Expression rightExpresion, LexLocation location) : base(nameof(LessEqual), leftExpression, rightExpresion, location)
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

    internal class GreaterEqual : BinaryExpression
    {
        public GreaterEqual(Expression leftExpression, Expression rightExpresion, LexLocation location) : base(nameof(GreaterEqual), leftExpression, rightExpresion, location)
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

    internal class Instanceof : Expression
    {
        public Expression LeftExpression { get; private set; }
        public string TypeNameToCheck { get; private set; }
        public SemanticType RealizedTypeToCheck { get; set; }

        public Instanceof(Expression leftExpression, string typeName, LexLocation location) : base(nameof(Instanceof), location)
        {
            LeftExpression = leftExpression;
            TypeNameToCheck = typeName;
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

    internal class NotEqual : BinaryExpression
    {
        public NotEqual(Expression leftExpression, Expression rightExpresion, LexLocation location) : base(nameof(NotEqual), leftExpression, rightExpresion, location)
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

    internal class Equal : BinaryExpression
    {
        public Equal(Expression leftExpression, Expression rightExpresion, LexLocation location) : base(nameof(Equal), leftExpression, rightExpresion, location)
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

    internal class Plus : BinaryExpression
    {
        public Plus(Expression leftExpression, Expression rightExpresion, LexLocation location) : base(nameof(Plus), leftExpression, rightExpresion, location)
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

    internal class Minus : BinaryExpression
    {
        public Minus(Expression leftExpression, Expression rightExpresion, LexLocation location) : base(nameof(Minus), leftExpression, rightExpresion, location)
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

    internal class Mod : BinaryExpression
    {
        public Mod(Expression leftExpression, Expression rightExpresion, LexLocation location) : base(nameof(Mod), leftExpression, rightExpresion, location)
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

    internal class Divide : BinaryExpression
    {
        public Divide(Expression leftExpression, Expression rightExpresion, LexLocation location) : base(nameof(Divide), leftExpression, rightExpresion, location)
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

    internal class Multiply : BinaryExpression
    {
        public Multiply(Expression leftExpression, Expression rightExpresion, LexLocation location) : base(nameof(Multiply), leftExpression, rightExpresion, location)
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

    internal class ArrayAccess : ConstantExpression
    {
        public Expression Array { get; private set; }
        public Expression Index { get; private set; }

        public ArrayAccess(Expression array, Expression index, LexLocation location) : base(nameof(ArrayAccess), location)
        {
            Array = array;
            Index = index;
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

    internal class ArrayLength : ConstantExpression
    {
        public Expression Array { get; private set; }

        public ArrayLength(Expression array, LexLocation location) : base(nameof(ArrayLength), location)
        {
            Array = array;
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

    internal class Cast : Expression
    {
        public Expression Expression { get; private set; }
        public string TypeNameToCast { get; private set; }
        public SemanticType RealizedTypeToCast { get; set; }

        public Cast(Expression expression, string typeName, LexLocation location) : base(nameof(Cast), location)
        {
            Expression = expression;
            TypeNameToCast = typeName;
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

    internal class Integer : ConstantExpression
    {
        public int Value { get; private set; }
        public Integer(string val, LexLocation location) : base(nameof(Integer), location)
        {
            Value = val.StartsWith("0x") ? int.Parse(val.Remove(0, 2), NumberStyles.AllowHexSpecifier) : int.Parse(val);
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

    internal class String : ConstantExpression
    {
        public string Str { get; private set; }
        public String(string val, LexLocation location) : base(nameof(String), location)
        {
            Str = val;
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

    internal class True : ConstantExpression
    {
        public True(LexLocation location) : base(nameof(True), location)
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

    internal class False : ConstantExpression
    {
        public False(LexLocation location) : base(nameof(False), location)
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

    internal class Null : ConstantExpression
    {
        public Null(LexLocation location) : base(nameof(Null), location)
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

    internal class IdentifierExpression : ConstantExpression
    {
        public string Name { get; private set; }

        public IdentifierExpression(string text, LexLocation location) : base(nameof(IdentifierExpression), location)
        {
            Name = text;
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

    internal class This : ConstantExpression
    {
        public This(LexLocation location) : base(nameof(This), location)
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

    internal class NewArray : ConstantExpression
    {
        public Expression Size { get; private set; }
        public NewArray(Expression size, LexLocation location) : base(nameof(NewArray), location)
        {
            Size = size;
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

    internal class NewObject : ConstantExpression
    {
        public string Name { get; private set; }
        public NewObject(string name, LexLocation location) : base(nameof(NewObject), location)
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

    internal class Not : UnaryExpression
    {
        public Not(Expression expr, LexLocation location) : base(nameof(Not), expr, location)
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

    internal class Parenthetical : UnaryExpression
    {
        public Parenthetical(Expression expr, LexLocation location) : base(nameof(Parenthetical), expr, location)
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

    #endregion
}
