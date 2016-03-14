using System;
using System.Linq;
using Compiler.Ast;
using Compiler.Semantics;

namespace Compiler.Visitors
{
    // This visitor merely chcecks that all statements are valid (which is why most of the top level AST nodes are skipped).
    // Please see the comment for the GlobalTypeVisitor for information on what has been computed at this point.
    // The GlobalTypeVisitor creates another layer of abstraction by wrapping classes, properties, methods and locals.
    // As such, this visitor merely needs to verify that the statements in the methods are checked for proper type consistency.
    internal class TypeCheckerVistor : ITypeVisitor
    {
        #region Helpers

        private ClassMethod CurrentMethod { get; set; }
        private ClassMethodBlock CurrentBlock { get; set; }

        private SemanticType BinaryExpressionHelper(BinaryExpression exp, SemanticType expectedType, string op, SemanticType returnType)
        {
            var left = exp.LeftExpression.Accept(this);
            var right = exp.RightExpression.Accept(this);
            var leftLocation = exp.LeftExpression.Location;
            var rightLocation = exp.RightExpression.Location;

            if (left != expectedType)
                Globals.Errors.Add($"[{leftLocation.StartLine}, {leftLocation.StartColumn}] Left expression of operator({op}) ({left.Name}) is not assignable to {expectedType.Name}.");

            if (right != expectedType)
                Globals.Errors.Add($"[{rightLocation.StartLine}, {rightLocation.StartColumn}] Right expression of operator({op}) ({right.Name}) is not assignable to {expectedType.Name}.");

            return returnType;
        }

        #endregion

        #region Top Level AST Nodes

        public void Visit(Goal n)
        {
            // At this point, we are only evaluating statement type compatibility, so we don't need to do much with classes, methods, etc.
            // For each method in each class, we will check type compatibility of statements and type compatibility of the return expression and
            // return type.
            foreach (var t in Globals.TypeTable.EnumerateValues().Where(t => !t.IsPrimitive).Cast<Class>())
            {
                foreach (var m in t.Methods.EnumerateValues())
                {
                    // Set the singleton.
                    CurrentMethod = m;
                    CurrentBlock = null;

                    m.MethodBody.AstBlock.Accept(this);
                }
            }
        }

        public SemanticAtom Visit(MainClass n)
        {
            throw new NotImplementedException();
        }

        public SemanticAtom Visit(AstClass n)
        {
            throw new NotImplementedException();
        }

        public SemanticAtom Visit(ClassExtension n)
        {
            throw new NotImplementedException();
        }

        #endregion

        #region Method AST Nodes

        public SemanticAtom Visit(Variable n)
        {
            throw new NotImplementedException();
        }

        public SemanticAtom Visit(Property n)
        {
            throw new NotImplementedException();
        }

        public SemanticAtom Visit(Method n)
        {
            throw new NotImplementedException();
        }

        public SemanticAtom Visit(Argument n)
        {
            throw new NotImplementedException();
        }

        #endregion

        #region Type AST Nodes

        public SemanticAtom Visit(IntArray n)
        {
            return Primitive.IntArray;
        }

        public SemanticAtom Visit(AstBoolean n)
        {
            return Primitive.Boolean;
        }

        public SemanticAtom Visit(Int n)
        {
            return Primitive.Int;
        }

        public SemanticAtom Visit(AstString n)
        {
            return Primitive.String;
        }

        public SemanticAtom Visit(Custom n)
        {
            return Globals.TypeTable[n.Name];
        }

        #endregion

        #region Statement AST Nodes

        public SemanticAtom Visit(VariableDeclaration n)
        {
            return null;
        }

        public SemanticAtom Visit(Block n)
        {
            var previousBlock = CurrentBlock;
            CurrentBlock = n.AssociatedSemanticBlock;

            // Handle the case for a for loop.
            if (n.OptionalFor != null)
            {
                n.OptionalFor.Initialize.Accept(this);
                var forTest = n.OptionalFor.Test.Accept(this);

                if (forTest != Primitive.Boolean)
                    Globals.Errors.Add($"[{n.OptionalFor.Test.Location.StartLine}, {n.OptionalFor.Test.Location.StartColumn}] Test condition for \"while\" statement ({forTest.Name}) is not assignable to {Primitive.Boolean.Name}.");
            }

            foreach (var s in n.StatementList)
            {
                s.Accept(this);
            }

            n.OptionalFor?.Afterthought.Accept(this);

            CurrentBlock = previousBlock;

            return null;
        }

        public SemanticAtom Visit(If n)
        {
            var test = n.Test.Accept(this);

            if (test != Primitive.Boolean)
                Globals.Errors.Add($"[{n.Test.Location.StartLine}, {n.Test.Location.StartColumn}] Test condition for \"if\" statement ({test.Name}) is not assignable to {Primitive.Boolean.Name}.");

            n.True.Accept(this);
            n.False.Accept(this);

            return null;
        }

        public SemanticAtom Visit(While n)
        {
            var test = n.Test.Accept(this);

            if (test != Primitive.Boolean)
                Globals.Errors.Add($"[{n.Test.Location.StartLine}, {n.Test.Location.StartColumn}] Test condition for \"while\" statement ({test.Name}) is not assignable to {Primitive.Boolean.Name}.");

            n.Action.Accept(this);

            return null;
        }

        public SemanticAtom Visit(For n)
        {
            // For loop is handled by the block for proper local checking.
            // GlobalTypeVisitor sets up the relationship.
            n.Action.Accept(this);

            return null;
        }

        public SemanticAtom Visit(Return n)
        {
            var returnType = n.Expression?.Accept(this) ?? Primitive.Void;

            if (returnType != CurrentMethod.RealizedReturnType)
                Globals.Errors.Add($"[{n.Location.StartLine}, {n.Location.StartColumn}] Return expression type ({returnType.Name}) is not assignable to {CurrentMethod.RealizedReturnType.Name}.");

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
            var destinationType = CurrentBlock.LookupIdentifierType(n.DestinationName, n.Location);
            var sourceType = n.Source.Accept(this) as SemanticType;

            if (!destinationType.IsAssignableFrom(sourceType))
                Globals.Errors.Add($"[{n.Location.StartLine}, {n.Location.StartColumn}] Source expression ({sourceType.Name}) is not assignable to {n.DestinationName} ({destinationType.Name}).");

            return destinationType;
        }

        public SemanticAtom Visit(DeclarationAssignment n)
        {
            var destinationType = CurrentBlock.LookupIdentifierType(n.DestinationName, n.Location);
            var sourceType = n.Source.Accept(this) as SemanticType;

            if (!destinationType.IsAssignableFrom(sourceType))
                Globals.Errors.Add($"[{n.Location.StartLine}, {n.Location.StartColumn}] Source expression ({sourceType.Name}) is not assignable to {n.DestinationName} ({destinationType.Name}).");

            return destinationType;
        }

        public SemanticAtom Visit(ArrayAssignment n)
        {
            // TODO: Allow array of other types?

            var sourceType = n.Source.Accept(this);

            if (n.Destination.Accept(this) != Primitive.IntArray)
                throw new Exception("This should never happen.");

            if (sourceType != Primitive.Int)
                Globals.Errors.Add($"[{n.Location.StartLine}, {n.Location.StartColumn}] Source expression ({sourceType.Name}) is not assignable to {Primitive.Int.Name}.");

            if (n.Index.Accept(this) != Primitive.Int)
                Globals.Errors.Add($"[{n.Index.Location.StartLine}, {n.Index.Location.StartColumn}] Index expression is not of type {Primitive.Int.Name}.");

            return Primitive.Int;
        }

        public SemanticAtom Visit(MethodCall n)
        {
            var type = n.Source.Accept(this) as Class;

            if (!type.HasMethod(n.Name))
            {
                Globals.Errors.Add($"[{n.Source.Location.StartLine}, {n.Source.Location.StartColumn}] Type ({type.Name}) does not contain a defintition for method {n.Name}.");
                return Class.Unknown;
            }

            var method = type.LookupMethod(n.Name);

            if (method.Arguments.Count != n.Arguments.Count)
                Globals.Errors.Add($"[{n.Location.StartLine}, {n.Location.StartColumn}] Method {n.Name} has {method.Arguments.Count} argument(s) but {n.Arguments.Count} was/were found.");
            else
                foreach (var o in method.Arguments.Zip(n.Arguments, (left, right) => new { DefinedArgument = left.Value, SuppliedArgument = right }))
                {
                    var suppliedType = o.SuppliedArgument.Accept(this) as SemanticType;
                    if (!o.DefinedArgument.RealizedType.IsAssignableFrom(suppliedType))
                    {
                        Globals.Errors.Add($"[{o.SuppliedArgument.Location.StartLine}, {o.SuppliedArgument.Location.StartColumn}] Method argument of type {suppliedType.Name} is not assignable to {o.DefinedArgument.Name} ({o.DefinedArgument.RealizedType.Name}).");
                    }
                }

            n.RealizedType = method.RealizedReturnType;
            return n.RealizedType;
        }

        public SemanticAtom Visit(CompilerFunction n)
        {
            var type = n.Expression?.Accept(this);

            SemanticType returnType = Class.Unknown;

            switch (n.FunctionString)
            {
                case "System.out.println":
                    if (type != null && type != Primitive.Int && type != Primitive.Boolean && type != Primitive.String)
                        Globals.Errors.Add($"[{n.Expression.Location.StartLine}, {n.Expression.Location.StartColumn}] Println expression ({type.Name}) is not assignable to {Primitive.String.Name}.");
                    returnType = Class.Unknown;
                    break;
                case "System.in.readln":
                    returnType = Primitive.String;
                    break;
                case "System.compiler.destroy":
                    if (!(type is Class) && type != Primitive.IntArray)
                        Globals.Errors.Add($"[{n.Expression.Location.StartLine}, {n.Expression.Location.StartColumn}] Destroy expression ({type.Name}) is a class or array type.");
                    returnType = Class.Unknown;
                    break;
                case "System.compiler.exception":
                    if (type != Primitive.String)
                        Globals.Errors.Add($"[{n.Expression.Location.StartLine}, {n.Expression.Location.StartColumn}] Exception expression ({type.Name}) is not assignable to {Primitive.String.Name}.");
                    returnType = Class.Unknown;
                    break;
                case "System.compiler.atol":
                    if (type != Primitive.String)
                        Globals.Errors.Add($"[{n.Expression.Location.StartLine}, {n.Expression.Location.StartColumn}] Atol expression ({type.Name}) is not assignable to {Primitive.String.Name}.");
                    returnType = Primitive.Int;
                    break;
            }

            n.RealizedType = returnType;
            return n.RealizedType;
        }

        public SemanticAtom Visit(Incrementer n)
        {
            var identifierType = CurrentBlock.LookupIdentifierType(n.IdentifierName, n.Location);
            var incrementExpressionType = n.IncrementExpression?.RealizedType;

            if (identifierType != Primitive.Int)
                Globals.Errors.Add($"[{n.Location.StartLine}, {n.Location.StartColumn}] {n.IdentifierName} ({identifierType.Name}) is not assignable to {Primitive.Int.Name}, which is required for incrementing.");

            if (incrementExpressionType != Primitive.Int && incrementExpressionType != null)
                Globals.Errors.Add($"[{n.Location.StartLine}, {n.Location.StartColumn}] Source expression ({incrementExpressionType.Name}) is not assignable to {Primitive.Int.Name}.");

            return Primitive.Int;
        }

        #endregion

        #region Expression AST Nodes

        public SemanticAtom Visit(And n)
        {
            n.RealizedType = BinaryExpressionHelper(n, Primitive.Boolean, "&&", Primitive.Boolean);
            return n.RealizedType;
        }

        public SemanticAtom Visit(Or n)
        {
            n.RealizedType = BinaryExpressionHelper(n, Primitive.Boolean, "||", Primitive.Boolean);
            return n.RealizedType;
        }

        public SemanticAtom Visit(Less n)
        {
            n.RealizedType = BinaryExpressionHelper(n, Primitive.Int, "<", Primitive.Boolean);
            return n.RealizedType;
        }

        public SemanticAtom Visit(Greater n)
        {
            n.RealizedType = BinaryExpressionHelper(n, Primitive.Int, ">", Primitive.Boolean);
            return n.RealizedType;
        }

        public SemanticAtom Visit(LessEqual n)
        {
            n.RealizedType = BinaryExpressionHelper(n, Primitive.Int, "<=", Primitive.Boolean);
            return n.RealizedType;
        }

        public SemanticAtom Visit(GreaterEqual n)
        {
            n.RealizedType = BinaryExpressionHelper(n, Primitive.Int, ">=", Primitive.Boolean);
            return n.RealizedType;
        }

        public SemanticAtom Visit(Instanceof n)
        {
            var left = n.LeftExpression.Accept(this);
            var leftLocation = n.LeftExpression.Location;

            if (!(left is Class))
                Globals.Errors.Add($"[{leftLocation.StartLine}, {leftLocation.StartColumn}] Left expression of operator(instanceof) ({left.Name}) is not a class type.");

            n.RealizedType = Primitive.Boolean;
            return n.RealizedType;
        }

        public SemanticAtom Visit(NotEqual n)
        {
            var left = n.LeftExpression.Accept(this) as SemanticType;
            var right = n.RightExpression.Accept(this) as SemanticType;

            if (!left.IsAssignableFrom(right) && !right.IsAssignableFrom(left))
                Globals.Errors.Add($"[{n.LeftExpression.Location.StartLine}, {n.LeftExpression.Location.StartColumn}] The two expressions of (!=) are not comparable types ({left.Name}, {right.Name}).");

            n.RealizedType = Primitive.Boolean;
            return n.RealizedType;
        }

        public SemanticAtom Visit(Equal n)
        {
            var left = n.LeftExpression.Accept(this) as SemanticType;
            var right = n.RightExpression.Accept(this) as SemanticType;

            if (!left.IsAssignableFrom(right) && !right.IsAssignableFrom(left))
                Globals.Errors.Add($"[{n.LeftExpression.Location.StartLine}, {n.LeftExpression.Location.StartColumn}] The two expressions of operator(==) are not comparable types ({left.Name}, {right.Name}).");

            n.RealizedType = Primitive.Boolean;
            return n.RealizedType;
        }

        public SemanticAtom Visit(Plus n)
        {
            var left = n.LeftExpression.Accept(this);
            var right = n.RightExpression.Accept(this);
            var leftLocation = n.LeftExpression.Location;
            var rightLocation = n.RightExpression.Location;

            if (left != Primitive.String && left != Primitive.Int)
                Globals.Errors.Add($"[{leftLocation.StartLine}, {leftLocation.StartColumn}] Left expression of operator(+) ({left.Name}) is not assignable to String or int.");

            if (right != Primitive.String && right != Primitive.Int)
                Globals.Errors.Add($"[{rightLocation.StartLine}, {rightLocation.StartColumn}] Right expression of operator(+) ({right.Name}) is not assignable to String or int.");

            n.RealizedType = left == Primitive.String || right == Primitive.String ? Primitive.String : Primitive.Int;
            return n.RealizedType;
        }

        public SemanticAtom Visit(Minus n)
        {
            n.RealizedType = BinaryExpressionHelper(n, Primitive.Int, "-", Primitive.Int);
            return n.RealizedType;
        }

        public SemanticAtom Visit(Mod n)
        {
            n.RealizedType = BinaryExpressionHelper(n, Primitive.Int, "%", Primitive.Int);
            return n.RealizedType;
        }

        public SemanticAtom Visit(Divide n)
        {
            n.RealizedType = BinaryExpressionHelper(n, Primitive.Int, "/", Primitive.Int);
            return n.RealizedType;
        }

        public SemanticAtom Visit(Multiply n)
        {
            n.RealizedType = BinaryExpressionHelper(n, Primitive.Int, "*", Primitive.Int);
            return n.RealizedType;
        }

        public SemanticAtom Visit(ArrayAccess n)
        {
            if (n.Array.Accept(this) != Primitive.IntArray)
                Globals.Errors.Add($"[{n.Array.Location.StartLine}, {n.Array.Location.StartColumn}] Array is not an {Primitive.IntArray.Name}.");

            if (n.Index.Accept(this) != Primitive.Int)
                Globals.Errors.Add($"[{n.Index.Location.StartLine}, {n.Index.Location.StartColumn}] Index expression is not of type {Primitive.Int.Name}.");

            n.RealizedType = Primitive.Int;
            return n.RealizedType;
        }

        public SemanticAtom Visit(ArrayLength n)
        {
            if (n.Array.Accept(this) != Primitive.IntArray)
                Globals.Errors.Add($"[{n.Array.Location.StartLine}, {n.Array.Location.StartColumn}] Array is not an {Primitive.IntArray.Name}.");

            n.RealizedType = Primitive.Int;
            return n.RealizedType;
        }

        public SemanticAtom Visit(Cast n)
        {
            var exp = n.Expression.Accept(this);
            var loc = n.Expression.Location;

            if (!(exp is Class))
                Globals.Errors.Add($"[{loc.StartLine}, {loc.StartColumn}] Expression of cast ({n.TypeNameToCast}) ({exp.Name}) is not a class type.");

            n.RealizedType = n.RealizedTypeToCast;
            return n.RealizedType;
        }

        public SemanticAtom Visit(Integer n)
        {
            n.RealizedType = Primitive.Int;
            return n.RealizedType;
        }

        public SemanticAtom Visit(Ast.String n)
        {
            n.RealizedType = Primitive.String;
            return n.RealizedType;
        }

        public SemanticAtom Visit(True n)
        {
            n.RealizedType = Primitive.Boolean;
            return n.RealizedType;
        }

        public SemanticAtom Visit(False n)
        {
            n.RealizedType = Primitive.Boolean;
            return n.RealizedType;
        }

        public SemanticAtom Visit(Null n)
        {
            n.RealizedType = Class.Null;
            return n.RealizedType;
        }

        public SemanticAtom Visit(IdentifierExpression n)
        {
            n.RealizedType = CurrentBlock.LookupIdentifierType(n.Name, n.Location);
            return n.RealizedType;
        }

        public SemanticAtom Visit(This n)
        {
            n.RealizedType = CurrentMethod.OwnerClass;
            return n.RealizedType;
        }

        public SemanticAtom Visit(NewArray n)
        {
            return Primitive.IntArray;
        }

        public SemanticAtom Visit(NewObject n)
        {
            n.RealizedType = Globals.TypeTable[n.Name];
            return n.RealizedType;
        }

        public SemanticAtom Visit(Not n)
        {
            if (n.Expression.Accept(this) != Primitive.Boolean)
                Globals.Errors.Add($"[{n.Expression.Location.StartLine}, {n.Expression.Location.StartColumn}] Expression of operator(!) is not {Primitive.Boolean.Name}.");

            n.RealizedType = Primitive.Boolean;
            return n.RealizedType;
        }

        public SemanticAtom Visit(Parenthetical n)
        {
            n.RealizedType = n.Expression.Accept(this) as SemanticType;
            return n.RealizedType;
        }

        #endregion
    }
}
