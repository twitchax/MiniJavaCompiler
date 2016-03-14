using Compiler.Semantics;
using Compiler.Visitors;
using QUT.Gppg;

namespace Compiler.Ast
{
    #region Lists

    internal class ClassList : ListNode<AstClass>
    {
        public ClassList() : base(nameof(ClassList), null)
        {
        }
    }

    internal class ClassDeclarationList : ListNode<Declaration>
    {
        public ClassDeclarationList() : base(nameof(ClassDeclarationList), null)
        {
        }
    }

    #endregion

    #region Productions

    internal class MainClass : VisitorNode
    {
        public string Name { get; private set; }
        public string ArgsName { get; private set; }
        public Statement MainMethodBody { get; private set; }

        public MainClass(string name, string argsName, Statement mainMethodBody, LexLocation location) : base(nameof(MainClass), location)
        {
            Name = name;
            ArgsName = argsName;
            MainMethodBody = mainMethodBody;
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

    internal class AstClass : VisitorNode
    {
        public string Name { get; private set; }
        public ClassExtension ClassExtension { get; private set; }
        public ClassDeclarationList ClassDeclarationList { get; private set; }

        public AstClass(string name, ClassExtension classExtension, ClassDeclarationList classDeclarationList, LexLocation location) : base(nameof(AstClass), location)
        {
            Name = name;
            ClassExtension = classExtension;
            ClassDeclarationList = classDeclarationList;
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

    internal class ClassExtension : VisitorNode
    {
        public string Name { get; private set; }

        public ClassExtension(string name, LexLocation location) : base(nameof(ClassExtension), location)
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

    #endregion
}
