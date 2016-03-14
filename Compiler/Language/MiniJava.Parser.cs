using System.Collections.Generic;
using System.IO;
using Compiler.Ast;

namespace Compiler.Language
{
    internal partial class MiniJavaParser
    {
        public List<string> Errors => (this.Scanner as MiniJavaScanner).Errors;

        public MiniJavaParser() : base(null) { }

        public Goal Parse(string s)
        {
            var inputBuffer = System.Text.Encoding.Default.GetBytes(s);
            var stream = new MemoryStream(inputBuffer);
            this.Scanner = new MiniJavaScanner(stream);
            this.Parse();

            return this.CurrentSemanticValue as Goal;
        }
    }
}
