%namespace Compiler.Language
%scannertype MiniJavaScanner
%visibility internal

%option stack, parser, verbose, persistbuffer, noembedbuffers

%tokentype Token

Eol                 (\r\n?|\n)
WhiteSpace          {Eol}|[ \t]+
Digit               [0-9]
Number              (0x[0-9A-Fa-f]+)|([0-9]+)
Letter              [A-Za-z]
OneLineComment      (\/\/.*{Eol}?)
MultiLineComment    (\/\*([^*]*|(\*+[^/*]))*\*+\/)

%{

%}

%%

/* Scanner body */

/* Comments. */
{WhiteSpace}|{OneLineComment}|{MultiLineComment}    /* skip */

/* Reserved words. */
"class"                                             { return GetToken(Token.Class); }
"public"                                            { return GetToken(Token.Public); }
"static"                                            { return GetToken(Token.Static); }
"void"                                              { return GetToken(Token.Void); }
"main"                                              { return GetToken(Token.Main); }
"new"                                               { return GetToken(Token.New); }
"extends"                                           { return GetToken(Token.Extends); }
"if"                                                { return GetToken(Token.If); }
"else"                                              { return GetToken(Token.Else); }
"while"                                             { return GetToken(Token.While); }
"for"                                               { return GetToken(Token.For); }
"return"                                            { return GetToken(Token.Return); }
"this"                                              { return GetToken(Token.This); }
"int"                                               { return GetToken(Token.Int); }
"String"                                            { return GetToken(Token.String); }
"boolean"                                           { return GetToken(Token.Boolean); }
"System.out.println"                                { return GetToken(Token.Println); }
"System.in.readln"                                  { return GetToken(Token.Readln); }
"System.compiler.destroy"                           { return GetToken(Token.Destroy); }
"System.compiler.exception"                         { return GetToken(Token.Exception); }
"System.compiler.atol"                              { return GetToken(Token.Atol); }
"length"                                            { return GetToken(Token.Length); }
"true"                                              { return GetToken(Token.True); }
"false"                                             { return GetToken(Token.False); }
"null"                                              { return GetToken(Token.Null); }

/* Operators */
"+"                                                 { return GetToken(Token.Plus); }
"-"                                                 { return GetToken(Token.Minus); }
"*"                                                 { return GetToken(Token.Multiply); }
"/"                                                 { return GetToken(Token.Divide); }
"<="                                                { return GetToken(Token.LessEqual); }
">="                                                { return GetToken(Token.GreaterEqual); }
"instanceof"                                        { return GetToken(Token.Instanceof); }
"<"                                                 { return GetToken(Token.Less); }
">"                                                 { return GetToken(Token.Greater); }
"=="                                                { return GetToken(Token.Equal); }
"!="                                                { return GetToken(Token.NotEqual); }
"!"                                                 { return GetToken(Token.Not); }
"%"                                                 { return GetToken(Token.Mod); }
"&&"                                                { return GetToken(Token.And); }
"||"                                                { return GetToken(Token.Or); }
"="                                                 { return GetToken(Token.Becomes); }

"++"                                                { return GetToken(Token.PlusPlus); }
"--"                                                { return GetToken(Token.MinusMinus); }
"+="                                                { return GetToken(Token.PlusBecomes); }
"-="                                                { return GetToken(Token.MinusBecomes); }
"*="                                                { return GetToken(Token.MultiplyBecomes); }
"/="                                                { return GetToken(Token.DivideBecomes); }
"%="                                                { return GetToken(Token.ModBecomes); }

/* Delimiters. */
"("                                                 { return GetToken(Token.LParenthesis); }
")"                                                 { return GetToken(Token.RParenthesis); }
"["                                                 { return GetToken(Token.LBracket); }
"]"                                                 { return GetToken(Token.RBracket); }
"{"                                                 { return GetToken(Token.LBrace); }
"}"                                                 { return GetToken(Token.RBrace); }
"."                                                 { return GetToken(Token.Dot); }
","                                                 { return GetToken(Token.Comma); }
";"                                                 { return GetToken(Token.Semicolon); }

/* String */
\"(\\.|[^\\"])*\"                                   { return GetToken(Token.StringLiteral);}

/* Identifiers. */
({Letter}|_)({Letter}|{Digit}|_)*                   { return GetToken(Token.Identifier); }

/* Numbers. */
{Number}                                            { return GetToken(Token.Integer); }

.                                                   { return GetToken(Token.Unrecognized); }

%%