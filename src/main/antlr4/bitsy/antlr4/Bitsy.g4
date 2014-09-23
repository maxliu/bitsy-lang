grammar Bitsy;

parse
 : ( printFunctionCall | NEWLINE )* EOF
 ;
 
printFunctionCall
 : 'println' ( '(' STRING? ')' | STRING? )
 ;
 
STRING
 : ["] (~["\r\n] | '\\\\' | '\\"')* ["]
 | ['] (~['\r\n] | '\\\\' | '\\\'')* [']
 ;
  
NEWLINE
 : ( '\r'? '\n' | '\r' ) SPACES?
 ;
 
SKIP
 : SPACES -> skip
 ;
  
fragment SPACES
 : [ \t]+
 ;