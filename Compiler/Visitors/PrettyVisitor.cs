using System;
using System.Diagnostics;
using System.Linq;
using Compiler.Ast;

namespace Compiler.Visitors
{
    internal class PrettyVisitor : IPlainVisitor
    {
        #region Helpers

        private string _tab = "";

        private void Tab()
        {
            _tab += "    ";
        }

        private void Untab()
        {
            _tab = _tab.Substring(4);
        }

        #endregion

        #region Top Level AST Nodes

        public void Visit(Goal n)
        {
            n.MainClass.Accept(this);

            foreach (var c in n.ClassList)
            {
                Helpers.WriteLine();
                c.Accept(this);
            }
        }

        public void Visit(MainClass n)
        {
            Helpers.WriteColor($"{_tab}class ", ConsoleColor.DarkCyan, ConsoleColor.Black);
            Helpers.WriteColor(n.Name, ConsoleColor.Green, ConsoleColor.Black);
            Helpers.WriteLine(" { ");
            Tab();
            Helpers.WriteColor($"{_tab}public static void ", ConsoleColor.DarkCyan, ConsoleColor.Black);
            Helpers.WriteColor("main ", ConsoleColor.Green, ConsoleColor.Black);
            Helpers.Write("(String [] ");
            Helpers.WriteColor(n.ArgsName, ConsoleColor.Green, ConsoleColor.Black);
            Helpers.WriteLine(") {");
            Tab();
            n.MainMethodBody.Accept(this);
            Untab();
            Helpers.WriteLine();
            Helpers.WriteLine($"{_tab}}}");
            Untab();
            Helpers.WriteLine($"{_tab}}}");
        }

        public void Visit(AstClass n)
        {
            Helpers.Write(_tab);
            Helpers.WriteColor("class ", ConsoleColor.DarkCyan, ConsoleColor.Black);
            Helpers.WriteColor(n.Name, ConsoleColor.Green, ConsoleColor.Black);

            n.ClassExtension?.Accept(this);

            Helpers.WriteLine(" { ");
            Tab();
            foreach (var v in n.ClassDeclarationList.OfType<Property>())
            {
                v.Accept(this);
                Helpers.WriteLine();
            }
            foreach (var m in n.ClassDeclarationList.OfType<Method>())
            {
                m.Accept(this);
                Helpers.WriteLine();
            }
            Untab();
            Helpers.WriteLine($"{_tab}}}");
        }

        public void Visit(ClassExtension n)
        {
            Helpers.WriteColor(" extends ", ConsoleColor.DarkCyan, ConsoleColor.Black);
            Helpers.WriteColor(n.Name, ConsoleColor.Green, ConsoleColor.Black);
        }

        #endregion

        #region Method AST Nodes

        public void Visit(Variable n)
        {
            Debugger.Break();
            Helpers.Write(_tab);
            n.AstType.Accept(this);
            Helpers.WriteColor($" {n.Name}", ConsoleColor.Green, ConsoleColor.Black);
            Helpers.Write(";");
        }

        public void Visit(Property n)
        {
            Helpers.Write(_tab);
            n.AstType.Accept(this);
            Helpers.WriteColor($" {n.Name}", ConsoleColor.Green, ConsoleColor.Black);
            Helpers.Write(";");
        }

        public void Visit(Method n)
        {
            Helpers.WriteColor($"{_tab}public ", ConsoleColor.DarkCyan, ConsoleColor.Black);
            if(n.ReturnAstType == null)
                Helpers.WriteColor("void", ConsoleColor.DarkCyan, ConsoleColor.Black);
            else
                n.ReturnAstType.Accept(this);
            Helpers.WriteColor($" {n.Name} ", ConsoleColor.Green, ConsoleColor.Black);
            Helpers.Write("(");
            foreach (var s in n.ArgumentList)
            {
                s.Accept(this);
                if(s != n.ArgumentList.Last())
                    Helpers.Write(", ");
            }
            Helpers.WriteLine(") ");
            n.Statement.Accept(this);
        }

        public void Visit(Argument n)
        {
            n.AstType.Accept(this);
            Helpers.WriteColor($" {n.Name}", ConsoleColor.Green, ConsoleColor.Black);
        }

        #endregion

        #region Type AST Nodes

        public void Visit(IntArray n)
        {
            Helpers.WriteColor("int []", ConsoleColor.DarkCyan, ConsoleColor.Black);
        }

        public void Visit(AstBoolean n)
        {
            Helpers.WriteColor("boolean", ConsoleColor.DarkCyan, ConsoleColor.Black);
        }

        public void Visit(Int n)
        {
            Helpers.WriteColor("int", ConsoleColor.DarkCyan, ConsoleColor.Black);
        }

        public void Visit(AstString n)
        {
            Helpers.WriteColor("String", ConsoleColor.DarkCyan, ConsoleColor.Black);
        }

        public void Visit(Custom n)
        {
            Helpers.WriteColor(n.Name, ConsoleColor.Green, ConsoleColor.Black);
        }

        #endregion

        #region Statement AST Nodes

        public void Visit(VariableDeclaration n)
        {
            Helpers.Write(_tab);
            n.AstType.Accept(this);
            Helpers.WriteColor($" {n.Name}", ConsoleColor.Green, ConsoleColor.Black);
            Helpers.Write(";");
        }

        public void Visit(Block n)
        {
            Helpers.WriteLine($"{_tab}{{ ");
            Tab();
            foreach(var s in n.StatementList)
            {
                s.Accept(this);
                Helpers.WriteLine();
            }
            Untab();
            Helpers.WriteLine($"{_tab}}} ");
        }

        public void Visit(If n)
        {
            Helpers.WriteColor($"{_tab}if ", ConsoleColor.DarkCyan, ConsoleColor.Black);
            Helpers.Write("(");
            n.Test.Accept(this);
            Helpers.WriteLine(") ");
            Tab();
            n.True.Accept(this);
            Helpers.WriteLine();
            Untab();
            Helpers.WriteLineColor($"{_tab}else ", ConsoleColor.DarkCyan, ConsoleColor.Black);
            Tab();
            n.False.Accept(this);
            Untab();
        }

        public void Visit(While n)
        {
            Helpers.WriteColor($"{_tab}while ", ConsoleColor.DarkCyan, ConsoleColor.Black);
            Helpers.Write("(");
            n.Test.Accept(this);
            Helpers.WriteLine(") ");
            Tab();
            n.Action.Accept(this);
            Untab();
        }

        public void Visit(For n)
        {
            Helpers.WriteColor($"{_tab}for ", ConsoleColor.DarkCyan, ConsoleColor.Black);
            Helpers.Write("(");
            n.Initialize.Accept(this);
            Helpers.Write("; ");
            n.Test.Accept(this);
            Helpers.Write("; ");
            n.Afterthought.Accept(this);
            Helpers.WriteLine(") ");
            Tab();
            n.Action.Accept(this);
            Untab();
        }

        public void Visit(Return n)
        {
            Helpers.WriteColor($"{_tab}return ", ConsoleColor.DarkCyan, ConsoleColor.Black);
            n.Expression?.Accept(this);
            Helpers.Write(";");
        }

        public void Visit(ExpressionStatementStatement n)
        {
            Helpers.Write(_tab);
            n.ExpressionStatement.Accept(this);
            Helpers.Write(";");
        }

        #endregion

        #region Expression Statement AST Nodes

        public void Visit(Assignment n)
        {
            Helpers.WriteColor($"{n.DestinationName}", ConsoleColor.Green, ConsoleColor.Black);
            Helpers.Write(" = ");
            n.Source.Accept(this);
        }

        public void Visit(DeclarationAssignment n)
        {
            n.AstType.Accept(this);
            Helpers.WriteColor($" {n.DestinationName}", ConsoleColor.Green, ConsoleColor.Black);
            Helpers.Write(" = ");
            n.Source.Accept(this);
        }

        public void Visit(ArrayAssignment n)
        {
            n.Destination.Accept(this);
            Helpers.Write("[");
            n.Index.Accept(this);
            Helpers.Write("] = ");
            n.Source.Accept(this);
        }

        public void Visit(MethodCall n)
        {
            n.Source.Accept(this);
            Helpers.Write(".");
            Helpers.WriteColor(n.Name, ConsoleColor.Green, ConsoleColor.Black);
            Helpers.Write("(");
            foreach (var s in n.Arguments)
            {
                s.Accept(this);
                if (s != n.Arguments.Last())
                    Helpers.Write(", ");
            }
            Helpers.Write(")");
        }

        public void Visit(CompilerFunction n)
        {
            Helpers.WriteColor($"{n.FunctionString} ", ConsoleColor.DarkCyan, ConsoleColor.Black);
            Helpers.Write("(");
            n.Expression?.Accept(this);
            Helpers.Write(")");
        }

        public void Visit(Incrementer n)
        {
            Helpers.Write($"{n.IdentifierName}{n.Operator}");
            if (n.IncrementExpression != null)
            {
                Helpers.Write(" ");
                n.IncrementExpression.Accept(this);
            }
        }

        #endregion

        #region Expression AST Nodes

        public void Visit(And n)
        {
            Helpers.Write("(");
            n.LeftExpression.Accept(this);
            Helpers.Write(" && ");
            n.RightExpression.Accept(this);
            Helpers.Write(")");
        }

        public void Visit(Or n)
        {
            Helpers.Write("(");
            n.LeftExpression.Accept(this);
            Helpers.Write(" || ");
            n.RightExpression.Accept(this);
            Helpers.Write(")");
        }

        public void Visit(Less n)
        {
            Helpers.Write("(");
            n.LeftExpression.Accept(this);
            Helpers.Write(" < ");
            n.RightExpression.Accept(this);
            Helpers.Write(")");
        }

        public void Visit(Greater n)
        {
            Helpers.Write("(");
            n.LeftExpression.Accept(this);
            Helpers.Write(" > ");
            n.RightExpression.Accept(this);
            Helpers.Write(")");
        }

        public void Visit(LessEqual n)
        {
            Helpers.Write("(");
            n.LeftExpression.Accept(this);
            Helpers.Write(" <= ");
            n.RightExpression.Accept(this);
            Helpers.Write(")");
        }

        public void Visit(GreaterEqual n)
        {
            Helpers.Write("(");
            n.LeftExpression.Accept(this);
            Helpers.Write(" >= ");
            n.RightExpression.Accept(this);
            Helpers.Write(")");
        }

        public void Visit(Instanceof n)
        {
            Helpers.Write("(");
            n.LeftExpression.Accept(this);
            Helpers.Write($" instanceof {n.TypeNameToCheck}");
            Helpers.Write(")");
        }

        public void Visit(NotEqual n)
        {
            Helpers.Write("(");
            n.LeftExpression.Accept(this);
            Helpers.Write(" != ");
            n.RightExpression.Accept(this);
            Helpers.Write(")");
        }

        public void Visit(Equal n)
        {
            Helpers.Write("(");
            n.LeftExpression.Accept(this);
            Helpers.Write(" == ");
            n.RightExpression.Accept(this);
            Helpers.Write(")");
        }

        public void Visit(Plus n)
        {
            Helpers.Write("(");
            n.LeftExpression.Accept(this);
            Helpers.Write(" + ");
            n.RightExpression.Accept(this);
            Helpers.Write(")");
        }

        public void Visit(Minus n)
        {
            Helpers.Write("(");
            n.LeftExpression.Accept(this);
            Helpers.Write(" - ");
            n.RightExpression.Accept(this);
            Helpers.Write(")");
        }

        public void Visit(Mod n)
        {
            Helpers.Write("(");
            n.LeftExpression.Accept(this);
            Helpers.Write(" % ");
            n.RightExpression.Accept(this);
            Helpers.Write(")");
        }

        public void Visit(Divide n)
        {
            Helpers.Write("(");
            n.LeftExpression.Accept(this);
            Helpers.Write(" / ");
            n.RightExpression.Accept(this);
            Helpers.Write(")");
        }

        public void Visit(Multiply n)
        {
            Helpers.Write("(");
            n.LeftExpression.Accept(this);
            Helpers.Write(" * ");
            n.RightExpression.Accept(this);
            Helpers.Write(")");
        }

        public void Visit(ArrayAccess n)
        {
            n.Array.Accept(this);
            Helpers.Write("[");
            n.Index.Accept(this);
            Helpers.Write("]");
        }

        public void Visit(ArrayLength n)
        {
            n.Array.Accept(this);
            Helpers.Write(".length");
        }

        public void Visit(Cast n)
        {
            Helpers.Write($"(({n.TypeNameToCast})");
            n.Expression.Accept(this);
            Helpers.Write(")");
        }

        public void Visit(Integer n)
        {
            Helpers.WriteColor(n.Value.ToString(), ConsoleColor.DarkMagenta, ConsoleColor.Black);
        }

        public void Visit(Ast.String n)
        {
            Helpers.WriteColor(n.Str, ConsoleColor.DarkMagenta, ConsoleColor.Black);
        }

        public void Visit(True n)
        {
            Helpers.WriteColor("true", ConsoleColor.DarkMagenta, ConsoleColor.Black);
        }

        public void Visit(False n)
        {
            Helpers.WriteColor("false", ConsoleColor.DarkMagenta, ConsoleColor.Black);
        }

        public void Visit(Null n)
        {
            Helpers.WriteColor("null", ConsoleColor.DarkMagenta, ConsoleColor.Black);
        }

        public void Visit(IdentifierExpression n)
        {
            Helpers.WriteColor(n.Name, ConsoleColor.Green, ConsoleColor.Black);
        }

        public void Visit(This n)
        {
            Helpers.WriteColor("this", ConsoleColor.DarkMagenta, ConsoleColor.Black);
        }

        public void Visit(NewArray n)
        {
            Helpers.WriteColor("new int ", ConsoleColor.DarkCyan, ConsoleColor.Black);
            Helpers.Write("[");
            n.Size.Accept(this);
            Helpers.Write("]");
        }

        public void Visit(NewObject n)
        {
            Helpers.WriteColor("new ", ConsoleColor.DarkCyan, ConsoleColor.Black);
            Helpers.WriteColor(n.Name, ConsoleColor.Green, ConsoleColor.Black);
            Helpers.Write("()");
        }

        public void Visit(Not n)
        {
            Helpers.Write("!");
            n.Expression.Accept(this);
        }

        public void Visit(Parenthetical n)
        {
            Helpers.Write("(");
            n.Expression.Accept(this);
            Helpers.Write(")");
        }

        #endregion
    }
}
