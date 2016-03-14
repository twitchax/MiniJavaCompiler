using System.Collections.Generic;
using Compiler.Ast;

namespace Compiler.Language
{
    internal partial class MiniJavaScanner
    {
        public List<string> Errors { get; } = new List<string>();

        public int GetToken(Token token)
        {
            yylval = new TokenNode(token, yytext, new QUT.Gppg.LexLocation(this.yyline, this.yycol, this.yyline, this.yycol + this.yytext.Length));
            return (int)token;
        }

		public override void yyerror(string format, params object[] args)
		{
			base.yyerror(format, args);
		    var errorText = $"[{this.yyline}, {this.yycol}] " + string.Format(format, args);
            Errors.Add(errorText);
		}
    }
}
