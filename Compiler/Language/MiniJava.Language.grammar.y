%namespace Compiler.Language
%partial
%parsertype MiniJavaParser
%sharetokens
%visibility internal
%tokentype Token

%using Compiler
%using Compiler.Ast

%YYSTYPE Compiler.Ast.Node

%start GOAL

%token 
    Unrecognized, Comment
    Display, Class, Integer, StringLiteral, Public, Static, Void, Null, Main, New, Extends, If, Else, While, For, Return, This, Instanceof
    Int, Boolean, Println, Destroy, Readln, Exception, Atol, String
    Plus, Minus, Becomes, Multiply, Divide, Less, Greater, LessEqual, GreaterEqual, Equal, NotEqual, Not, Mod, And, Or
    PlusPlus, MinusMinus, PlusBecomes, MinusBecomes, MultiplyBecomes, DivideBecomes, ModBecomes
    LParenthesis, RParenthesis, LBracket, RBracket, LBrace, RBrace
    Length, True, False
    Dot, 
    Comma, 
    Semicolon, 
    Identifier 

// From: https://docs.oracle.com/javase/tutorial/java/nutsandbolts/operators.html

%right Becomes PlusBecomes MinusBecomes MultiplyBecomes DivideBecomes ModBecomes
%left Or
%left And
// Bitwise stuff.
%left Equal NotEqual
%left Less Greater LessEqual GreaterEqual Instanceof
%left Plus Minus
// Shifts would go here.
%left Multiply Divide Mod
%left Not
%left PlusPlus MinusMinus
%left LBracket RBracket
%left Dot
%left LParenthesis RParenthesis
 
%%

GOAL                    : MAIN_CLASS CLASS_LIST
                            { Helpers.WriteDebug("Found a GOAL."); $$ = new Goal((MainClass)$1, (ClassList)$2, $1.Location); }
                        ;

MAIN_CLASS              : Class Identifier LBrace Public Static Void Main LParenthesis String LBracket RBracket Identifier RParenthesis STATEMENT RBrace
                            { Helpers.WriteDebug("Found a MAIN_CLASS."); $$ = new MainClass($2.Text, $12.Text, (Statement)$14, $2.Location); }
                        ;

CLASS_LIST              : CLASS_LIST CLASS_DECLARATION
                            { ((ClassList)$1).Add((AstClass)$2); $$ = $1; }
                        | /*empty */
                            { Helpers.WriteDebug("Found a CLASS_LIST."); $$ = new ClassList(); }
                        ;

CLASS_DECLARATION       : Class Identifier CLASS_EXTENSION LBrace CLASS_DECLARATION_LIST RBrace
                            { Helpers.WriteDebug("Found a CLASS_DECLARATION."); $$ = new AstClass($2.Text, (ClassExtension)$3, (ClassDeclarationList)$5, $2.Location); }
                        ;

CLASS_EXTENSION         : Extends Identifier
                            { Helpers.WriteDebug("Found a CLASS_EXTENSION."); $$ = new ClassExtension($2.Text, $1.Location); }
                        | /* empty */
                        ;

CLASS_DECLARATION_LIST  : CLASS_DECLARATION_LIST DECLARATION
                            { ((ClassDeclarationList)$1).Add((Declaration)$2); $$ = $1; }
                        | /* empty */
                            { Helpers.WriteDebug("Found a CLASS_DECLARATION_LIST."); $$ = new ClassDeclarationList(); }
                        ;

DECLARATION             : VAR_DECLARATION
                            { $$ = new Property(((Variable)$1).Name, ((Variable)$1).AstType, $1.Location); }
                        | METHOD_DECLARATION
                            { $$ = $1; }
                        ;

STATEMENT_LIST          : STATEMENT_LIST STATEMENT
                            { ((StatementList)$1).Add((Statement)$2); $$ = $1; }
                        | /* empty */
                            { Helpers.WriteDebug("Found a STATEMENT_LIST."); $$ = new StatementList(); }
                        ;

VAR_DECLARATION         : TYPE Identifier Semicolon
                            { Helpers.WriteDebug("Found a VAR_DECLARATION."); $$ = new Variable($2.Text, (AstType)$1, $2.Location); }
                        ;

ARGUMENT                : TYPE Identifier
                            { Helpers.WriteDebug("Found a ARGUMENT."); $$ = new Argument($2.Text, (AstType)$1, $2.Location); }
                        ;

ARGUMENT_LIST           : ARGUMENT CONTINUED_ARGUMENT_LIST
                            { Helpers.WriteDebug("Found a ARGUMENT_LIST."); $$ = new ArgumentList(); ((ArgumentList)$$).Add((Argument)$1); ((ArgumentList)$$).AddRange(((ContinuedArgumentList)$2)); }
                        | /* empty */
                            { Helpers.WriteDebug("Found a ARGUMENT_LIST."); $$ = new ArgumentList(); }
                        ;

CONTINUED_ARGUMENT_LIST : CONTINUED_ARGUMENT_LIST Comma ARGUMENT
                            { ((ContinuedArgumentList)$1).Add((Argument)$3); $$ = $1; }
                        | /* empty */
                            { Helpers.WriteDebug("Found a CONTINUED_ARGUMENT_LIST."); $$ = new ContinuedArgumentList(); }
                        ;

METHOD_DECLARATION      : Public TYPE Identifier LParenthesis ARGUMENT_LIST RParenthesis STATEMENT
                            { Helpers.WriteDebug("Found a MEHOD_DECLARATION."); $$ = new Method($3.Text, (AstType)$2, (ArgumentList)$5, (Statement)$7, $3.Location); }
                        | Public Void Identifier LParenthesis ARGUMENT_LIST RParenthesis STATEMENT
                            { Helpers.WriteDebug("Found a MEHOD_DECLARATION."); $$ = new Method($3.Text, null, (ArgumentList)$5, (Statement)$7, $3.Location); }
                        ;

TYPE                    : Int LBracket RBracket
                            { Helpers.WriteDebug("Found a TYPE_INT_ARRAY."); $$ = new IntArray($1.Location); }
                        | Boolean
                            { Helpers.WriteDebug("Found a TYPE_BOOLEAN."); $$ = new AstBoolean($1.Location); }
                        | Int
                            { Helpers.WriteDebug("Found a TYPE_INT."); $$ = new Int($1.Location); }
                        | String
                            { Helpers.WriteDebug("Found a TYPE_STRING."); $$ = new AstString($1.Location); }
                        | Identifier
                            { Helpers.WriteDebug("Found a TYPE_IDENTIFIER."); $$ = new Custom($1.Text, $1.Location); }
                        ;

STATEMENT               : VAR_DECLARATION
                            { Helpers.WriteDebug("Found a STATEMENT_VARIABLE_DECLARATION."); $$ = new VariableDeclaration(((Variable)$1).AstType, ((Variable)$1).Name, $1.Location); }
                        | LBrace STATEMENT_LIST RBrace
                            { Helpers.WriteDebug("Found a STATEMENT_BLOCK."); $$ = new Block((StatementList)$2, $1.Location); }
                        | If LParenthesis EXPRESSION RParenthesis STATEMENT Else STATEMENT
                            { Helpers.WriteDebug("Found an IF_ELSE."); $$ = new If((Expression)$3, (Statement)$5, (Statement)$7, $1.Location); }
                        | While LParenthesis EXPRESSION RParenthesis STATEMENT
                            { Helpers.WriteDebug("Found a WHILE."); $$ = new While((Expression)$3, (Statement)$5, $1.Location); }
                        | For LParenthesis SP_EXPRESSION_STATEMENT Semicolon EXPRESSION Semicolon EXPRESSION_STATEMENT RParenthesis STATEMENT
                            { Helpers.WriteDebug("Found a FOR."); $$ = new For((ExpressionStatement)$3, (Expression)$5, (ExpressionStatement)$7, (Statement)$9, $1.Location); }
                        | Return EXPRESSION Semicolon
                            { Helpers.WriteDebug("Found a RETURN"); $$ = new Return((Expression)$2, $1.Location); }
                        | Return Semicolon
                            { Helpers.WriteDebug("Found a RETURN"); $$ = new Return(null, $1.Location); }
                        | SP_EXPRESSION_STATEMENT Semicolon
                            { Helpers.WriteDebug("Found an EXPRESSION STATEMENT."); $$ = new ExpressionStatementStatement((ExpressionStatement)$1, $1.Location); }
                        ;

SP_EXPRESSION_STATEMENT : TYPE Identifier Becomes EXPRESSION
                            { Helpers.WriteDebug("Found an DECLARATION_ASSIGNMENT."); $$ = new DeclarationAssignment($2.Text, (AstType)$1, (Expression)$4, $1.Location); }
                        | EXPRESSION_STATEMENT
                        ;

EXPRESSION_STATEMENT    : Identifier Becomes EXPRESSION
                            { Helpers.WriteDebug("Found an ASSIGNMENT."); $$ = new Assignment($1.Text, (Expression)$3, $1.Location); }
                        | EXPRESSION LBracket EXPRESSION RBracket Becomes EXPRESSION
                            { Helpers.WriteDebug("Found an ARRAY_ASSIGNMENT."); $$ = new ArrayAssignment((Expression)$1, (Expression)$3, (Expression)$6, $1.Location); }
                        | EXPRESSION Dot Identifier LParenthesis EXPRESSION_LIST RParenthesis
                            { Helpers.WriteDebug("Found a METHOD_CALL."); $$ = new MethodCall((Expression)$1, $3.Text, (ExpressionList)$5, $1.Location); }
                        | Println LParenthesis EXPRESSION RParenthesis
                            { Helpers.WriteDebug("Found a PRINTLN."); $$ = new CompilerFunction((Expression)$3, $1.Text, $1.Location); }
                        | Println LParenthesis RParenthesis
                            { Helpers.WriteDebug("Found a PRINTLN."); $$ = new CompilerFunction(null, $1.Text, $1.Location); }
                        | Destroy LParenthesis EXPRESSION RParenthesis
                            { Helpers.WriteDebug("Found a DESTROY."); $$ = new CompilerFunction((Expression)$3, $1.Text, $1.Location); }
                        | Readln LParenthesis RParenthesis
                            { Helpers.WriteDebug("Found a READLN."); $$ = new CompilerFunction(null, $1.Text, $1.Location); }
                        | Exception LParenthesis EXPRESSION RParenthesis
                            { Helpers.WriteDebug("Found an EXCEPTION."); $$ = new CompilerFunction((Expression)$3, $1.Text, $1.Location); }
                        | Atol LParenthesis EXPRESSION RParenthesis
                            { Helpers.WriteDebug("Found an ATOL."); $$ = new CompilerFunction((Expression)$3, $1.Text, $1.Location); }
                        | Identifier PlusPlus
                            { Helpers.WriteDebug("Found an INCREMENTER."); $$ = new Incrementer($1.Text, $2.Text, null, true, $1.Location); } 
                        | Identifier MinusMinus
                            { Helpers.WriteDebug("Found an INCREMENTER."); $$ = new Incrementer($1.Text, $2.Text, null, true, $1.Location); } 
                        | PlusPlus Identifier
                            { Helpers.WriteDebug("Found an INCREMENTER."); $$ = new Incrementer($2.Text, $1.Text, null, false, $1.Location); } 
                        | MinusMinus Identifier
                            { Helpers.WriteDebug("Found an INCREMENTER."); $$ = new Incrementer($2.Text, $1.Text, null, false, $1.Location); } 
                        | Identifier PlusBecomes EXPRESSION
                            { Helpers.WriteDebug("Found an INCREMENTER."); $$ = new Incrementer($1.Text, $2.Text, (Expression)$3, false, $1.Location); } 
                        | Identifier MinusBecomes EXPRESSION
                            { Helpers.WriteDebug("Found an INCREMENTER."); $$ = new Incrementer($1.Text, $2.Text, (Expression)$3, false, $1.Location); } 
                        | Identifier MultiplyBecomes EXPRESSION
                            { Helpers.WriteDebug("Found an INCREMENTER."); $$ = new Incrementer($1.Text, $2.Text, (Expression)$3, false, $1.Location); } 
                        | Identifier DivideBecomes EXPRESSION
                            { Helpers.WriteDebug("Found an INCREMENTER."); $$ = new Incrementer($1.Text, $2.Text, (Expression)$3, false, $1.Location); } 
                        | Identifier ModBecomes EXPRESSION
                            { Helpers.WriteDebug("Found an INCREMENTER."); $$ = new Incrementer($1.Text, $2.Text, (Expression)$3, false, $1.Location); } 
                        ; 

EXPRESSION_LIST         : EXPRESSION CONTINUED_EXPR_LIST
                            { Helpers.WriteDebug("Found a EXPRESSION_LIST."); $$ = new ExpressionList(); ((ExpressionList)$$).Add((Expression)$1); ((ExpressionList)$$).AddRange(((ContinuedExpressionList)$2)); }
                        | /* empty */
                            { Helpers.WriteDebug("Found a EXPRESSION_LIST."); $$ = new ExpressionList(); }
                        ;

CONTINUED_EXPR_LIST     : CONTINUED_EXPR_LIST Comma EXPRESSION
                            { ((ContinuedExpressionList)$1).Add((Expression)$3); $$ = $1; }
                        | /* empty */
                            { Helpers.WriteDebug("Found a CONTINUED_EXPR_LIST."); $$ = new ContinuedExpressionList(); }
                        ;

PAR_EXPRESSION          : LParenthesis EXPRESSION RParenthesis
                            { Helpers.WriteDebug("Found a PARENTHETICAL_EXPRESSION."); $$ = new Parenthetical((Expression)$2, $1.Location); }
                        ;

EXPRESSION              : EXPRESSION And EXPRESSION
                            { Helpers.WriteDebug("Found an AND."); $$ = new And((Expression)$1, (Expression)$3, $1.Location); }
                        | EXPRESSION Or EXPRESSION
                            { Helpers.WriteDebug("Found an OR."); $$ = new Or((Expression)$1, (Expression)$3, $1.Location); }
                        | EXPRESSION Less EXPRESSION
                            { Helpers.WriteDebug("Found a LESS."); $$ = new Less((Expression)$1, (Expression)$3, $1.Location); }
                        | EXPRESSION Greater EXPRESSION
                            { Helpers.WriteDebug("Found a GREATER."); $$ = new Greater((Expression)$1, (Expression)$3, $1.Location); }
                        | EXPRESSION LessEqual EXPRESSION
                            { Helpers.WriteDebug("Found a LESS_EQUAL."); $$ = new LessEqual((Expression)$1, (Expression)$3, $1.Location); }
                        | EXPRESSION GreaterEqual EXPRESSION
                            { Helpers.WriteDebug("Found a GREATER_EQUAL."); $$ = new GreaterEqual((Expression)$1, (Expression)$3, $1.Location); }
                        | EXPRESSION Instanceof Identifier
                            { Helpers.WriteDebug("Found a INSTANCEOF."); $$ = new Instanceof((Expression)$1, $3.Text, $1.Location); }
                        | EXPRESSION NotEqual EXPRESSION
                            { Helpers.WriteDebug("Found a NOT_EQUAL."); $$ = new NotEqual((Expression)$1, (Expression)$3, $1.Location); }
                        | EXPRESSION Equal EXPRESSION
                            { Helpers.WriteDebug("Found an EQUAL."); $$ = new Equal((Expression)$1, (Expression)$3, $1.Location); }
                        | Not EXPRESSION
                            { Helpers.WriteDebug("Found a NOT_EXPRESSION."); $$ = new Not((Expression)$2, $1.Location); }
                        | EXPRESSION Plus EXPRESSION
                            { Helpers.WriteDebug("Found a PLUS."); $$ = new Plus((Expression)$1, (Expression)$3, $1.Location); }
                        | EXPRESSION Minus EXPRESSION
                            { Helpers.WriteDebug("Found a MINUS."); $$ = new Minus((Expression)$1, (Expression)$3, $1.Location); }
                        | EXPRESSION Mod EXPRESSION
                            { Helpers.WriteDebug("Found a MOD."); $$ = new Mod((Expression)$1, (Expression)$3, $1.Location); }
                        | EXPRESSION Divide EXPRESSION
                            { Helpers.WriteDebug("Found a DIVIDE."); $$ = new Divide((Expression)$1, (Expression)$3, $1.Location); }
                        | EXPRESSION Multiply EXPRESSION
                            { Helpers.WriteDebug("Found a MULTIPLY."); $$ = new Multiply((Expression)$1, (Expression)$3, $1.Location); }
                        | EXPRESSION LBracket EXPRESSION RBracket
                            { Helpers.WriteDebug("Found an ARRAY_ACCESS."); $$ = new ArrayAccess((Expression)$1, (Expression)$3, $1.Location); }
                        | EXPRESSION Dot Length
                            { Helpers.WriteDebug("Found a DOT_LENGTH."); $$ = new ArrayLength((Expression)$1, $1.Location); }
                        | Integer
                            { Helpers.WriteDebug("Found an INTEGER."); $$ = new Integer($1.Text, $1.Location); }
                        | StringLiteral
                            { Helpers.WriteDebug("Found a STRING."); $$ = new Ast.String($1.Text, $1.Location); }
                        | True
                            { Helpers.WriteDebug("Found a TRUE."); $$ = new True($1.Location); }
                        | False
                            { Helpers.WriteDebug("Found a FALSE."); $$ = new False($1.Location); } 
                        | Null
                            { Helpers.WriteDebug("Found a TRUE."); $$ = new Null($1.Location); }
                        | Identifier
                            { Helpers.WriteDebug(string.Format("Found an EXPRESSION_IDENTIFIER")); $$ = new IdentifierExpression($1.Text, $1.Location); }
                        | This
                            { Helpers.WriteDebug("Found a THIS."); $$ = new This($1.Location); }
                        | New Int LBracket EXPRESSION RBracket
                            { Helpers.WriteDebug("Found a NEW_ARRAY."); $$ = new NewArray((Expression)$4, $1.Location); }
                        | New Identifier LParenthesis RParenthesis
                            { Helpers.WriteDebug("Found an NEW_OBJECT."); $$ = new NewObject($2.Text, $2.Location); }
                        //| PAR_EXPRESSION EXPRESSION
                        //    { Helpers.WriteDebug("Found a CAST."); $$ = new Cast((Expression)$2, ((IdentifierExpression)((Parenthetical)$1).Expression).Name, $1.Location); } 
                        | EXPRESSION_STATEMENT | PAR_EXPRESSION 
                        ;

%%