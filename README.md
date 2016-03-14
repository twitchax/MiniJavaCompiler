Requirements:

    1. Windows 10 (https://www.microsoft.com/en-us/software-download/windows10).
    2. Visual Studio 2015 (https://www.visualstudio.com/en-us/downloads/download-visual-studio-vs.aspx).
    3. UCRTD.lib (https://msdn.microsoft.com/en-us/library/abx4dbyh.aspx): 
        a. Windows 10 SDK (https://dev.windows.com/en-us/downloads/windows-10-sdk).
        b. Elsewhere.

    Two locations are required to have the compiler automatically build the emitted assembly instructions (optional):
        1. C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\bin\amd64\ml64.exe (location of the assembly compiler).
        2. C:\Program Files (x86)\Windows Kits\10\Lib\10.0.10240.0\ucrt\x64 (location of ucrt.lib, the newest library for Windows 10 CRT methods).
    If you want to build the emmitted assembly yourself, then any Microsoft-compatible assembler should work
    as long as ucrtd.lib can be compiled against.
        
Build:

   Compiler.sln in Visual Studio 2015.
   
   The binary (debug or release) will be dropped in the root directory for your convenience.  
   There is also a set of test files in the root directory which test the compiler; in addition, 
   there are some test files ("Z_") which deliberately cause errors in the semantic check mode ("-T").
   The first test file ("A_TEST") seeks to exercise as many of the extra features as possible, but
   some the target "Start" function may need to be changed to test some functionality.

Usage:

   There are two different ways to run the compiler:

      Compiler.exe {option: [-A, -P, -T, -C]} file.java

      or

      Compiler.exe

   The latter will give you the option to choose from one of the test files; in addition, you can 
   choose which mode to run in on those test files.

Files:

   LEX file is "*.lex" and grammar file is "*.y".