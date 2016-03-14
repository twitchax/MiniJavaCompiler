using Compiler.Language;
using QUT.Gppg;

namespace Compiler.Ast
{
    internal sealed class TokenNode : Node
    {
        public Token Token { get; private set; }

        public TokenNode(Token token, string text, LexLocation location) : base(text, location)
        {
            Token = token;
        }
    }
}
