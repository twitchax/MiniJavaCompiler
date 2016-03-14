using Compiler.Ast;
using Compiler.Semantics;

namespace Compiler.Visitors
{
    internal interface IVisitor
    {
        void Visit(Goal n);
    }

    internal interface IPlainVisitor : IVisitor
    {
        void Visit(MainClass n);
        void Visit(AstClass n);
        void Visit(ClassExtension n);
        void Visit(Variable n);
        void Visit(Property n);
        void Visit(Method n);
        void Visit(Argument n);
        void Visit(IntArray n);
        void Visit(AstBoolean n);
        void Visit(Int n);
        void Visit(AstString n);
        void Visit(Custom n);
        void Visit(VariableDeclaration n);
        void Visit(Block n);
        void Visit(If n);
        void Visit(While n);
        void Visit(For n);
        void Visit(CompilerFunction n);
        void Visit(Return n);
        void Visit(ExpressionStatementStatement n);
        void Visit(Assignment n);
        void Visit(DeclarationAssignment n);
        void Visit(ArrayAssignment n);
        void Visit(Incrementer n);
        void Visit(And n);
        void Visit(Or n);
        void Visit(Less n);
        void Visit(Greater n);
        void Visit(LessEqual n);//
        void Visit(GreaterEqual n);//
        void Visit(Instanceof n);//
        void Visit(NotEqual n);//
        void Visit(Equal n);//
        void Visit(Plus n);
        void Visit(Minus n);
        void Visit(Mod n);//
        void Visit(Divide n);//
        void Visit(Multiply n);
        void Visit(ArrayAccess n);
        void Visit(ArrayLength n);
        void Visit(Cast n);
        void Visit(MethodCall n);
        void Visit(Integer n);
        void Visit(String n);
        void Visit(True n);
        void Visit(False n);
        void Visit(Null n);
        void Visit(IdentifierExpression n);
        void Visit(This n);
        void Visit(NewArray n);
        void Visit(NewObject n);
        void Visit(Not n);//
        void Visit(Parenthetical n);
    }

    internal interface ITypeVisitor : IVisitor
    {
        SemanticAtom Visit(MainClass n);
        SemanticAtom Visit(AstClass n);
        SemanticAtom Visit(ClassExtension n);
        SemanticAtom Visit(Variable n);
        SemanticAtom Visit(Property n);
        SemanticAtom Visit(Method n);
        SemanticAtom Visit(Argument n);
        SemanticAtom Visit(IntArray n);
        SemanticAtom Visit(AstBoolean n);
        SemanticAtom Visit(Int n);
        SemanticAtom Visit(AstString n);
        SemanticAtom Visit(Custom n);
        SemanticAtom Visit(VariableDeclaration n);
        SemanticAtom Visit(Block n);
        SemanticAtom Visit(If n);
        SemanticAtom Visit(While n);
        SemanticAtom Visit(For n);
        SemanticAtom Visit(CompilerFunction n);
        SemanticAtom Visit(Return n);
        SemanticAtom Visit(ExpressionStatementStatement n);
        SemanticAtom Visit(Assignment n);
        SemanticAtom Visit(DeclarationAssignment n);
        SemanticAtom Visit(ArrayAssignment n);
        SemanticAtom Visit(Incrementer n);
        SemanticAtom Visit(And n);
        SemanticAtom Visit(Or n);
        SemanticAtom Visit(Less n);
        SemanticAtom Visit(Greater n);
        SemanticAtom Visit(LessEqual n);//
        SemanticAtom Visit(GreaterEqual n);//
        SemanticAtom Visit(Instanceof n);//
        SemanticAtom Visit(NotEqual n);//
        SemanticAtom Visit(Equal n);//
        SemanticAtom Visit(Plus n);
        SemanticAtom Visit(Minus n);
        SemanticAtom Visit(Mod n);//
        SemanticAtom Visit(Divide n);//
        SemanticAtom Visit(Multiply n);
        SemanticAtom Visit(ArrayAccess n);
        SemanticAtom Visit(ArrayLength n);
        SemanticAtom Visit(Cast n);
        SemanticAtom Visit(MethodCall n);
        SemanticAtom Visit(Integer n);
        SemanticAtom Visit(String n);
        SemanticAtom Visit(True n);
        SemanticAtom Visit(False n);
        SemanticAtom Visit(Null n);
        SemanticAtom Visit(IdentifierExpression n);
        SemanticAtom Visit(This n);
        SemanticAtom Visit(NewArray n);
        SemanticAtom Visit(NewObject n);
        SemanticAtom Visit(Not n);//
        SemanticAtom Visit(Parenthetical n);
    }
}
