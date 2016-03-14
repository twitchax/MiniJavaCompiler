using System;
using System.Collections.Generic;
using System.Linq;
using Compiler.Ast;
using Compiler.Semantics;

namespace Compiler.Visitors
{
    // This visitor does a global scan for types and builds another abstraction layer.  In short:
    //    1. For each class:
    //       a. Create a type in the type table.
    //       b. Add each property to property table for class.
    //       c. For each method:
    //          i. Add to method table for class.
    //          ii. Take note of return type.
    //          iii. Take note of the local declarations.
    //          iv. Take note of the AST statements.
    //          v. Take note of the return expression.
    //    2. Afterwards (in the Goal visitor):
    //       a. Check that every time a type was "utilized", it was a valid type.
    //       b. "Realize" the types by running a setter-functor on each "utilized" type.
    //       c. Check inheritance constraints (override respect and cycle detection).
    internal class GlobalTypeVistor : ITypeVisitor
    {
        #region Helpers

        private ClassMethod CurrentMethod { get; set; }
        private Stack<ClassMethodBlock> BlockStack { get; set; } = new Stack<ClassMethodBlock>();
        private int _localPosition = 0;
        private int _strNum = 0;

        private void AddToTypeTable(SemanticType t)
        {
            if (Globals.TypeTable.ContainsKey(t.Name))
                Globals.Errors.Add($"Type ({t.Name}[{t.DeclarationLocation.StartLine}, {t.DeclarationLocation.StartColumn}]) previously declared.");
            else
                Globals.TypeTable.Add(t.Name, t);
        }

        private void AddToGlobalUtilization(UtilizedType utilizedType, Action<SemanticType> realizationAction)
        {
            Globals.TypeUtilization.Add(new UtilizationPointerTuple(utilizedType, realizationAction));
        }

        private void AddToStringTable(string s)
        {
            if (!Globals.StringTable.ContainsKey(s))
            {
                Globals.StringTable.Add(s, $"$$str{_strNum}");
                _strNum++;
            }
        }

        #endregion

        #region Top Level AST Nodes

        public void Visit(Goal n)
        {
            // Add primitives to the global type table.
            Globals.TypeTable.Add(Primitive.Int.Name, Primitive.Int);
            Globals.TypeTable.Add(Primitive.IntArray.Name, Primitive.IntArray);
            Globals.TypeTable.Add(Primitive.StringArray.Name, Primitive.StringArray);
            Globals.TypeTable.Add(Primitive.Boolean.Name, Primitive.Boolean);
            Globals.TypeTable.Add(Primitive.String.Name, Primitive.String);
            Globals.TypeTable.Add(Primitive.Void.Name, Primitive.Void);

            // Accept the main class and the other defined classes.
            n.MainClass.Accept(this);
            foreach (var c in n.ClassList)
            {
                c.Accept(this);
            }

            // Add post-analysis here to check that every symbol has a declared type.  Also, "realize" the types.
            foreach (var u in Globals.TypeUtilization.Where(u => u.UtilizedType != null))
            {
                // Ensure that this type is in the global type table.
                if (!Globals.TypeTable.ContainsKey(u.UtilizedType.Name))
                {
                    Globals.Errors.Add($"[{u.UtilizedType.UtilizationLocation.StartLine}, {u.UtilizedType.UtilizationLocation.StartColumn}] Type ({u.UtilizedType.Name}) is not a valid type name.");
                    Globals.TypeTable[u.UtilizedType.Name] = Class.Unknown;
                }

                // "Realize" the type.
                u.RealizationAction?.Invoke(Globals.TypeTable[u.UtilizedType.Name]);
            }

            // Add post-analysis to ensure that type inheritance is playing nicely.
            foreach (var t in Globals.TypeTable.EnumerateValues().Where(t => !t.IsPrimitive).Cast<Class>())
            {
                var baseClass = t.BaseClass;

                if (baseClass != null)
                {
                    // Ensure that overloaded methods are compatible.
                    foreach (var m in t.Methods.EnumerateValues())
                    {
                        // Check that any overrided methods are correct.
                        if (baseClass.HasMethod(m.Name))
                        {
                            var baseMethod = baseClass.LookupMethod(m.Name);

                            if(m.Arguments.Count != baseMethod.Arguments.Count)
                                Globals.Errors.Add($"[{m.DeclarationLocation.StartLine}, {m.DeclarationLocation.StartColumn}] Method {m.Name} has {m.Arguments.Count} argument(s) in {m.OwnerClass.Name} but {baseMethod.Arguments.Count} was/were found in {baseMethod.OwnerClass.Name}.");
                            else
                                foreach (var o in m.Arguments.Zip(baseMethod.Arguments, (left, right) => new { DefinedArgument = left.Value, BaseClassArgument = right.Value }))
                                {
                                    var defined = o.DefinedArgument;
                                    var @base = o.BaseClassArgument;
                                    if (!@base.RealizedType.IsAssignableFrom(defined.RealizedType))
                                    {
                                        Globals.Errors.Add($"[{defined.DeclarationLocation.StartLine}, {defined.DeclarationLocation.StartColumn}] Method argument of type {@defined.RealizedType.Name} in {t.Name} cannot override {@base.RealizedType.Name} in {baseMethod.OwnerClass.Name}.");
                                    }
                                }

                            if(!baseMethod.RealizedReturnType.IsAssignableFrom(m.RealizedReturnType))
                                Globals.Errors.Add($"[{m.DeclarationLocation.StartLine}, {m.DeclarationLocation.StartColumn}] Method {m.Name} has an incompatible return type ({m.RealizedReturnType.Name}) from its overrided method in {baseMethod.OwnerClass.Name} ({baseMethod.RealizedReturnType.Name}).");
                        }

                        // Check that there is at least one top-level return statement.
                        if (m.AstReturnType != null && !m.MethodBody.AstBlock.StatementList.Any(s => s is Return))
                            Globals.Errors.Add($"[{m.DeclarationLocation.StartLine}, {m.DeclarationLocation.StartColumn}] Method {m.Name} does not have at least one top-level return statement.");
                    }
                }

                // Check for inheritance cycles.
                if(t.GetAncestorCount() == null)
                    Globals.Errors.Add($"[{t.DeclarationLocation.StartLine}, {t.DeclarationLocation.StartColumn}] Type ({t.Name}) has cycles in its inheritance ancestry.");
            }
        }

        public SemanticAtom Visit(MainClass n)
        {
            var method = new ClassMethod("main", null, n.MainMethodBody.Location);
            CurrentMethod = method;
            _localPosition = 0;

            var argsType = new UtilizedType(Primitive.StringArray.Name, n.Location);
            var argsArg = new MethodArgument(n.ArgsName, argsType, method.DeclarationLocation);
            AddToGlobalUtilization(argsType, s => { argsArg.RealizedType = s; });
            method.Arguments.Add(argsArg.Name, argsArg);

            method.RealizedReturnType = Primitive.Void;
            method.AstReturnType = null;
            
            BlockStack = new Stack<ClassMethodBlock>();
            method.MethodBody = n.MainMethodBody.Accept(this) as ClassMethodBlock;

            var c = new Class(n.Name, null, n.Location) {IsMainClass = true};

            c.Methods.Add("main", method);

            AddToTypeTable(c);

            return c;
        }

        public SemanticAtom Visit(AstClass n)
        {
            var baseClassUtilizedType = n.ClassExtension?.Accept(this) as UtilizedType;
            var c = new Class(n.Name, baseClassUtilizedType, n.Location);
            AddToGlobalUtilization(baseClassUtilizedType, s => { c.BaseClass = s as Class; });

            foreach (var v in n.ClassDeclarationList.OfType<Property>())
            {
                var p = (ClassProperty)v.Accept(this);

                if(c.Properties.ContainsKey(p.Name))
                    Globals.Errors.Add($"[{p.DeclarationLocation.StartLine}, {p.DeclarationLocation.StartColumn}] Property ({p.Name}) is already defined in {c.Name}.");
                else
                    c.Properties.Add(p.Name, p);

            }
            
            foreach (var m in n.ClassDeclarationList.OfType<Method>())
            {
                var method = (ClassMethod)m.Accept(this);
                method.OwnerClass = c;

                if(c.Methods.ContainsKey(method.Name))
                    Globals.Errors.Add($"[{method.DeclarationLocation.StartLine}, {method.DeclarationLocation.StartColumn}] Method ({method.Name}) is already defined in {c.Name}.");
                else
                    c.Methods.Add(method.Name, method);
            }

            AddToTypeTable(c);

            return c;
        }

        public SemanticAtom Visit(ClassExtension n)
        {
            var t = new UtilizedType(n.Name, n.Location);
            return t;
        }

        #endregion

        #region Method AST Nodes

        public SemanticAtom Visit(Variable n)
        {
            throw new NotImplementedException();
        }

        public SemanticAtom Visit(Property n)
        {
            var utilizedType = n.AstType.Accept(this) as UtilizedType;
            var classProperty = new ClassProperty(n.Name, utilizedType, n.Location);
            AddToGlobalUtilization(utilizedType, s => { classProperty.RealizedType = s; });
            return classProperty;
        }

        public SemanticAtom Visit(Method n)
        {
            ClassMethod method;

            if (n.ReturnAstType != null)
            {
                var returnUtilizedType = n.ReturnAstType.Accept(this) as UtilizedType;
                method = new ClassMethod(n.Name, returnUtilizedType, n.Location);
                AddToGlobalUtilization(returnUtilizedType, s => { method.RealizedReturnType = s; });
            }
            else
                method = new ClassMethod(n.Name, null, n.Location) { RealizedReturnType = Primitive.Void };

            method.AstReturnType = n.ReturnAstType;

            foreach (var a in n.ArgumentList)
            {
                var arg = (MethodArgument) a.Accept(this);

                if (method.Arguments.ContainsKey(arg.Name))
                    Globals.Errors.Add($"[{arg.DeclarationLocation.StartLine}, {arg.DeclarationLocation.StartColumn}] Argument ({arg.Name}) is already defined in {method.Name}.");
                else
                    method.Arguments.Add(arg.Name, arg);
            }

            CurrentMethod = method;
            _localPosition = 0;
            BlockStack = new Stack<ClassMethodBlock>();
            method.MethodBody = n.Statement.Accept(this) as ClassMethodBlock;

            return method;
        }

        public SemanticAtom Visit(Argument n)
        {
            var utilizedType = n.AstType.Accept(this) as UtilizedType;
            var methodArg = new MethodArgument(n.Name, utilizedType, n.Location);
            AddToGlobalUtilization(utilizedType, s => { methodArg.RealizedType = s; });

            return methodArg;
        }

        #endregion

        #region Type AST Nodes

        public SemanticAtom Visit(IntArray n)
        {
            var t = new UtilizedType(Primitive.IntArray.Name, n.Location);
            return t;
        }

        public SemanticAtom Visit(AstBoolean n)
        {
            var t = new UtilizedType(Primitive.Boolean.Name, n.Location);
            return t;
        }

        public SemanticAtom Visit(Int n)
        {
            var t = new UtilizedType(Primitive.Int.Name, n.Location);
            return t;
        }

        public SemanticAtom Visit(AstString n)
        {
            var t = new UtilizedType(Primitive.String.Name, n.Location);
            return t;
        }

        public SemanticAtom Visit(Custom n)
        {
            var t = new UtilizedType(n.Name, n.Location);
            return t;
        }

        #endregion

        #region Statement AST Nodes

        public SemanticAtom Visit(VariableDeclaration n)
        {
            var utilizedType = (UtilizedType)n.AstType.Accept(this);
            var local = new Local(n.Name, _localPosition++, utilizedType, n.Location);
            AddToGlobalUtilization(utilizedType, s => { local.RealizedType = s; });

            if (BlockStack.Peek().Locals.ContainsKey(local.Name))
                Globals.Errors.Add(
                    $"[{local.DeclarationLocation.StartLine}, {local.DeclarationLocation.StartColumn}] Local ({local.Name}) is already defined in current block of {CurrentMethod.Name}.");
            else
                BlockStack.Peek().Locals.Add(local.Name, local);

            return local;
        }

        public SemanticAtom Visit(Block n)
        {
            var current = BlockStack.Count == 0 ? null : BlockStack.Peek();
            var semanticBlock = new ClassMethodBlock(n, current, CurrentMethod, n.Location);
            n.AssociatedSemanticBlock = semanticBlock;

            BlockStack.Push(semanticBlock);
            current?.SubBlocks.Add(semanticBlock);

            // Plumb the for-loop initializer into this block in case it has a declaration.
            n.OptionalFor?.Initialize.Accept(this);
            n.OptionalFor?.Test.Accept(this);

            foreach (var d in n.StatementList)
            {
                d.Accept(this);
            }
            
            n.OptionalFor?.Afterthought.Accept(this);

            BlockStack.Pop();

            return semanticBlock;
        }

        public SemanticAtom Visit(If n)
        {
            n.Test.Accept(this);
            n.True.Accept(this);
            n.False.Accept(this);
            return null;
        }

        public SemanticAtom Visit(While n)
        {
            n.Test.Accept(this);
            n.Action.Accept(this);
            return null;
        }

        public SemanticAtom Visit(For n)
        {
            var block = n.Action as Block;
            block.OptionalFor = n;

            n.Action.Accept(this);

            return null;
        }

        public SemanticAtom Visit(Return n)
        {
            n.Expression?.Accept(this);
            return null;
        }

        public SemanticAtom Visit(ExpressionStatementStatement n)
        {
            n.ExpressionStatement.Accept(this);
            return null;
        }

        #endregion

        #region Expression Statement AST Nodes

        public SemanticAtom Visit(Assignment n)
        {
            n.Source.Accept(this);
            return null;
        }

        public SemanticAtom Visit(DeclarationAssignment n)
        {
            var utilizedType = (UtilizedType)n.AstType.Accept(this);
            var local = new Local(n.DestinationName, _localPosition++, utilizedType, n.Location);
            AddToGlobalUtilization(utilizedType, s => { local.RealizedType = s; });

            if (BlockStack.Peek().Locals.ContainsKey(local.Name))
                Globals.Errors.Add(
                    $"[{local.DeclarationLocation.StartLine}, {local.DeclarationLocation.StartColumn}] Local ({local.Name}) is already defined in current block of {CurrentMethod.Name}.");
            else
                BlockStack.Peek().Locals.Add(local.Name, local);

            n.Source.Accept(this);

            return local;
        }

        public SemanticAtom Visit(ArrayAssignment n)
        {
            n.Destination.Accept(this);
            n.Index.Accept(this);
            n.Source.Accept(this);
            return null;
        }

        public SemanticAtom Visit(MethodCall n)
        {
            n.Source.Accept(this);
            foreach (var a in n.Arguments)
            {
                a.Accept(this);
            }
            return null;
        }

        public SemanticAtom Visit(CompilerFunction n)
        {
            n.Expression?.Accept(this);

            switch (n.FunctionString)
            {
                case "System.out.println":
                    if (n.Expression == null)
                        AddToStringTable("\"\"");
                    break;
            }

            return null;
        }

        public SemanticAtom Visit(Incrementer n)
        {
            n.IncrementExpression?.Accept(this);
            return null;
        }

        #endregion

        #region Expression AST Nodes

        public SemanticAtom Visit(And n)
        {
            n.LeftExpression.Accept(this);
            n.RightExpression.Accept(this);
            return null;
        }

        public SemanticAtom Visit(Or n)
        {
            n.LeftExpression.Accept(this);
            n.RightExpression.Accept(this);
            return null;
        }

        public SemanticAtom Visit(Less n)
        {
            n.LeftExpression.Accept(this);
            n.RightExpression.Accept(this);
            return null;
        }

        public SemanticAtom Visit(Greater n)
        {
            n.LeftExpression.Accept(this);
            n.RightExpression.Accept(this);
            return null;
        }

        public SemanticAtom Visit(LessEqual n)
        {
            n.LeftExpression.Accept(this);
            n.RightExpression.Accept(this);
            return null;
        }

        public SemanticAtom Visit(GreaterEqual n)
        {
            n.LeftExpression.Accept(this);
            n.RightExpression.Accept(this);
            return null;
        }

        public SemanticAtom Visit(Instanceof n)
        {
            var utilizedType = new UtilizedType(n.TypeNameToCheck, n.Location);
            AddToGlobalUtilization(utilizedType, s => { n.RealizedTypeToCheck = s; });

            n.LeftExpression.Accept(this);
            return null;
        }

        public SemanticAtom Visit(NotEqual n)
        {
            n.LeftExpression.Accept(this);
            n.RightExpression.Accept(this);
            return null;
        }

        public SemanticAtom Visit(Equal n)
        {
            n.LeftExpression.Accept(this);
            n.RightExpression.Accept(this);
            return null;
        }

        public SemanticAtom Visit(Plus n)
        {
            n.LeftExpression.Accept(this);
            n.RightExpression.Accept(this);
            return null;
        }

        public SemanticAtom Visit(Minus n)
        {
            n.LeftExpression.Accept(this);
            n.RightExpression.Accept(this);
            return null;
        }

        public SemanticAtom Visit(Mod n)
        {
            n.LeftExpression.Accept(this);
            n.RightExpression.Accept(this);
            return null;
        }

        public SemanticAtom Visit(Divide n)
        {
            n.LeftExpression.Accept(this);
            n.RightExpression.Accept(this);
            return null;
        }

        public SemanticAtom Visit(Multiply n)
        {
            n.LeftExpression.Accept(this);
            n.RightExpression.Accept(this);
            return null;
        }

        public SemanticAtom Visit(ArrayAccess n)
        {
            n.Array.Accept(this);
            n.Index.Accept(this);
            return null;
        }

        public SemanticAtom Visit(ArrayLength n)
        {
            n.Array.Accept(this);
            return null;
        }

        public SemanticAtom Visit(Cast n)
        {
            var utilizedType = new UtilizedType(n.TypeNameToCast, n.Location);
            AddToGlobalUtilization(utilizedType, s => { n.RealizedTypeToCast = s; });

            n.Expression.Accept(this);
            return null;
        }

        public SemanticAtom Visit(Integer n)
        {
            return null;
        }

        public SemanticAtom Visit(Ast.String n)
        {
            AddToStringTable(n.Str);
            return null;
        }

        public SemanticAtom Visit(True n)
        {
            return null;
        }

        public SemanticAtom Visit(False n)
        {
            return null;
        }

        public SemanticAtom Visit(Null n)
        {
            return null;
        }

        public SemanticAtom Visit(IdentifierExpression n)
        {
            return null;
        }

        public SemanticAtom Visit(This n)
        {
            return null;
        }

        public SemanticAtom Visit(NewArray n)
        {
            var t = new UtilizedType(Primitive.IntArray.Name, n.Location);
            AddToGlobalUtilization(t, null);
            return null;
        }

        public SemanticAtom Visit(NewObject n)
        {
            var t = new UtilizedType(n.Name, n.Location);
            AddToGlobalUtilization(t, null);
            return null;
        }

        public SemanticAtom Visit(Not n)
        {
            n.Expression.Accept(this);
            return null;
        }

        public SemanticAtom Visit(Parenthetical n)
        {
            n.Expression.Accept(this);
            return null;
        }

        #endregion
    }
}
