using Compiler.Semantics;
using Compiler.Visitors;
using QUT.Gppg;

namespace Compiler.Ast
{
    internal class Goal : VisitorNode
    {
        public MainClass MainClass { get; private set; }
        public ClassList ClassList { get; private set; }

        public Goal(MainClass mainClass, ClassList classList, LexLocation location) : base(nameof(Goal), location)
        {
            MainClass = mainClass;
            ClassList = classList;
        }

        public void Accept(IVisitor v)
        {
            v.Visit(this);
        }

        public override void Accept(IPlainVisitor v)
        {
            Accept(v);
        }

        public override SemanticAtom Accept(ITypeVisitor v)
        {
            Accept(v);
            return null;
        }
    }
}
