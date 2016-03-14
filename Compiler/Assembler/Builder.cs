using System;
using System.Diagnostics;
using System.IO;
using System.Text;
using Compiler.Visitors;
using QUT.Gppg;

namespace Compiler.Assembler
{
    internal class Builder
    {
        private string _tab = "";
        private uint _counter = 1;

        private string FileName { get; }
        private StringBuilder AssemblyString { get; } = new StringBuilder(10000);

        public Builder(string fileName)
        {
            FileName = fileName;
        }

        private string EmitComment(string comment = null)
        {
            return comment != null ? "; " + comment : "";
        }

        public void Tab()
        {
            _tab += "    ";
        }

        public void Untab()
        {
            _tab = _tab.Substring(4);
        }

        public uint Count()
        {
            return _counter++;
        }

        public void WritePreamble()
        {
            AssemblyString.Append(
@"
includelib ucrtd.lib

extern _CrtIsValidHeapPointer : proc

extern puts : proc
extern gets : proc
extern atol : proc
extern calloc : proc
extern free : proc
extern strcat : proc
extern strcpy : proc
extern strlen : proc

extern _getch : proc
extern _itoa : proc
extern _exit : proc
");
        }

        public void WriteVtable(string entry, string comment = "")
        {
            Write($"{_tab}{entry}", comment);
        }

        public void WriteStartCode()
        {
            AssemblyString.Append(

@"
.code

    _intToString:
    
        ; Start Prologue
        push rbp      ; Save the old base pointer value (pop later).
        mov rbp, rsp  ; Set the new base pointer value (for this method).
        sub rsp, 8   ; Make room for 1 8-byte local variable(s)s.
        ; End prologue.
        
        ; Start copy vars.
        mov [rbp-8], rcx
        ; End copy vars.
        
        ; Start method body.
        mov rcx, 100
        mov rdx, 1
        sub rsp, 32
        call calloc
        add rsp, 32
        
        ; Move pointer into rdx
        mov rdx, rax
        
        ; Move base 10 into third parameter.
        mov r8, 10
        
        ; Move the integer back into rcx.
        mov rcx, [rbp-8]
        
        sub rsp, 32
        call _itoa
        add rsp, 32
        ;End method body.

        ; Start Epilogue
        mov rsp, rbp ; Deallocate local variables
        pop rbp ; Restore the caller's base pointer value
        ret
        ; End Epilogue

    _writeInt:
        ; Prologue
        push rbp      ; Save the old base pointer value (pop later).
        mov rbp, rsp  ; Set the new base pointer value (for this method).
        ;sub rsp, 0   ; Make room for zero 8-byte local variables.
        
        sub rsp, 32
        call _intToString ; rax has pointer to string.
        add rsp, 32
        
        mov rcx, rax
        sub rsp, 32
        call puts
        add rsp, 32

        ; Subroutine Epilogue
        mov rsp, rbp ; Deallocate local variables
        pop rbp ; Restore the caller's base pointer value
        ret

");
        }

        public void WriteEnd()
        {
            AssemblyString.Append("end");
        }

        public void Write(string str = "", string comment = null)
        {
            AssemblyString.AppendLine($"{_tab}{str} {EmitComment(comment)}");
        }

        public void Kill(int code)
        {
            WriteBinaryOp("mov", "rcx", code.ToString());
            WriteCall("_exit");
        }

        public void DebugBreak()
        {
            Write("int 3");
        }

        public void WriteComment(string comment)
        {
            AssemblyString.AppendLine($"{_tab}; {comment}");
        }

        public void WriteUnaryOp(string op, string source, string comment = null)
        {
            Write($"{op} {source}", comment);
        }

        public void WriteBinaryOp(string op, string dest, string source, string comment = null)
        {
            Write($"{op} {dest}, {source}", comment);
        }

        public void WriteLabel(string label, string comment = null)
        {
            Write($"{label}:", comment);
        }

        public void WriteCall(string methodLocation, string comment = null)
        {
            Write();
            WriteBinaryOp("sub", "rsp", "32");
            Write($"call {methodLocation}", comment);
            WriteBinaryOp("add", "rsp", "32");
            Write();
        }

        public void WriteLocalCreation(int amount)
        {
            WriteBinaryOp("sub", "rsp", (8 * amount).ToString());

            // Zero out the local space.
            WriteBinaryOp("mov", "rax", 0.ToString());
            for (int k = 1; k <= amount; k++)
            {
                WriteBinaryOp("mov", $"[rbp-{k * 8}]", "rax");
            }
        }

        #region Specialized Helpers

        public void AllocateMemory(string count, string size, LexLocation loc)
        {
            Start($"check and allocate memory [{loc.StartLine}, {loc.StartColumn}]");

            var labelEnd = $"allocSucceeded{Count()}";
            var labelFail = $"allocTooBig{Count()}";

            WriteBinaryOp("mov", "rcx", count);
            WriteBinaryOp("imul", "rcx", size);

            WriteBinaryOp("cmp", "rcx", Math.Pow(2, 30).ToString() /* 1 GB */);
            WriteUnaryOp("jg", labelFail);

            WriteBinaryOp("mov", "rdx", 1.ToString());
            WriteCall("calloc");

            WriteBinaryOp("cmp", "rax", 0.ToString());
            WriteUnaryOp("jne", labelEnd);

            WriteLabel(labelFail);
            RuntimeErrorAndExit(13859, $"Failed to allocate memory (more than 1 GB) at [{loc.StartLine}, {loc.StartColumn}].");

            WriteLabel(labelEnd);

            End($"check and allocate memory [{loc.EndLine}, {loc.EndColumn}]");
        }

        public void AddToStringTable(string s)
        {
            if (!Globals.StringTable.ContainsKey(s))
            {
                Globals.StringTable.Add(s, $"$$runtimeStr{Count()}");
            }
        }

        public void WriteRuntimeString(string s = "")
        {
            Start("write runtime string");

            s = "\"" + s + "\"";
            AddToStringTable(s);
            WriteBinaryOp("lea", "rcx", Globals.StringTable[s]);
            WriteCall("puts");

            End("write runtime string");
        }

        public void RuntimeErrorAndExit(int code, string error)
        {
            WriteRuntimeString($"\n!!!!!ERROR!!!!!\n    {error}  Killing application and reporting exit code ({code})...\n!!!!!ERROR!!!!!\n");
            Kill(code);
        }

        public void Start(string s)
        {
            Write();
            WriteComment($"Start {s}.");
            Tab();
        }

        public void End(string s)
        {
            Untab();
            WriteComment($"End {s}.");
            Write();
        }

        #endregion

        public void BuildAndRun()
        {
            var assemblyFileName = FileName + ".asm";
            var exeFileName = FileName + ".exe";

            // First write the string to the assembly file.
            Helpers.WriteColor("Emitting assembly...", ConsoleColor.Blue, ConsoleColor.Black);
            File.WriteAllText(assemblyFileName, AssemblyString.ToString());
            Helpers.WriteLineColor("Emit succeeeded!\n", ConsoleColor.Green, ConsoleColor.Black);

            Helpers.WriteLine("\nPress any key to build and run the emmitted assembly (\"e\" to continue)...\n");
            if (Console.ReadKey().KeyChar == 'e')
                return;

            // Build and link executable.
            Helpers.WriteLineColor("Building exe...", ConsoleColor.Blue, ConsoleColor.Black);
            Helpers.WriteLine();
            var buildProcess = new Process
            {
                StartInfo =
                    new ProcessStartInfo(
                        "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\bin\\amd64\\ml64.exe",
                        $"{assemblyFileName} /link /subsystem:console /machine:x64 /libpath:\"C:\\Program Files (x86)\\Windows Kits\\10\\Lib\\10.0.10240.0\\ucrt\\x64\"")
                    {
                        RedirectStandardOutput = true,
                        UseShellExecute = false
                    }
            };
            buildProcess.Start();

            buildProcess.WaitForExit(10000);
            Helpers.WriteLine(buildProcess.StandardOutput.ReadToEnd());

            if (buildProcess.ExitCode != 0)
            {
                Helpers.WriteLineColor("Assembly build error!", ConsoleColor.Red, ConsoleColor.Black);
                return;
            }

            Helpers.WriteLineColor("Build succeeeded!", ConsoleColor.Green, ConsoleColor.Black);

            Helpers.WriteLineColor("Running exe...", ConsoleColor.Blue, ConsoleColor.Black);
            Helpers.WriteLine();

            // Run built exe.
            var runProcess = new Process
            {
                StartInfo =
                    new ProcessStartInfo(exeFileName)
                    {
                        RedirectStandardOutput = true,
                        UseShellExecute = false
                    }
            };
            runProcess.Start();

            runProcess.WaitForExit(30000);
            Helpers.WriteLine(runProcess.StandardOutput.ReadToEnd());

            if (runProcess.ExitCode != 0)
            {
                Helpers.WriteLineColor($"Executable error ({runProcess.ExitCode})!", ConsoleColor.Red, ConsoleColor.Black);
                switch (runProcess.ExitCode)
                {
                    case 6:
                        Helpers.WriteLineColor("Null reference exception.", ConsoleColor.Red, ConsoleColor.Black);
                        break;
                    case 9:
                        Helpers.WriteLineColor("Memory freed exception.", ConsoleColor.Red, ConsoleColor.Black);
                        break;
                    case 1734:
                        Helpers.WriteLineColor("Array out of bounds exception.", ConsoleColor.Red, ConsoleColor.Black);
                        break;
                    case 1827:
                        Helpers.WriteLineColor("Invalid cast exception.", ConsoleColor.Red, ConsoleColor.Black);
                        break;
                    case 13859:
                        Helpers.WriteLineColor("Memory allocation failed.", ConsoleColor.Red, ConsoleColor.Black);
                        break;
                }

                return;
            }

            Helpers.WriteLineColor("Run succeeeded!", ConsoleColor.Green, ConsoleColor.Black);
        }
    }
}
