using System;
using System.Collections.Generic;
using Compiler.Assembler;
using Compiler.Semantics;

namespace Compiler.Visitors
{
    internal static class Globals
    {
        internal static Dictionary<string, SemanticType> TypeTable { get; } = new Dictionary<string, SemanticType>();
        internal static List<UtilizationPointerTuple> TypeUtilization { get; } = new List<UtilizationPointerTuple>();
        internal static Dictionary<string, string> StringTable { get; } = new Dictionary<string, string>();
        internal static List<string> Errors { get; } = new List<string>();
        internal static Builder Builder { get; set; }
    }

    internal class UtilizationPointerTuple : Tuple<UtilizedType, Action<SemanticType>>
    {
        public UtilizedType UtilizedType => base.Item1;
        public Action<SemanticType> RealizationAction => base.Item2;

        public UtilizationPointerTuple(UtilizedType utilizedType, Action<SemanticType> realizationAction) : base(utilizedType, realizationAction)
        {
        }
    }
}
