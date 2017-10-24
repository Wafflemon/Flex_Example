/* scanner for a toy Pascal-like language */

%{
#include <math.h>
%}

DIGIT    [0-9]
ID       [a-z][a-z0-9]*

%%

{DIGIT}+    {
            printf( "An integer: %s (%d)\n", yytext,
                    atoi( yytext ) );
            }

{DIGIT}+"."{DIGIT}*        {
            printf( "A float: %s (%g)\n", yytext,
                    atof( yytext ) );
            }

if|then|begin|end|procedure|function        {
            printf( "A keyword: %s\n", yytext );
            }

{ID}        printf( "An identifier: %s\n", yytext );

"+"|"-"|"*"|"/"   printf( "An operator: %s\n", yytext );

"{"[^}\n]*"}"     /* skips one-line comments */

[ \t\n]+          /* skips whitespace */

.           printf("Unrecognized character: %s\n", yytext);

<<EOF>>     printf("End of File\n", yytext);

%%

int main(const int argc, const char **argv)
{
    if (argc > 1)
    {
        yyin = fopen(argv[1], "r");
    }
    else
    {
        yyin = stdin;
    }
    yylex();
}

/*
 * This defines yywrap, a special function used by lex to determine what should
 * be done when the end of an input file is encountered.
 */
int yywrap()
{
    return 0;
}