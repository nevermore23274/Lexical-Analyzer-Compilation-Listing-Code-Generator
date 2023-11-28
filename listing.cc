#include <cstdio>
#include <string>
#include <cstring>

using namespace std;

#include "listing.h"

static int lineNumber;
static string error = "";
static string errorCount = "";
static string errorful = "";
static int totalErrors = 0;
static int LexicalErrors = 0;
static int SyntaxErrors = 0;
static int SemanticErrors = 0;

static void displayErrors();

void firstLine()
{
	lineNumber = 1;
	printf("\n%4d  ",lineNumber);
}

void nextLine()
{
lineNumber++;
	displayErrors();
	
	printf("%4d  ",lineNumber);
}

int lastLine()
{
	printf("\r");
	displayErrors();
	if(totalErrors  == 0) 
	{
		printf("Compiled Successfully!");
	}
	else 
	{
		// Using -20 to keep the string left aligned in a field of width 20 chars
		printf("%-20s %d\n", "Lexical Errors", LexicalErrors);
		printf("%-20s %d\n", "Syntax Errors", SyntaxErrors);
		printf("%-20s %d\n", "Semantic Errors", SemanticErrors);
		printf("%-20s %d\n", "Total Errors", LexicalErrors + SyntaxErrors + SemanticErrors);
	}
	printf("     \n");
	return lineNumber++;
}
    
void appendError(ErrorCategories errorCategory, string message)
{
	string messages[] = {"Lexical Error, Invalid Character ", "",
		"Syntax Error, ", "Semantic Error, Duplicate Identifier: ",
		"Semantic Error, Undeclared "};

	error = messages[errorCategory] + message;
	totalErrors++;
	errorful += error;
	errorful += "\n";
	errorCount = messages[errorCategory];
    if(strcmp(errorCount.c_str(),"Lexical Error, Invalid Character") > 0)
	{
		LexicalErrors++;
	}
	else
	{
		LexicalErrors;
	}
	if(strcmp(errorCount.c_str(),"Syntax Error") > 0)
	{
		SyntaxErrors++;
	}
	else
	{
		SyntaxErrors;
	}
	if((strcmp(errorCount.c_str(),"Semantic Error, Duplicate Identifier:")) > 0 || (strcmp("Semantic Error, Undeclared ",errorCount.c_str())) > 0)
	{
		SemanticErrors++;
	}
	else
	{
		SemanticErrors;
	}	
}

void displayErrors()
{
	if(error!="")
	{
		printf("\r");
        printf("%s\n", errorful.c_str());
		errorful = "";
        error="";
    }
}
