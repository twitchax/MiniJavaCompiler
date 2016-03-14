using QUT.Gppg;

namespace Compiler.Semantics
{
    internal abstract class SemanticAtom
    {
        public string Name { get; private set; }
        public LexLocation DeclarationLocation { get; private set; }

        protected SemanticAtom(string name, LexLocation declarationLocation)
        {
            Name = name;
            DeclarationLocation = declarationLocation;
        }
    }
}
