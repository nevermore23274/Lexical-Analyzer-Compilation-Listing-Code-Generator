%{
#include <cstdio>
#include <string>

using namespace std;

#include "tokens.h"
#include "listing.h"
%}

%option noyywrap

ws				[ \t\r]+
comment	        [\-\-.*\n \/\/.*\n]
line			[\n]
id_us           _
id				[A-Za-z]+([_])?[A-Za-z0-9]*
int				[0-9]+
punc			[\(\),:;]
relop           [> < >= <= = /=]
addop           [/+ /-]
mulop           [\* \/]
expop           \*\*
arrow           =>
real_literal    [0-9]+([.][0-9]+)?[e E]([\+ \-])?[0-9]+
bool_literal    [true false]
%%

{line}          { ECHO; nextLine(); }
{ws}			{ ECHO; }
{mulop}         { ECHO; return(MULOP); }
{comment}		{ ECHO; nextLine();}
{relop}			{ ECHO; return(RELOP); }
{addop}			{ ECHO; return(ADDOP); }
case            { ECHO; return(CASE); }
else            { ECHO; return(ELSE); }
endcase         { ECHO; return(ENDCASE);}
endif           { ECHO; return(ENDIF); }
if              { ECHO; return(IF); }
others          { ECHO; return(OTHERS); }
then            { ECHO; return(THEN); }
when            { ECHO; return(WHEN); }
rem             { ECHO; return(REMOP); }
{expop}         { ECHO; return(EXPOP); }
{arrow}         { ECHO; return(ARROW); }
real            { ECHO; return(REAL); }
{real_literal}  { ECHO; return(REAL_LITERAL); }
{bool_literal}  { ECHO; return(BOOL_LITERAL); }
begin			{ ECHO; return(BEGIN_); }
boolean			{ ECHO; return(BOOLEAN); }
end				{ ECHO; return(END); }
endreduce		{ ECHO; return(ENDREDUCE); }
function		{ ECHO; return(FUNCTION); }
integer			{ ECHO; return(INTEGER); }
is				{ ECHO; return(IS); }
reduce			{ ECHO; return(REDUCE); }
returns			{ ECHO; return(RETURNS); }
and				{ ECHO; return(ANDOP); }
or              { ECHO; return(OROP); }
not             { ECHO; return(NOTOP); }
{int}			{ ECHO; return(INT_LITERAL);}
{id}			{ ECHO; return(IDENTIFIER); }
{punc}			{ ECHO; return(yytext[0]); }
.				{ ECHO; appendError(LEXICAL, yytext); }
%%

int main()
{
	firstLine();
	
	FILE *file = fopen("lexemes.txt", "wa");
	int token = yylex();
	while (token)
	{
		fprintf(file, "%d %s\n", token, yytext);
		token = yylex();
	}
	lastLine();
	fclose(file);
	return 0;
}
