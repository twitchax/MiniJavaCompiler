using System.Linq;
using Compiler.Ast;

namespace Compiler.Visitors
{
    internal class TreeVisitor : IPlainVisitor
    {
        #region Helpers

        private string _tab = "";

        private void Tab()
        {
            _tab += " ";
        }

        private void Untab()
        {
            _tab = _tab.Substring(1);
        }

        #endregion

        #region Top Level AST Nodes

        public void Visit(Goal n)
        {
            Helpers.WriteLine($"{n.Text} [{n.Location.StartLine}, {n.Location.StartColumn}]");
            Tab();
            n.MainClass.Accept(this);
            foreach (var c in n.ClassList)
            {
                c.Accept(this);
                Helpers.WriteLine();
            }
            Untab();
        }

        public void Visit(MainClass n)
        {
            Helpers.WriteLine($"{_tab}{n.Text} [{n.Location.StartLine}, {n.Location.StartColumn}]");
            Tab();
            Helpers.WriteLine($"{_tab}Args: {n.ArgsName}");

            Helpers.WriteLine($"{_tab}Statement");
            Tab();
            n.MainMethodBody.Accept(this);
            Untab();

            Untab();
        }

        public void Visit(AstClass n)
        {
            Helpers.WriteLine($"{_tab}{n.Text} ({n.Name}) [{n.Location.StartLine}, {n.Location.StartColumn}]");
            Tab();
            n.ClassExtension?.Accept(this);

            Helpers.WriteLine($"{_tab}Variables");
            Tab();
            foreach (var v in n.ClassDeclarationList.OfType<Property>())
            {
                v.Accept(this);
            }
            Untab();

            Helpers.WriteLine($"{_tab}Methods");
            Tab();
            foreach (var m in n.ClassDeclarationList.OfType<Method>())
            {
                m.Accept(this);
            }
            Untab();

            Untab();
        }

        public void Visit(ClassExtension n)
        {
            Helpers.WriteLine($"{_tab}{n.Text} ({n.Name}) [{n.Location.StartLine}, {n.Location.StartColumn}]");
        }

        #endregion

        #region Method AST Nodes

        public void Visit(Variable n)
        {
            Helpers.WriteLine($"{_tab}{n.Text} ({n.Name}) [{n.Location.StartLine}, {n.Location.StartColumn}]");
        }

        public void Visit(Property n)
        {
            Helpers.WriteLine($"{_tab}{n.Text} ({n.Name}) [{n.Location.StartLine}, {n.Location.StartColumn}]");
        }

        public void Visit(Method n)
        {
            Helpers.WriteLine($"{_tab}{n.Text} ({n.Name}) [{n.Location.StartLine}, {n.Location.StartColumn}]");
            Tab();

            Helpers.WriteLine($"{_tab}Return Type");
            Tab();
            n.ReturnAstType?.Accept(this);
            Untab();

            Helpers.WriteLine($"{_tab}Arguments");
            Tab();
            foreach (var s in n.ArgumentList)
            {
                s.Accept(this);
            }
            Untab();

            Helpers.WriteLine($"{_tab}Statements");
            Tab();
            n.Statement.Accept(this);
            Untab();

            Untab();
        }

        public void Visit(Argument n)
        {
            Helpers.WriteLine($"{_tab}{n.Text} ({n.Name}) [{n.Location.StartLine}, {n.Location.StartColumn}]");
            Tab();

            Helpers.WriteLine($"{_tab}Type");
            Tab();
            n.AstType.Accept(this);
            Untab();

            Untab();
        }

        #endregion

        #region Type AST Nodes

        public void Visit(IntArray n)
        {
            Helpers.WriteLine($"{_tab}{n.Text} [{n.Location.StartLine}, {n.Location.StartColumn}]");
        }

        public void Visit(AstBoolean n)
        {
            Helpers.WriteLine($"{_tab}{n.Text} [{n.Location.StartLine}, {n.Location.StartColumn}]");
        }

        public void Visit(Int n)
        {
            Helpers.WriteLine($"{_tab}{n.Text} [{n.Location.StartLine}, {n.Location.StartColumn}]");
        }

        public void Visit(AstString n)
        {
            Helpers.WriteLine($"{_tab}{n.Text} [{n.Location.StartLine}, {n.Location.StartColumn}]");
        }

        public void Visit(Custom n)
        {
            Helpers.WriteLine($"{_tab}{n.Text} [{n.Location.StartLine}, {n.Location.StartColumn}]");
        }

        #endregion

        #region Statement AST Nodes

        public void Visit(VariableDeclaration n)
        {
            Helpers.WriteLine($"{_tab}{n.Text} ({n.Name}) [{n.Location.StartLine}, {n.Location.StartColumn}]");
            Tab();

            Helpers.WriteLine($"{_tab}Type");
            Tab();
            n.AstType.Accept(this);
            Untab();

            Untab();
        }

        public void Visit(Block n)
        {
            Helpers.WriteLine($"{_tab}{n.Text} [{n.Location.StartLine}, {n.Location.StartColumn}]");
            Tab();

            Helpers.WriteLine($"{_tab}Statements");
            Tab();
            foreach (var s in n.StatementList)
            {
                s.Accept(this);
            }
            Untab();

            Untab();
        }

        public void Visit(If n)
        {
            Helpers.WriteLine($"{_tab}{n.Text} [{n.Location.StartLine}, {n.Location.StartColumn}]");
            Tab();

            Helpers.WriteLine($"{_tab}Test");
            Tab();
            n.Test.Accept(this);
            Untab();
            Helpers.WriteLine($"{_tab}True");
            Tab();
            n.True.Accept(this);
            Untab();
            Helpers.WriteLine($"{_tab}False");
            Tab();
            n.False.Accept(this);
            Untab();

            Untab();
        }

        public void Visit(While n)
        {
            Helpers.WriteLine($"{_tab}{n.Text} [{n.Location.StartLine}, {n.Location.StartColumn}]");
            Tab();

            Helpers.WriteLine($"{_tab}Test");
            Tab();
            n.Test.Accept(this);
            Untab();
            Helpers.WriteLine($"{_tab}Action");
            Tab();
            n.Action.Accept(this);
            Untab();

            Untab();
        }
        public void Visit(For n)
        {
            Helpers.WriteLine($"{_tab}{n.Text} [{n.Location.StartLine}, {n.Location.StartColumn}]");
            Tab();

            Helpers.WriteLine($"{_tab}Initialize");
            Tab();
            n.Initialize.Accept(this);
            Untab();
            Helpers.WriteLine($"{_tab}Test");
            Tab();
            n.Test.Accept(this);
            Untab();
            Helpers.WriteLine($"{_tab}Afterthought");
            Tab();
            n.Afterthought.Accept(this);
            Untab();
            Helpers.WriteLine($"{_tab}Action");
            Tab();
            n.Action.Accept(this);
            Untab();

            Untab();
        }

        public void Visit(Return n)
        {
            Helpers.WriteLine($"{_tab}{n.Text} [{n.Location.StartLine}, {n.Location.StartColumn}]");
            Tab();

            Helpers.WriteLine($"{_tab}Expression");
            Tab();
            n.Expression?.Accept(this);
            Untab();

            Untab();
        }

        public void Visit(ExpressionStatementStatement n)
        {
            n.ExpressionStatement.Accept(this);
        }

        #endregion

        #region Expression Statement AST Nodes

        public void Visit(Assignment n)
        {
            Helpers.WriteLine($"{_tab}{n.Text} ({n.DestinationName}) [{n.Location.StartLine}, {n.Location.StartColumn}]");
            Tab();

            Helpers.WriteLine($"{_tab}Source");
            Tab();
            n.Source.Accept(this);
            Untab();

            Untab();
        }

        public void Visit(DeclarationAssignment n)
        {
            Helpers.WriteLine($"{_tab}{n.Text} ({n.DestinationName}) [{n.Location.StartLine}, {n.Location.StartColumn}]");
            Tab();

            Helpers.WriteLine($"{_tab}Type");
            Tab();
            n.AstType.Accept(this);
            Untab();

            Helpers.WriteLine($"{_tab}Source");
            Tab();
            n.Source.Accept(this);
            Untab();

            Untab();
        }

        public void Visit(ArrayAssignment n)
        {
            Helpers.WriteLine($"{_tab}{n.Text} [{n.Location.StartLine}, {n.Location.StartColumn}]");
            Tab();


            Helpers.WriteLine($"{_tab}Destination");
            Tab();
            n.Destination.Accept(this);
            Helpers.WriteLine($"{_tab}Index");
            Tab();
            n.Index.Accept(this);
            Untab();
            Helpers.WriteLine($"{_tab}Source");
            Tab();
            n.Source.Accept(this);
            Untab();

            Untab();
        }

        public void Visit(MethodCall n)
        {
            Helpers.WriteLine($"{_tab}{n.Text} [{n.Location.StartLine}, {n.Location.StartColumn}]");
            Tab();

            Helpers.WriteLine($"{_tab}Source");
            Tab();
            n.Source.Accept(this);
            Untab();
            Helpers.WriteLine($"{_tab}Arguments");
            Tab();
            foreach (var s in n.Arguments)
            {
                s.Accept(this);
            }
            Untab();

            Untab();
        }

        public void Visit(CompilerFunction n)
        {
            Helpers.WriteLine($"{_tab}{n.Text} ({n.FunctionString}) [{n.Location.StartLine}, {n.Location.StartColumn}]");
            Tab();

            Helpers.WriteLine($"{_tab}Expression");
            Tab();
            n.Expression?.Accept(this);
            Untab();

            Untab();
        }

        public void Visit(Incrementer n)
        {
            Helpers.WriteLine($"{_tab}{n.Text} [{n.Location.StartLine}, {n.Location.StartColumn}]");
            Tab();

            Helpers.WriteLine($"{_tab}Identifier: {n.IdentifierName}");
            Helpers.WriteLine($"{_tab}Operation: {n.Operator}");

            if (n.IncrementExpression != null)
            {
                Helpers.WriteLine("IncrementExpression");
                Tab();
                n.IncrementExpression.Accept(this);
                Untab();

                Untab();
            }
        }

        #endregion

        #region Expression AST Nodes

        public void Visit(And n)
        {
            Helpers.WriteLine($"{_tab}{n.Text} [{n.Location.StartLine}, {n.Location.StartColumn}]");
            Tab();

            Helpers.WriteLine($"{_tab}Left");
            Tab();
            n.LeftExpression.Accept(this);
            Untab();
            Helpers.WriteLine($"{_tab}Right");
            Tab();
            n.RightExpression.Accept(this);
            Untab();

            Untab();
        }

        public void Visit(Or n)
        {
            Helpers.WriteLine($"{_tab}{n.Text} [{n.Location.StartLine}, {n.Location.StartColumn}]");
            Tab();

            Helpers.WriteLine($"{_tab}Left");
            Tab();
            n.LeftExpression.Accept(this);
            Untab();
            Helpers.WriteLine($"{_tab}Right");
            Tab();
            n.RightExpression.Accept(this);
            Untab();

            Untab();
        }

        public void Visit(Less n)
        {
            Helpers.WriteLine($"{_tab}{n.Text} [{n.Location.StartLine}, {n.Location.StartColumn}]");
            Tab();

            Helpers.WriteLine($"{_tab}Left");
            Tab();
            n.LeftExpression.Accept(this);
            Untab();
            Helpers.WriteLine($"{_tab}Right");
            Tab();
            n.RightExpression.Accept(this);
            Untab();

            Untab();
        }

        public void Visit(Greater n)
        {
            Helpers.WriteLine($"{_tab}{n.Text} [{n.Location.StartLine}, {n.Location.StartColumn}]");
            Tab();

            Helpers.WriteLine($"{_tab}Left");
            Tab();
            n.LeftExpression.Accept(this);
            Untab();
            Helpers.WriteLine($"{_tab}Right");
            Tab();
            n.RightExpression.Accept(this);
            Untab();

            Untab();
        }

        public void Visit(LessEqual n)
        {
            Helpers.WriteLine($"{_tab}{n.Text} [{n.Location.StartLine}, {n.Location.StartColumn}]");
            Tab();

            Helpers.WriteLine($"{_tab}Left");
            Tab();
            n.LeftExpression.Accept(this);
            Untab();
            Helpers.WriteLine($"{_tab}Right");
            Tab();
            n.RightExpression.Accept(this);
            Untab();

            Untab();
        }

        public void Visit(GreaterEqual n)
        {
            Helpers.WriteLine($"{_tab}{n.Text} [{n.Location.StartLine}, {n.Location.StartColumn}]");
            Tab();

            Helpers.WriteLine($"{_tab}Left");
            Tab();
            n.LeftExpression.Accept(this);
            Untab();
            Helpers.WriteLine($"{_tab}Right");
            Tab();
            n.RightExpression.Accept(this);
            Untab();

            Untab();
        }
        
        public void Visit(Instanceof n)
        {
            Helpers.WriteLine($"{_tab}{n.Text} [{n.Location.StartLine}, {n.Location.StartColumn}]");
            Tab();

            Helpers.WriteLine($"{_tab}Left");
            Tab();
            n.LeftExpression.Accept(this);
            Untab();
            Helpers.WriteLine($"{_tab}Right");
            Tab();
            Helpers.WriteLine($"{_tab}{n.TypeNameToCheck}");
            Untab();

            Untab();
        }

        public void Visit(NotEqual n)
        {
            Helpers.WriteLine($"{_tab}{n.Text} [{n.Location.StartLine}, {n.Location.StartColumn}]");
            Tab();

            Helpers.WriteLine($"{_tab}Left");
            Tab();
            n.LeftExpression.Accept(this);
            Untab();
            Helpers.WriteLine($"{_tab}Right");
            Tab();
            n.RightExpression.Accept(this);
            Untab();

            Untab();
        }

        public void Visit(Equal n)
        {
            Helpers.WriteLine($"{_tab}{n.Text} [{n.Location.StartLine}, {n.Location.StartColumn}]");
            Tab();

            Helpers.WriteLine($"{_tab}Left");
            Tab();
            n.LeftExpression.Accept(this);
            Untab();
            Helpers.WriteLine($"{_tab}Right");
            Tab();
            n.RightExpression.Accept(this);
            Untab();

            Untab();
        }

        public void Visit(Plus n)
        {
            Helpers.WriteLine($"{_tab}{n.Text} [{n.Location.StartLine}, {n.Location.StartColumn}]");
            Tab();

            Helpers.WriteLine($"{_tab}Left");
            Tab();
            n.LeftExpression.Accept(this);
            Untab();
            Helpers.WriteLine($"{_tab}Right");
            Tab();
            n.RightExpression.Accept(this);
            Untab();

            Untab();
        }

        public void Visit(Minus n)
        {
            Helpers.WriteLine($"{_tab}{n.Text} [{n.Location.StartLine}, {n.Location.StartColumn}]");
            Tab();

            Helpers.WriteLine($"{_tab}Left");
            Tab();
            n.LeftExpression.Accept(this);
            Untab();
            Helpers.WriteLine($"{_tab}Right");
            Tab();
            n.RightExpression.Accept(this);
            Untab();

            Untab();
        }

        public void Visit(Mod n)
        {
            Helpers.WriteLine($"{_tab}{n.Text} [{n.Location.StartLine}, {n.Location.StartColumn}]");
            Tab();

            Helpers.WriteLine($"{_tab}Left");
            Tab();
            n.LeftExpression.Accept(this);
            Untab();
            Helpers.WriteLine($"{_tab}Right");
            Tab();
            n.RightExpression.Accept(this);
            Untab();

            Untab();
        }

        public void Visit(Divide n)
        {
            Helpers.WriteLine($"{_tab}{n.Text} [{n.Location.StartLine}, {n.Location.StartColumn}]");
            Tab();

            Helpers.WriteLine($"{_tab}Left");
            Tab();
            n.LeftExpression.Accept(this);
            Untab();
            Helpers.WriteLine($"{_tab}Right");
            Tab();
            n.RightExpression.Accept(this);
            Untab();

            Untab();
        }

        public void Visit(Multiply n)
        {
            Helpers.WriteLine($"{_tab}{n.Text} [{n.Location.StartLine}, {n.Location.StartColumn}]");
            Tab();

            Helpers.WriteLine($"{_tab}Left");
            Tab();
            n.LeftExpression.Accept(this);
            Untab();
            Helpers.WriteLine($"{_tab}Right");
            Tab();
            n.RightExpression.Accept(this);
            Untab();

            Untab();
        }

        public void Visit(ArrayAccess n)
        {
            Helpers.WriteLine($"{_tab}{n.Text} [{n.Location.StartLine}, {n.Location.StartColumn}]");
            Tab();

            Helpers.WriteLine($"{_tab}Array");
            Tab();
            n.Array.Accept(this);
            Untab();
            Helpers.WriteLine($"{_tab}Index");
            Tab();
            n.Index.Accept(this);
            Untab();

            Untab();
        }

        public void Visit(ArrayLength n)
        {
            Helpers.WriteLine($"{_tab}{n.Text} [{n.Location.StartLine}, {n.Location.StartColumn}]");
            Tab();

            Helpers.WriteLine($"{_tab}Array");
            Tab();
            n.Array.Accept(this);
            Untab();

            Untab();
        }

        public void Visit(Cast n)
        {
            Helpers.WriteLine($"{_tab}{n.Text} [{n.Location.StartLine}, {n.Location.StartColumn}]");
            Tab();

            Helpers.WriteLine($"{_tab}Expression");
            Tab();
            n.Expression.Accept(this);
            Untab();
            Helpers.WriteLine($"{_tab}Type");
            Tab();
            Helpers.WriteLine($"{_tab}{n.TypeNameToCast}");
            Untab();

            Untab();
        }

        public void Visit(Integer n)
        {
            Helpers.WriteLine($"{_tab}{n.Text} ({n.Value}) [{n.Location.StartLine}, {n.Location.StartColumn}]");
        }

        public void Visit(String n)
        {
            Helpers.WriteLine($"{_tab}{n.Text} ({n.Str}) [{n.Location.StartLine}, {n.Location.StartColumn}]");
        }

        public void Visit(True n)
        {
            Helpers.WriteLine($"{_tab}{n.Text} [{n.Location.StartLine}, {n.Location.StartColumn}]");
        }

        public void Visit(False n)
        {
            Helpers.WriteLine($"{_tab}{n.Text} [{n.Location.StartLine}, {n.Location.StartColumn}]");
        }

        public void Visit(Null n)
        {
            Helpers.WriteLine($"{_tab}{n.Text} [{n.Location.StartLine}, {n.Location.StartColumn}]");
        }

        public void Visit(IdentifierExpression n)
        {
            Helpers.WriteLine($"{_tab}{n.Text} ({n.Name}) [{n.Location.StartLine}, {n.Location.StartColumn}]");
        }

        public void Visit(This n)
        {
            Helpers.WriteLine($"{_tab}{n.Text} [{n.Location.StartLine}, {n.Location.StartColumn}]");
        }

        public void Visit(NewArray n)
        {
            Helpers.WriteLine($"{_tab}{n.Text} [{n.Location.StartLine}, {n.Location.StartColumn}]");
            Tab();

            Helpers.WriteLine($"{_tab}Size");
            Tab();
            n.Size.Accept(this);
            Untab();

            Untab();
        }

        public void Visit(NewObject n)
        {
            Helpers.WriteLine($"{_tab}{n.Text} ({n.Name}) [{n.Location.StartLine}, {n.Location.StartColumn}]");
        }

        public void Visit(Not n)
        {
            Helpers.WriteLine($"{_tab}{n.Text} [{n.Location.StartLine}, {n.Location.StartColumn}]");
            Tab();

            Helpers.WriteLine($"{_tab}Expression");
            Tab();
            n.Expression.Accept(this);
            Untab();

            Untab();
        }

        public void Visit(Parenthetical n)
        {
            Helpers.WriteLine($"{_tab}{n.Text} [{n.Location.StartLine}, {n.Location.StartColumn}]");
            Tab();

            Helpers.WriteLine($"{_tab}Expression");
            Tab();
            n.Expression.Accept(this);
            Untab();

            Untab();
        }

        #endregion
    }
}
