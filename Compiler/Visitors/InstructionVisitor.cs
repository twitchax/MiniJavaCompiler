using System;
using System.Linq;
using System.Text;
using Compiler.Ast;
using Compiler.Semantics;

namespace Compiler.Visitors
{
    class InstructionVisitor : IPlainVisitor
    {
        #region Helpers

        private ClassMethod CurrentMethod { get; set; }
        private ClassMethodBlock CurrentBlock { get; set; }

        private void GetIdentifier(string name)
        {
            Globals.Builder.Start("get identifier");

            string location = null;
            
            if (CurrentBlock.HasLocal(name))
                location = $"[rbp - {CurrentBlock.GetLocal(name).Position + 1} * 8]";
            else if (CurrentMethod.Arguments.ContainsKey(name))
                location = $"[rbp + 16 + {CurrentMethod.Arguments.GetKeyIndex(name) + 1} * 8]";
            else if (CurrentMethod.OwnerClass.HasProperty(name))
            {
                Globals.Builder.WriteBinaryOp("mov", "r10", "[rbp + 16]"); // this
                location = $"[r10+{CurrentMethod.OwnerClass.GetPropertyIndex(name) + 1} * 8]";
            }

            Globals.Builder.WriteBinaryOp("lea", "rax", location);

            Globals.Builder.End("get identifier");
        }

        private void WriteBinaryExpression(string op, Expression exp1, Expression exp2)
        {
            exp2.Accept(this);
            Globals.Builder.WriteUnaryOp("push", "rax");
            exp1.Accept(this);
            Globals.Builder.WriteUnaryOp("pop", "r10");
            Globals.Builder.WriteBinaryOp(op, "rax", "r10");
        }

        // Pointer is in rax.
        private void GetPointer(Expression o, bool check = true)
        {
            Globals.Builder.Start($"get pointer and check [{o.Location.StartLine}, {o.Location.StartColumn}]");

            o.Accept(this);

            if (check)
            {
                Globals.Builder.WriteUnaryOp("push", "rax");

                var labelNotNull = $"whewNotNull{Globals.Builder.Count()}";
                var labelNotFreed = $"whewNotFreed{Globals.Builder.Count()}";

                // Check if null.
                Globals.Builder.WriteBinaryOp("cmp", "rax", 0.ToString());
                Globals.Builder.WriteUnaryOp("jne", labelNotNull);
                Globals.Builder.RuntimeErrorAndExit(6, $"Null reference at [{o.Location.StartLine}, {o.Location.StartColumn}].");
                Globals.Builder.WriteLabel(labelNotNull);

                // Check if in heap.
                Globals.Builder.WriteBinaryOp("mov", "rcx", "rax");
                Globals.Builder.WriteCall("_CrtIsValidHeapPointer");
                Globals.Builder.WriteBinaryOp("cmp", "rax", 0.ToString());
                Globals.Builder.WriteUnaryOp("jne", labelNotFreed);
                Globals.Builder.RuntimeErrorAndExit(9, $"Memory previously freed at [{o.Location.StartLine}, {o.Location.StartColumn}].");
                Globals.Builder.WriteLabel(labelNotFreed);

                Globals.Builder.WriteUnaryOp("pop", "rax");
            }

            Globals.Builder.End($"get pointer and check [{o.Location.EndLine}, {o.Location.EndColumn}]");
        }

        // Array pointer is in rax.
        // Array index is in r10.
        // NOTE: Cannot call anything after this; otherwise, push rax and r10.
        private void GetArrayAtIndex(Expression array, Expression index)
        {
            Globals.Builder.Start($"get array and check [{array.Location.StartLine}, {array.Location.StartColumn}]");

            index.Accept(this);
            Globals.Builder.WriteUnaryOp("push", "rax");
            array.Accept(this);
            Globals.Builder.WriteUnaryOp("pop", "r10");

            // Check that the array is not null and the index is all good.
            var labelEnd1 = $"whewTheArrayIsNotNull{Globals.Builder.Count()}";
            var labelEnd2 = $"whewTheArrayIndexIsNotHigh{Globals.Builder.Count()}";
            var labelEnd3 = $"whewTheArrayIndexIsNotLow{Globals.Builder.Count()}";

            // Check if array pointer is null.
            Globals.Builder.WriteBinaryOp("cmp", "rax", 0.ToString());
            Globals.Builder.WriteUnaryOp("jne", labelEnd1);
            Globals.Builder.RuntimeErrorAndExit(6, $"Array null reference at [{array.Location.StartLine}, {array.Location.StartColumn}].");
            Globals.Builder.WriteLabel(labelEnd1);

            // Check if the index is greater than the length.
            Globals.Builder.WriteBinaryOp("cmp", "r10", "[rax]");
            Globals.Builder.WriteUnaryOp("jl", labelEnd2);
            Globals.Builder.RuntimeErrorAndExit(1734, $"Array index is out of bounds (> length) at [{index.Location.StartLine}, {index.Location.StartColumn}].");
            Globals.Builder.WriteLabel(labelEnd2);

            // Check if the index is less than 0.
            Globals.Builder.WriteBinaryOp("cmp", "r10", 0.ToString());
            Globals.Builder.WriteUnaryOp("jge", labelEnd3);
            Globals.Builder.RuntimeErrorAndExit(1734, $"Array index is out of bounds (< 0) at [{index.Location.StartLine}, {index.Location.StartColumn}].");
            Globals.Builder.WriteLabel(labelEnd3);

            Globals.Builder.End($"get array and check [{array.Location.EndLine}, {array.Location.EndColumn}]");
        }

        // rax will have the pointer if valid, or null if not.
        private void CanCast(Expression pointer, Class typeToCheck, bool check = true)
        {
            Globals.Builder.Start($"can cast [{pointer.Location.StartLine}, {pointer.Location.StartColumn}]");

            var labelStart = $"cancastStart{Globals.Builder.Count()}";
            var labelTrue = $"cancastTrue{Globals.Builder.Count()}";
            var labelFalse = $"cancastFalse{Globals.Builder.Count()}";
            var labelEnd = $"cancastEnd{Globals.Builder.Count()}";

            GetPointer(pointer, check);
            Globals.Builder.WriteUnaryOp("push", "rax");

            // If the pointer is null, then we can't cast.
            Globals.Builder.WriteBinaryOp("cmp", "rax", 0.ToString());
            Globals.Builder.WriteUnaryOp("je", labelFalse);

            Globals.Builder.WriteBinaryOp("mov", "rax", "[rax]"); // rax has the pointer to its vtable.

            // Get the effective address of the type we are checking against.
            Globals.Builder.WriteBinaryOp("lea", "r10", $"{typeToCheck.ClassTableName}");

            Globals.Builder.WriteLabel(labelStart);

            // Test if the object is of the type whose vtable is in r10.
            Globals.Builder.WriteBinaryOp("cmp", "rax", "r10");
            Globals.Builder.WriteUnaryOp("je", labelTrue);

            // Get pointer to base class vtable in rax.
            Globals.Builder.WriteBinaryOp("mov", "rax", "[rax]");

            // Test if we have hit the end of the inheritance chain.
            Globals.Builder.WriteBinaryOp("cmp", "rax", 0.ToString());
            Globals.Builder.WriteUnaryOp("je", labelFalse);

            // Load the pointer to the base class and repeat.
            Globals.Builder.WriteUnaryOp("jmp", labelStart);

            Globals.Builder.WriteLabel(labelTrue);
            Globals.Builder.WriteUnaryOp("pop", "rax");
            Globals.Builder.WriteUnaryOp("jmp", labelEnd);

            Globals.Builder.WriteLabel(labelFalse);
            Globals.Builder.WriteUnaryOp("pop", "rax");
            Globals.Builder.WriteBinaryOp("mov", "rax", 0.ToString());

            Globals.Builder.WriteLabel(labelEnd);

            Globals.Builder.End($"can cast [{pointer.Location.EndLine}, {pointer.Location.EndColumn}]");
        }

        #endregion

        #region Top Level AST Nodes

        public void Visit(Goal n)
        {
            Globals.Builder.WritePreamble();

            Globals.Builder.WriteStartCode();

            // We already have the class information embedded, so start emmitting statements.
            foreach (var t in Globals.TypeTable.EnumerateValues().Where(t => !t.IsPrimitive).Cast<Class>().Where(c => !c.IsMainClass))
            {
                foreach (var m in t.Methods.EnumerateValues())
                {
                    CurrentMethod = m;
                    CurrentBlock = null;

                    Globals.Builder.Tab();
                    Globals.Builder.WriteLabel(m.MethodTableName, $"[{n.Location.StartLine}, {n.Location.StartColumn}]");
                    Globals.Builder.Write();
                    Globals.Builder.Tab();
                    
                    Globals.Builder.Start("prologue");
                    Globals.Builder.WriteUnaryOp("push", "rbp");
                    Globals.Builder.WriteBinaryOp("mov", "rbp", "rsp");
                    Globals.Builder.WriteLocalCreation(m.LocalCount);
                    Globals.Builder.WriteBinaryOp("mov", "[rbp + 16]", "rcx");
                    Globals.Builder.WriteBinaryOp("mov", "[rbp + 24]", "rdx");
                    Globals.Builder.WriteBinaryOp("mov", "[rbp + 32]", "r8");
                    Globals.Builder.WriteBinaryOp("mov", "[rbp + 40]", "r9");
                    Globals.Builder.End("prologue");

                    Globals.Builder.Start("statements");
                    m.MethodBody.AstBlock.Accept(this);
                    Globals.Builder.End("statements");

                    Globals.Builder.WriteLabel(m.ReturnLabelName);

                    Globals.Builder.Start("epilogue");
                    Globals.Builder.WriteBinaryOp("mov", "rsp", "rbp");
                    Globals.Builder.WriteUnaryOp("pop", "rbp");
                    Globals.Builder.End("epilogue");

                    Globals.Builder.Write("ret");

                    Globals.Builder.Untab();
                    Globals.Builder.Untab();
                }
            }

            foreach (var t in Globals.TypeTable.EnumerateValues().Where(t => !t.IsPrimitive).Cast<Class>().Where(c => c.IsMainClass))
            {
                CurrentMethod = null;
                CurrentBlock = null;

                Globals.Builder.Tab();
                Globals.Builder.Write("mainCRTStartup proc", $"[{n.Location.StartLine}, {n.Location.StartColumn}] Main method.");
                Globals.Builder.Write();
                Globals.Builder.Tab();
                
                Globals.Builder.Start("statements");
                t.Methods.Values.First().MethodBody.AstBlock.Accept(this);
                Globals.Builder.End("statements");

                Globals.Builder.Write();
                Globals.Builder.WriteComment("Main Epilogue.");
                Globals.Builder.WriteBinaryOp("mov", "rcx", "0");
                Globals.Builder.WriteCall("_exit");
                Globals.Builder.Write("ret");

                Globals.Builder.Untab();
                Globals.Builder.Write("mainCRTStartup endp");
                Globals.Builder.Untab();
            }

            // Data section.
            Globals.Builder.Write(".data");
            Globals.Builder.Tab();

            // Vtables.
            foreach (var t in Globals.TypeTable.EnumerateValues().Where(t => !t.IsPrimitive).Cast<Class>().Where(c => !c.IsMainClass))
            {
                var builder = new StringBuilder();

                builder.Append($"{t.ClassTableName} qword ");

                builder.Append(t.BaseClass != null ? $"{t.BaseClass.ClassTableName}, " : "0, ");

                foreach (var m in t.MethodTableEnumerator())
                {
                    builder.Append(m.MethodTableName + ", ");
                }
                builder.Append(0);

                Globals.Builder.Write(builder.ToString());
            }

            // Strings.
            Globals.Builder.Write("$$true byte 'true', 0");
            Globals.Builder.Write("$$false byte 'false', 0");
            foreach (var kvp in Globals.StringTable)
            {
                if (kvp.Key.Length == 2 /* empty */)
                    Globals.Builder.Write($"{kvp.Value} byte 0");
                else
                {
                    var str = kvp.Key.Replace('\"', '\'');

                    int beforeLength;
                    do
                    {
                        beforeLength = str.Length;

                        str = str
                            .Replace("'\n", "10, '")
                            .Replace("\n'", "', 10");
                    } while (beforeLength != str.Length);
                    str = str.Replace("\n", "', 10, '");

                    Globals.Builder.Write($"{kvp.Value} byte {str}, 0");
                }
            }

            Globals.Builder.Untab();

            Globals.Builder.WriteEnd();
        }

        public void Visit(MainClass n)
        {
            // Unneded.
            throw new NotImplementedException();
        }

        public void Visit(AstClass n)
        {
            // Unneeded.
            throw new NotImplementedException();
        }

        public void Visit(ClassExtension n)
        {
            // Unneeded.
            throw new NotImplementedException();
        }

        #endregion

        #region Method AST Nodes

        public void Visit(Variable n)
        {
            // Unneded.
            throw new NotImplementedException();
        }

        public void Visit(Property n)
        {
            // Unneeded.
            throw new NotImplementedException();
        }

        public void Visit(Method n)
        {
            // Unneeded.
            throw new NotImplementedException();
        }

        public void Visit(Argument n)
        {
            // Unneeded.
            throw new NotImplementedException();
        }

        #endregion

        #region Type AST Nodes

        public void Visit(IntArray n)
        {
            throw new NotImplementedException();
        }

        public void Visit(AstBoolean n)
        {
            throw new NotImplementedException();
        }

        public void Visit(Int n)
        {
            throw new NotImplementedException();
        }

        public void Visit(AstString n)
        {
            throw new NotImplementedException();
        }

        public void Visit(Custom n)
        {
            throw new NotImplementedException();
        }

        #endregion

        #region Statement AST Nodes

        public void Visit(VariableDeclaration n)
        {
            // Unneeded.
        }

        public void Visit(Block n)
        {
            var previousBlock = CurrentBlock;
            CurrentBlock = n.AssociatedSemanticBlock;

            Globals.Builder.Start($"block [{n.Location.StartLine}, {n.Location.StartColumn}]");

            // For labels, if needed.
            var labelStart = $"forStart{Globals.Builder.Count()}";
            var labelEnd = $"forEnd{Globals.Builder.Count()}";
            if (n.OptionalFor != null)
            {
                n.OptionalFor.Initialize.Accept(this);
                n.OptionalFor.Test.Accept(this);

                Globals.Builder.WriteBinaryOp("cmp", "rax", 1.ToString());

                Globals.Builder.WriteUnaryOp("jne", labelEnd);

                Globals.Builder.WriteLabel(labelStart);
            }

            foreach (var s in n.StatementList)
            {
                s.Accept(this);
            }

            if (n.OptionalFor != null)
            {
                n.OptionalFor.Afterthought.Accept(this);
                n.OptionalFor.Test.Accept(this);
                Globals.Builder.WriteBinaryOp("cmp", "rax", 1.ToString());
                Globals.Builder.WriteUnaryOp("je", labelStart);

                Globals.Builder.WriteLabel(labelEnd);
            }

            CurrentBlock = previousBlock;

            Globals.Builder.End($"block [{n.Location.EndLine}, {n.Location.EndColumn}]");
        }

        public void Visit(If n)
        {
            Globals.Builder.Start($"if [{n.Location.StartLine}, {n.Location.StartColumn}]");

            n.Test.Accept(this);

            Globals.Builder.WriteBinaryOp("cmp", "rax", 1.ToString());

            var labelFalse = $"ifFalse{Globals.Builder.Count()}";
            var labelEnd = $"ifEnd{Globals.Builder.Count()}";

            Globals.Builder.WriteUnaryOp("jne", labelFalse);
            n.True.Accept(this);
            Globals.Builder.WriteUnaryOp("jmp", labelEnd);
            Globals.Builder.WriteLabel(labelFalse);
            n.False.Accept(this);
            Globals.Builder.WriteLabel(labelEnd);

            Globals.Builder.End($"if [{n.Location.EndLine}, {n.Location.EndColumn}]");
        }

        public void Visit(While n)
        {
            Globals.Builder.Start($"while [{n.Location.StartLine}, {n.Location.StartColumn}]");

            n.Test.Accept(this);

            Globals.Builder.WriteBinaryOp("cmp", "rax", 1.ToString());

            var labelStart = $"whileStart{Globals.Builder.Count()}";
            var labelEnd = $"whileEnd{Globals.Builder.Count()}";

            Globals.Builder.WriteUnaryOp("jne", labelEnd);

            Globals.Builder.WriteLabel(labelStart);
            n.Action.Accept(this);
            n.Test.Accept(this);
            Globals.Builder.WriteBinaryOp("cmp", "rax", 1.ToString());
            Globals.Builder.WriteUnaryOp("je", labelStart);

            Globals.Builder.WriteLabel(labelEnd);

            Globals.Builder.End($"while [{n.Location.EndLine}, {n.Location.EndColumn}]");
        }

        public void Visit(For n)
        {
            Globals.Builder.Start($"for [{n.Location.StartLine}, {n.Location.StartColumn}]");

            n.Action.Accept(this);

            Globals.Builder.End($"for [{n.Location.EndLine}, {n.Location.EndColumn}]");
        }

        public void Visit(Return n)
        {
            n.Expression?.Accept(this);
            Globals.Builder.WriteUnaryOp("jmp", CurrentMethod.ReturnLabelName);
        }

        public void Visit(ExpressionStatementStatement n)
        {
            n.ExpressionStatement.Accept(this);
        }

        #endregion

        #region Expression Statement AST Nodes

        public void Visit(Assignment n)
        {
            Globals.Builder.Start($"assignment ({n.DestinationName}) [{n.Location.StartLine}, {n.Location.StartColumn}]");

            GetIdentifier(n.DestinationName); // rax has pointer to location.
            Globals.Builder.WriteUnaryOp("push", "rax");

            n.Source.Accept(this);

            Globals.Builder.WriteUnaryOp("pop", "r10");
            Globals.Builder.WriteBinaryOp("mov", "[r10]", "rax");

            Globals.Builder.End($"assignment ({n.DestinationName}) [{n.Location.EndLine}, {n.Location.EndColumn}]");
        }

        public void Visit(DeclarationAssignment n)
        {
            Globals.Builder.Start($"assignment ({n.DestinationName}) [{n.Location.StartLine}, {n.Location.StartColumn}]");

            GetIdentifier(n.DestinationName); // rax has pointer to location.
            Globals.Builder.WriteUnaryOp("push", "rax");

            n.Source.Accept(this);

            Globals.Builder.WriteUnaryOp("pop", "r10");
            Globals.Builder.WriteBinaryOp("mov", "[r10]", "rax");

            Globals.Builder.End($"assignment ({n.DestinationName}) [{n.Location.EndLine}, {n.Location.EndColumn}]");
        }

        public void Visit(ArrayAssignment n)
        {
            Globals.Builder.Start($"array assignment [{n.Location.StartLine}, {n.Location.StartColumn}]");

            n.Source.Accept(this);
            Globals.Builder.WriteUnaryOp("push", "rax");

            GetArrayAtIndex(n.Destination, n.Index); // Array is in rax, index is in r10.

            Globals.Builder.WriteBinaryOp("add", "r10", 1.ToString()); // shift index by 1 to account for length.
            Globals.Builder.WriteUnaryOp("pop", "r11");
            Globals.Builder.WriteBinaryOp("mov", "[rax + r10 * 8]", "r11");

            Globals.Builder.WriteBinaryOp("mov", "rax", "r11");

            Globals.Builder.End($"array assignment [{n.Location.EndLine}, {n.Location.EndColumn}]");
        }

        public void Visit(MethodCall n)
        {
            Globals.Builder.Start($"method call ({n.Name}) [{n.Location.StartLine}, {n.Location.StartColumn}]");

            var argumentsOnStack = n.Arguments.Count > 3 ? n.Arguments.Count - 3 : 0;
            var stackAllocated = argumentsOnStack + 1 /* push of this */;

            // Get "this".
            GetPointer(n.Source);
            Globals.Builder.WriteUnaryOp("push", "rax");

            // Set arguments.
            for (int k = n.Arguments.Count - 1; k >= 0; k--)
            {
                n.Arguments[k].Accept(this);

                switch (k)
                {
                    case 0:
                        Globals.Builder.WriteBinaryOp("mov", "rdx", "rax", "arg1"); // move arg1 into rdx.
                        break;
                    case 1:
                        Globals.Builder.WriteBinaryOp("mov", "r8", "rax", "arg2"); // move arg2 into r8.
                        break;
                    case 2:
                        Globals.Builder.WriteBinaryOp("mov", "r9", "rax", "arg3"); // move arg3 into r9.
                        break;
                    default:
                        Globals.Builder.WriteUnaryOp("push", "rax", "arg" + (k + 1));
                        break;
                }
            }

            // Get the "this" pointer back.
            Globals.Builder.WriteBinaryOp("mov", "rax", $"[rsp + {argumentsOnStack} * 8]"); // "this" into rcx.

            // Get method location from method table.
            Globals.Builder.WriteBinaryOp("mov", "rcx", "rax"); // "this" into rcx.
            Globals.Builder.WriteBinaryOp("mov", "r10", "[rax]"); // r10 is vtablePointer.
            Globals.Builder.WriteBinaryOp("mov", "r10", $"[r10 + {(n.Source.RealizedType as Class).GetMethodIndex(n.Name) + 1} * 8]");
            
            Globals.Builder.WriteCall("r10");

            // After the call, remove arguments pushed on the stack.
            Globals.Builder.WriteBinaryOp("add", "rsp", (stackAllocated*8).ToString(), "removing pushed arguemnts.");

            Globals.Builder.End($"method call ({n.Name}) [{n.Location.EndLine}, {n.Location.EndColumn}]");
        }

        public void Visit(CompilerFunction n)
        {
            Globals.Builder.Start($"compiler function ({n.FunctionString}) [{n.Location.StartLine}, {n.Location.StartColumn}]");

            switch (n.FunctionString)
            {
                case "System.compiler.exception": // TODO: Add kill here?
                case "System.out.println":
                    SemanticType realizedType;
                    if (n.Expression == null)
                    {
                        Globals.Builder.WriteBinaryOp("lea", "rax", Globals.StringTable["\"\""], $"[{n.Location.StartLine}, {n.Location.StartColumn}] Explicit string.");
                        realizedType = Primitive.String;
                    }
                    else
                    {
                        n.Expression.Accept(this);
                        realizedType = n.Expression.RealizedType;
                    }

                    Globals.Builder.WriteBinaryOp("mov", "rcx", "rax", "Move result for println expression.");

                    if (realizedType == Primitive.Boolean)
                    {
                        Globals.Builder.WriteBinaryOp("cmp", "rcx", 1.ToString());

                        var labelFalse = $"printBoolFalse{Globals.Builder.Count()}";
                        var labelEnd = $"printBoolEnd{Globals.Builder.Count()}";

                        Globals.Builder.WriteUnaryOp("jne", labelFalse);
                        Globals.Builder.WriteBinaryOp("lea", "rcx", "$$true");
                        Globals.Builder.WriteUnaryOp("jmp", labelEnd);
                        Globals.Builder.WriteLabel(labelFalse);
                        Globals.Builder.WriteBinaryOp("lea", "rcx", "$$false");
                        Globals.Builder.WriteLabel(labelEnd);

                        Globals.Builder.WriteCall("puts", "CompilerFunction call (bool).");
                    }
                    else if (realizedType == Primitive.Int)
                    {
                        Globals.Builder.WriteCall("_writeInt", "CompilerFunction call (int).");
                    }
                    else if (realizedType == Primitive.String)
                    {
                        Globals.Builder.WriteCall("puts", "CompilerFunction call (string).");
                    }
                    break;

                case "System.compiler.destroy":
                    n.Expression.Accept(this);
                    Globals.Builder.WriteBinaryOp("mov", "rcx", "rax");
                    Globals.Builder.WriteCall("free");
                    break;

                case "System.in.readln":
                    // Allocate memory for buffer.
                    Globals.Builder.AllocateMemory(2000.ToString(), 1.ToString(), n.Location);
                    Globals.Builder.WriteBinaryOp("mov", "rcx", "rax");
                    Globals.Builder.WriteCall("gets");
                    // Rax has returned string.
                    break;
                case "System.compiler.atol":
                    n.Expression.Accept(this);
                    Globals.Builder.WriteBinaryOp("mov", "rcx", "rax");
                    Globals.Builder.WriteCall("atol");
                    // rax has the new int.
                    break;
            }

            Globals.Builder.End($"compiler function ({n.FunctionString}) [{n.Location.EndLine}, {n.Location.EndColumn}]");
        }

        public void Visit(Incrementer n)
        {
            Globals.Builder.Start($"incrementer ({n.IdentifierName}{n.Operator}) [{n.Location.StartLine}, {n.Location.StartColumn}]");

            Globals.Builder.WriteUnaryOp("push", "rbx");
            if (n.IncrementExpression != null)
            {
                n.IncrementExpression.Accept(this);
                Globals.Builder.WriteBinaryOp("mov", "rbx", "rax");
            }

            GetIdentifier(n.IdentifierName); // rax has pointer to location.
            Globals.Builder.WriteUnaryOp("push", "rax");

            Globals.Builder.WriteBinaryOp("mov", "rax", "[rax]"); // rax now has the current value.
            Globals.Builder.WriteUnaryOp("push", "rax");

            switch (n.Operator)
            {
                case "++":
                    Globals.Builder.WriteBinaryOp("add", "rax", 1.ToString());
                    break;
                case "--":
                    Globals.Builder.WriteBinaryOp("sub", "rax", 1.ToString());
                    break;
                case "+=":
                    Globals.Builder.WriteBinaryOp("add", "rax", "rbx");
                    break;
                case "-=":
                    Globals.Builder.WriteBinaryOp("sub", "rax", "rbx");
                    break;
                case "*=":
                    Globals.Builder.WriteBinaryOp("imul", "rax", "rbx");
                    break;
                case "/=":
                    // Numerator is rdx:rax, so we will zero out rdx.
                    Globals.Builder.WriteBinaryOp("mov", "rdx", 0.ToString());
                    Globals.Builder.WriteUnaryOp("idiv", "rbx");
                    break;
                case "%=":
                    // Numerator is rdx:rax, so we will zero out rdx.
                    Globals.Builder.WriteBinaryOp("mov", "rdx", 0.ToString());
                    Globals.Builder.WriteUnaryOp("idiv", "rbx");
                    // Remainder is in rdx.
                    Globals.Builder.WriteBinaryOp("mov", "rax", "rdx");
                    break;
            }

            Globals.Builder.WriteUnaryOp("pop", "r11"); // Old value.
            Globals.Builder.WriteUnaryOp("pop", "r10"); // Value location.

            Globals.Builder.WriteBinaryOp("mov", "[r10]", "rax");

            // Restore original value, if needed.
            if (n.IsPostfix)
            {
                Globals.Builder.WriteBinaryOp("mov", "rax", "r11");
            }

            // Restore rbx.
            Globals.Builder.WriteUnaryOp("pop", "rbx");

            Globals.Builder.End($"incrementer ({n.IdentifierName}{n.Operator}) [{n.Location.EndLine}, {n.Location.EndColumn}]");
        }

        #endregion

        #region Expression AST Nodes

        public void Visit(And n)
        {
            Globals.Builder.Start($"and (&&) [{n.Location.StartLine}, {n.Location.StartColumn}]");

            n.LeftExpression.Accept(this);
            Globals.Builder.WriteBinaryOp("cmp", "rax", 1.ToString());
            var labelShortCircuit = $"andShortCircuit{Globals.Builder.Count()}";
            Globals.Builder.WriteUnaryOp("jne", labelShortCircuit);

            n.RightExpression.Accept(this);

            Globals.Builder.WriteLabel(labelShortCircuit);

            Globals.Builder.End($"and (&&) [{n.Location.EndLine}, {n.Location.EndColumn}]");
        }

        public void Visit(Or n)
        {
            Globals.Builder.Start($"or (||) [{n.Location.StartLine}, {n.Location.StartColumn}]");

            n.LeftExpression.Accept(this);
            Globals.Builder.WriteBinaryOp("cmp", "rax", 1.ToString());
            var labelShortCircuit = $"orShortCircuit{Globals.Builder.Count()}";
            Globals.Builder.WriteUnaryOp("je", labelShortCircuit);

            n.RightExpression.Accept(this);

            Globals.Builder.WriteLabel(labelShortCircuit);

            Globals.Builder.End($"or (||) [{n.Location.EndLine}, {n.Location.EndColumn}]");
        }

        public void Visit(Less n)
        {
            Globals.Builder.Start($"less (<) [{n.Location.StartLine}, {n.Location.StartColumn}]");

            WriteBinaryExpression("cmp", n.LeftExpression, n.RightExpression);

            var labelFalse = $"lessFalse{Globals.Builder.Count()}";
            var labelEnd = $"lessEnd{Globals.Builder.Count()}";

            Globals.Builder.WriteUnaryOp("jnl", labelFalse);
            Globals.Builder.WriteBinaryOp("mov", "rax", 1.ToString());
            Globals.Builder.WriteUnaryOp("jmp", labelEnd);
            Globals.Builder.WriteLabel(labelFalse);
            Globals.Builder.WriteBinaryOp("mov", "rax", 0.ToString());
            Globals.Builder.WriteLabel(labelEnd);

            Globals.Builder.End($"less (<) [{n.Location.EndLine}, {n.Location.EndColumn}]");
        }

        public void Visit(Greater n)
        {
            Globals.Builder.Start($"greater (>) [{n.Location.StartLine}, {n.Location.StartColumn}]");

            WriteBinaryExpression("cmp", n.LeftExpression, n.RightExpression);

            var labelFalse = $"greaterFalse{Globals.Builder.Count()}";
            var labelEnd = $"greaterEnd{Globals.Builder.Count()}";

            Globals.Builder.WriteUnaryOp("jng", labelFalse);
            Globals.Builder.WriteBinaryOp("mov", "rax", 1.ToString());
            Globals.Builder.WriteUnaryOp("jmp", labelEnd);
            Globals.Builder.WriteLabel(labelFalse);
            Globals.Builder.WriteBinaryOp("mov", "rax", 0.ToString());
            Globals.Builder.WriteLabel(labelEnd);

            Globals.Builder.End($"greater (>) [{n.Location.EndLine}, {n.Location.EndColumn}]");
        }

        public void Visit(LessEqual n)
        {
            Globals.Builder.Start($"less equal (<=) [{n.Location.StartLine}, {n.Location.StartColumn}]");

            WriteBinaryExpression("cmp", n.LeftExpression, n.RightExpression);

            var labelFalse = $"lessEqualFalse{Globals.Builder.Count()}";
            var labelEnd = $"lessEqualEnd{Globals.Builder.Count()}";

            Globals.Builder.WriteUnaryOp("jnle", labelFalse);
            Globals.Builder.WriteBinaryOp("mov", "rax", 1.ToString());
            Globals.Builder.WriteUnaryOp("jmp", labelEnd);
            Globals.Builder.WriteLabel(labelFalse);
            Globals.Builder.WriteBinaryOp("mov", "rax", 0.ToString());
            Globals.Builder.WriteLabel(labelEnd);

            Globals.Builder.End($"less equal (<=) [{n.Location.EndLine}, {n.Location.EndColumn}]");
        }

        public void Visit(GreaterEqual n)
        {
            Globals.Builder.Start($"greater equal (>=) [{n.Location.StartLine}, {n.Location.StartColumn}]");

            WriteBinaryExpression("cmp", n.LeftExpression, n.RightExpression);

            var labelFalse = $"greaterEqualFalse{Globals.Builder.Count()}";
            var labelEnd = $"greaterEqualEnd{Globals.Builder.Count()}";

            Globals.Builder.WriteUnaryOp("jnge", labelFalse);
            Globals.Builder.WriteBinaryOp("mov", "rax", 1.ToString());
            Globals.Builder.WriteUnaryOp("jmp", labelEnd);
            Globals.Builder.WriteLabel(labelFalse);
            Globals.Builder.WriteBinaryOp("mov", "rax", 0.ToString());
            Globals.Builder.WriteLabel(labelEnd);

            Globals.Builder.End($"greater equal (>=) [{n.Location.EndLine}, {n.Location.EndColumn}]");
        }

        public void Visit(Instanceof n)
        {
            Globals.Builder.Start($"instanceof [{n.Location.StartLine}, {n.Location.StartColumn}]");

            var labelFalse = $"instanceofFalse{Globals.Builder.Count()}";
            var labelEnd = $"instanceofEnd{Globals.Builder.Count()}";

            CanCast(n.LeftExpression, n.RealizedTypeToCheck as Class, false /* check null */);
            Globals.Builder.WriteBinaryOp("cmp", "rax", 0.ToString());
            Globals.Builder.WriteUnaryOp("je", labelFalse);

            Globals.Builder.WriteBinaryOp("mov", "rax", 1.ToString());
            Globals.Builder.WriteUnaryOp("jmp", labelEnd);

            Globals.Builder.WriteLabel(labelFalse);
            Globals.Builder.WriteBinaryOp("mov", "rax", 0.ToString());

            Globals.Builder.WriteLabel(labelEnd);

            Globals.Builder.End($"instanceof [{n.Location.EndLine}, {n.Location.EndColumn}]");
        }

        public void Visit(NotEqual n)
        {
            Globals.Builder.Start($"not equal (!=) [{n.Location.StartLine}, {n.Location.StartColumn}]");

            WriteBinaryExpression("cmp", n.LeftExpression, n.RightExpression);

            var labelFalse = $"notEqualFalse{Globals.Builder.Count()}";
            var labelEnd = $"notEqualEnd{Globals.Builder.Count()}";

            Globals.Builder.WriteUnaryOp("je", labelFalse);
            Globals.Builder.WriteBinaryOp("mov", "rax", 1.ToString());
            Globals.Builder.WriteUnaryOp("jmp", labelEnd);
            Globals.Builder.WriteLabel(labelFalse);
            Globals.Builder.WriteBinaryOp("mov", "rax", 0.ToString());
            Globals.Builder.WriteLabel(labelEnd);

            Globals.Builder.End($"not equal (!=) [{n.Location.EndLine}, {n.Location.EndColumn}]");
        }

        public void Visit(Equal n)
        {
            Globals.Builder.Start($"equal (==) [{n.Location.StartLine}, {n.Location.StartColumn}]");

            WriteBinaryExpression("cmp", n.LeftExpression, n.RightExpression);

            var labelFalse = $"equalFalse{Globals.Builder.Count()}";
            var labelEnd = $"equalEnd{Globals.Builder.Count()}";

            Globals.Builder.WriteUnaryOp("jne", labelFalse);
            Globals.Builder.WriteBinaryOp("mov", "rax", 1.ToString());
            Globals.Builder.WriteUnaryOp("jmp", labelEnd);
            Globals.Builder.WriteLabel(labelFalse);
            Globals.Builder.WriteBinaryOp("mov", "rax", 0.ToString());
            Globals.Builder.WriteLabel(labelEnd);

            Globals.Builder.End($"equal (==) [{n.Location.EndLine}, {n.Location.EndColumn}]");
        }

        public void Visit(Plus n)
        {
            Globals.Builder.Start($"plus (+) [{n.Location.StartLine}, {n.Location.StartColumn}]");

            if (n.LeftExpression.RealizedType == Primitive.String || n.RightExpression.RealizedType == Primitive.String)
            {
                // Allocate space for new string.
                Globals.Builder.AllocateMemory(2000.ToString(), 1.ToString(), n.Location);

                // rax has new string pointer.
                Globals.Builder.WriteUnaryOp("push", "rax");

                // Get the left expression into rax.
                if (n.LeftExpression.RealizedType == Primitive.String)
                {
                    n.LeftExpression.Accept(this);
                }
                else
                {
                    n.LeftExpression.Accept(this);
                    Globals.Builder.WriteBinaryOp("mov", "rcx", "rax");

                    Globals.Builder.WriteCall("_intToString");
                }

                // Copy the left expression in to the new location.

                Globals.Builder.WriteBinaryOp("mov", "rdx", "rax");

                // Keep destination in stack.
                Globals.Builder.WriteUnaryOp("pop", "rcx");
                Globals.Builder.WriteUnaryOp("push", "rcx");

                Globals.Builder.WriteCall("strcpy");

                // Get the right expression into rax.
                if (n.RightExpression.RealizedType == Primitive.String)
                {
                    n.RightExpression.Accept(this);
                }
                else
                {
                    n.RightExpression.Accept(this);
                    Globals.Builder.WriteBinaryOp("mov", "rcx", "rax");

                    Globals.Builder.WriteCall("_intToString");
                }

                // Concatenate the right expression in to the new location.

                Globals.Builder.WriteBinaryOp("mov", "rdx", "rax");
                Globals.Builder.WriteUnaryOp("pop", "rcx");

                Globals.Builder.WriteCall("strcat");
            }
            else
            {
                WriteBinaryExpression("add", n.LeftExpression, n.RightExpression);
            }

            Globals.Builder.End($"plus (+) [{n.Location.EndLine}, {n.Location.EndColumn}]");
        }

        public void Visit(Minus n)
        {
            Globals.Builder.Start($"minus (-) [{n.Location.StartLine}, {n.Location.StartColumn}]");
            WriteBinaryExpression("sub", n.LeftExpression, n.RightExpression);
            Globals.Builder.End($"minus (-) [{n.Location.EndLine}, {n.Location.EndColumn}]");
        }

        public void Visit(Mod n)
        {
            Globals.Builder.Start($"modulo (%) [{n.Location.StartLine}, {n.Location.StartColumn}]");

            n.RightExpression.Accept(this);
            Globals.Builder.WriteUnaryOp("push", "rax");
            n.LeftExpression.Accept(this);
            Globals.Builder.WriteUnaryOp("pop", "r10");

            // Numerator is rdx:rax, so we will zero out rdx.
            Globals.Builder.WriteBinaryOp("mov", "rdx", 0.ToString());
            Globals.Builder.WriteUnaryOp("idiv", "r10");

            // Remainder is in rdx.
            Globals.Builder.WriteBinaryOp("mov", "rax", "rdx");

            Globals.Builder.End($"modulo (%) [{n.Location.EndLine}, {n.Location.EndColumn}]");
        }

        public void Visit(Divide n)
        {
            Globals.Builder.Start($"divide (/) [{n.Location.StartLine}, {n.Location.StartColumn}]");

            n.RightExpression.Accept(this);
            Globals.Builder.WriteUnaryOp("push", "rax");
            n.LeftExpression.Accept(this);
            Globals.Builder.WriteUnaryOp("pop", "r10");

            // Numerator is rdx:rax, so we will zero out rdx.
            Globals.Builder.WriteBinaryOp("mov", "rdx", 0.ToString());
            Globals.Builder.WriteUnaryOp("idiv", "r10");

            Globals.Builder.End($"divide (/) [{n.Location.EndLine}, {n.Location.EndColumn}]");
        }

        public void Visit(Multiply n)
        {
            Globals.Builder.Start($"multiply (*) [{n.Location.StartLine}, {n.Location.StartColumn}]");
            WriteBinaryExpression("imul", n.LeftExpression, n.RightExpression);
            Globals.Builder.End($"multiply (*) [{n.Location.EndLine}, {n.Location.EndColumn}]");
        }

        public void Visit(ArrayAccess n)
        {
            Globals.Builder.Start($"array access (int[x]) [{n.Location.StartLine}, {n.Location.StartColumn}]");

            GetArrayAtIndex(n.Array, n.Index);

            // shift index by 1 to account for length.
            Globals.Builder.WriteBinaryOp("add", "r10", 1.ToString());
            Globals.Builder.WriteBinaryOp("mov", "rax", "[rax + r10 * 8]");

            Globals.Builder.End($"array access (int[x]) [{n.Location.EndLine}, {n.Location.EndColumn}]");
        }

        public void Visit(ArrayLength n)
        {
            Globals.Builder.Start($"array length (int[].length) [{n.Location.StartLine}, {n.Location.StartColumn}]");

            GetPointer(n.Array);
            Globals.Builder.WriteBinaryOp("mov", "rax", "[rax]");

            Globals.Builder.End($"array length (int[].length) [{n.Location.EndLine}, {n.Location.EndColumn}]");
        }

        public void Visit(Cast n)
        {
            Globals.Builder.Start($"cast [{n.Location.StartLine}, {n.Location.StartColumn}]");
            
            var labelEnd = $"castEnd{Globals.Builder.Count()}";

            CanCast(n.Expression, n.RealizedTypeToCast as Class);
            Globals.Builder.WriteBinaryOp("cmp", "rax", 0.ToString());
            Globals.Builder.WriteUnaryOp("jne", labelEnd);

            Globals.Builder.RuntimeErrorAndExit(1827, $"Invalid cast at [{n.Location.StartLine}, {n.Location.StartColumn}].");

            Globals.Builder.WriteLabel(labelEnd);

            Globals.Builder.End($"cast [{n.Location.EndLine}, {n.Location.EndColumn}]");
        }

        public void Visit(Integer n)
        {
            Globals.Builder.WriteBinaryOp("mov", "rax", n.Value.ToString(), $"[{n.Location.StartLine}, {n.Location.StartColumn}] Explicit integer.");
        }

        public void Visit(Ast.String n)
        {
            Globals.Builder.WriteBinaryOp("lea", "rax", Globals.StringTable[n.Str], $"[{n.Location.StartLine}, {n.Location.StartColumn}] Explicit string.");
        }

        public void Visit(True n)
        {
            Globals.Builder.WriteBinaryOp("mov", "rax", 1.ToString(), $"[{n.Location.StartLine}, {n.Location.StartColumn}] Explicit true.");
        }

        public void Visit(False n)
        {
            Globals.Builder.WriteBinaryOp("mov", "rax", 0.ToString(), $"[{n.Location.StartLine}, {n.Location.StartColumn}] Explicit false.");
        }

        public void Visit(Null n)
        {
            Globals.Builder.WriteBinaryOp("mov", "rax", 0.ToString(), $"[{n.Location.StartLine}, {n.Location.StartColumn}] Explicit null.");
        }

        public void Visit(IdentifierExpression n)
        {
            Globals.Builder.Start($"identifier ({n.Name}) [{n.Location.StartLine}, {n.Location.StartColumn}]");

            GetIdentifier(n.Name); // rax has pointer to location.
            Globals.Builder.WriteBinaryOp("mov", "rax", "[rax]");

            Globals.Builder.End($"identifier ({n.Name}) [{n.Location.EndLine}, {n.Location.EndColumn}]");
        }

        public void Visit(This n)
        {
            Globals.Builder.WriteBinaryOp("mov", "rax", "[rbp + 16]", $"[{n.Location.StartLine}, {n.Location.StartColumn}] Explicit this.");
        }

        public void Visit(NewArray n)
        {
            Globals.Builder.Start($"new int[] [{n.Location.StartLine}, {n.Location.StartColumn}]");

            n.Size.Accept(this);

            // rax has the size, add one to it so there is a slot for size.
            Globals.Builder.WriteUnaryOp("push", "rax");
            Globals.Builder.WriteBinaryOp("add", "rax", 1.ToString());

            Globals.Builder.AllocateMemory("rax", 8.ToString(), n.Location);

            // Move the size into the first slot.
            Globals.Builder.WriteUnaryOp("pop", "r10");
            Globals.Builder.WriteBinaryOp("mov", "[rax]", "r10");

            Globals.Builder.End($"new int[] [{n.Location.EndLine}, {n.Location.EndColumn}]");
        }

        public void Visit(NewObject n)
        {
            Globals.Builder.Start($"new {n.RealizedType.Name} [{n.Location.StartLine}, {n.Location.StartColumn}]");

            var numToAllocate = (n.RealizedType as Class).NumProperties() + 1;

            // Allocate space.
            Globals.Builder.AllocateMemory(numToAllocate.ToString(), 8.ToString(), n.Location);

            // Move the vtablePointer into the object.
            Globals.Builder.WriteBinaryOp("lea", "r10", $"{(n.RealizedType as Class).ClassTableName}");
            Globals.Builder.WriteBinaryOp("mov", "[rax]", "r10");

            Globals.Builder.End($"new {n.RealizedType.Name} [{n.Location.EndLine}, {n.Location.EndColumn}]");
        }

        public void Visit(Not n)
        {
            Globals.Builder.Start($"not (!) [{n.Location.StartLine}, {n.Location.StartColumn}]");

            n.Expression.Accept(this);
            Globals.Builder.WriteBinaryOp("xor", "rax", 1.ToString());

            Globals.Builder.End($"not (!) [{n.Location.EndLine}, {n.Location.EndColumn}]");
        }

        public void Visit(Parenthetical n)
        {
            n.Expression.Accept(this);
        }

        #endregion
    }
}
