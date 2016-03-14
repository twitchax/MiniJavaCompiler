using QUT.Gppg;

namespace Compiler.Semantics
{
    internal class UtilizedType : SemanticAtom
    {
        public LexLocation UtilizationLocation { get; private set; }

        public UtilizedType(string name, LexLocation utilizationLocation) : base(name, null)
        {
            UtilizationLocation = utilizationLocation;
        }
    }
}
