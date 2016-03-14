using System;
using System.IO;
using System.Linq;
using Compiler.Assembler;
using Compiler.Ast;
using Compiler.Language;
using Compiler.Semantics;
using Compiler.Visitors;
using static Compiler.Helpers;

namespace Compiler
{
    internal class Program
    {
        private static void Main(string[] args)
        {
            var workingDirectory = "testfiles";

            Start:

            var path = "";
            var arg = "";

            switch (args.Length)
            {
                case 2:
                    arg = args[0];
                    path = args[1];
                    if (args[0] == "-W") // F5 scenario.
                    {
                        workingDirectory = "..\\..\\..\\testfiles";
                        goto default;
                    }
                    break;
                case 1:
                    arg = "-C";
                    path = args[0];
                    break;
                default:
                    try
                    {
                        var files = Directory.GetFiles(workingDirectory);

                        WriteLine("Choose a test file:");
                        for (int k = 0; k < files.Length; k++)
                            WriteLine($"   [{k + 1}] {new FileInfo(files[k]).Name}");
                        WriteLine("   [Q] QUIT");

                        Write("Enter number of file: ");
                        var fileNum = Console.ReadLine();
                        if(fileNum.ToLower() == "q")
                            goto Exit;
                        path = files[uint.Parse(fileNum) - 1];

                        WriteLine("Choose a visitor:");
                        WriteLine("   [1] Tree (-A)");
                        WriteLine("   [2] Pretty (-P)");
                        WriteLine("   [3] Semantics (-T)");
                        WriteLine("   [4] Compile (-C)");

                        Write("Enter number of visitor: ");
                        switch (uint.Parse(Console.ReadLine()))
                        {
                            case 1:
                                arg = "-A";
                                break;
                            case 2:
                                arg = "-P";
                                break;
                            case 3:
                                arg = "-T";
                                break;
                            case 4:
                                arg = "-C";
                                break;
                            default:
                                throw new Exception("Bad arg.");
                        }
                    }
                    catch (Exception)
                    {
                        WriteLineColor("Incorrect option selected...starting over.", ConsoleColor.Red, ConsoleColor.Black);
                        WriteLine();
                        args = new string[0];
                        goto Start;
                    }
                    break;
            }

            var fileName = new FileInfo(path).Name;
            WriteLine($"Parse of {fileName}:");
            WriteLine();

            var goal = Parse(path);

            if (goal == null)
                goto Cleanup;

            switch (arg.ToUpper())
            {
                case "-S":
                case "-T":
                    PrintSemanticCheck(goal);
                    break;
                case "-P":
                    PrintPretty(goal);
                    break;
                case "-A":
                    PrintTree(goal);
                    break;
                case "-C":
                    Build(goal, fileName);
                    break;
            }

            Cleanup:

            WriteLine();
            WriteColor("Finished!  ", ConsoleColor.Green, ConsoleColor.Black);
            WriteLine("Press any key to close (\"r\" to run again)...");

            if (Console.ReadKey().KeyChar == 'r')
            {
                WriteLine();
                args = new string[0];
                goto Start;
            }

            Exit:{}
        }

        private static Goal Parse(string path)
        {
            var parser = new MiniJavaParser();

            try
            {
                var goal = parser.Parse(File.ReadAllText(path));
                if(goal == null)
                    foreach (var error in parser.Errors)
                        Helpers.WriteLineColor(error, ConsoleColor.Red, ConsoleColor.Black);
                return goal;
            }
            catch (Exception)
            {
                foreach(var error in parser.Errors)
                    Helpers.WriteLineColor(error, ConsoleColor.Red, ConsoleColor.Black);
                return null;
            }
        }

        private static void PrintTree(Goal goal)
        {
            var visitor = new TreeVisitor();
            goal.Accept(visitor);
        }

        private static void PrintPretty(Goal goal)
        {
            var visitor = new PrettyVisitor();
            goal.Accept(visitor);
        }

        private static void PrintSemanticCheck(Goal goal)
        {
            var globalTypeVistor = new GlobalTypeVistor();
            var typeVisitor = new TypeCheckerVistor();

            // Clear globals from any past run.
            Globals.TypeTable.Clear();
            Globals.TypeUtilization.Clear();
            Globals.StringTable.Clear();
            Globals.Errors.Clear();

            // Run the semantic checker.
            goal.Accept(globalTypeVistor);
            goal.Accept(typeVisitor);

            // Print errors.
            if (Globals.Errors.Any())
            {
                WriteLineColor($"Found {Globals.Errors.Count} errors.", ConsoleColor.Red, ConsoleColor.Black);
                WriteLine();
                foreach (var e in Globals.Errors)
                    WriteLineColor(e, ConsoleColor.Red, ConsoleColor.Black);
                WriteLine();
            }
            else
            {
                WriteLineColor("No errors!", ConsoleColor.Green, ConsoleColor.Black);
                WriteLine();
            }

            WriteLineColor("Type Table", ConsoleColor.DarkYellow, ConsoleColor.Black);
            WriteLine();

            // Print type table.
            foreach (var c in Globals.TypeTable.EnumerateValues().Where(t => !t.IsPrimitive && t != Class.Unknown).Cast<Class>())
            {
                WriteLine($"{c.Name} : {c.BaseClass?.Name ?? "void"}{(c.IsMainClass ? " (main)" : "")} [{c.DeclarationLocation.StartLine}, {c.DeclarationLocation.StartColumn}]");

                WriteLine(" Properties");
                foreach (var prop in c.Properties.EnumerateValues())
                {
                    WriteLine($"  {prop.Name}: {prop.RealizedType.Name} [{prop.DeclarationLocation.StartLine}, {prop.DeclarationLocation.StartColumn}]");
                }

                WriteLine(" Methods");
                foreach (var method in c.Methods.EnumerateValues())
                {
                    WriteLine($"  {method.Name}: {method.RealizedReturnType.Name} [{method.DeclarationLocation.StartLine}, {method.DeclarationLocation.StartColumn}]");

                    WriteLine("   Arguments");
                    foreach(var arg in method.Arguments.EnumerateValues())
                        WriteLine($"    {arg.Name}: {arg.RealizedType.Name} [{arg.DeclarationLocation.StartLine}, {arg.DeclarationLocation.StartColumn}]");
                }
            }
        }

        private static void Build(Goal goal, string fileName)
        {
            var globalTypeVistor = new GlobalTypeVistor();
            var typeVisitor = new TypeCheckerVistor();
            var instructionVisitor = new InstructionVisitor();

            // Clear globals from any past run.
            Globals.TypeTable.Clear();
            Globals.TypeUtilization.Clear();
            Globals.StringTable.Clear();
            Globals.Errors.Clear();

            // Run the semantic checker.
            goal.Accept(globalTypeVistor);
            goal.Accept(typeVisitor);

            // Print errors.
            if (Globals.Errors.Any())
            {
                WriteLineColor($"Found {Globals.Errors.Count} errors.", ConsoleColor.Red, ConsoleColor.Black);
                WriteLine();
                foreach (var e in Globals.Errors)
                    WriteLineColor(e, ConsoleColor.Red, ConsoleColor.Black);
                WriteLine();
                return;
            }

            WriteLineColor("No errors!", ConsoleColor.Green, ConsoleColor.Black);
            WriteLine();

            Globals.Builder = new Builder(fileName);
            goal.Accept(instructionVisitor);
            Globals.Builder.BuildAndRun();
        }
    }
}
