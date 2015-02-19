- in general, how to deal with identifiers with numbers. should the identifier rule be modified or the identifier definition? (e.g. say it's an identifier if it begins with a letter and ends with a letter or number)


"For each error message the scanner should attempt to report the line and column number where the error
occurred. For (2) and (3), the line and column number should correspond to the starting position of the
unterminated comment and string, respectively." How does one acquire the line / column number?

- also see: using lex
see scanner.l from ex2


To avoid duplication, you can construct a global string table that stores a single copy of each unique
identifier name and string constant. The attribute for identifiers and string constants that is passed on
to the next phase would then be just an integer that represents an index to the string table. 

^ What does this mean? see table / example

To pass additional information with identifiers, strings etc., consider using the yylval variable in flex

what does yylval do? (yylval = int by default, can be declared in parser as a union type) is what i have now adequate? (yes)

Do NOT tar the lex library - What does this mean? Only 4 files 
