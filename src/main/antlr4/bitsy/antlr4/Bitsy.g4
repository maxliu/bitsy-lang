grammar Bitsy;

parse 
 : block EOF
 ;
 
block
 : (statement | NEWLINE)* EOF
 ;

statement
 : printFunctionCall
 | assignment
 ;
 
printFunctionCall
 : 'println' ( '(' expression? ')' | expression? )
 ;

assignment
 : IDENTIFIER '=' expression
 ;

expression
 : STRING 		#stringExpression
 | NUMBER 		#numberExpression
 | BOOL   		#boolExpression
 | NULL   		#nullExpression
 | IDENTIFIER   #identifierExpression
 ;



IDENTIFIER
 : [a-zA-Z_] [a-zA-Z_0-9]*
 ; 

STRING
 : ["] (~["\r\n] | '\\\\' | '\\"')* ["]
 | ['] (~['\r\n] | '\\\\' | '\\\'')* [']
 ;

NULL 
 : 'null'
 ;

BOOL
 : 'true' 
 | 'false'
 ;

NUMBER
 : INT ('.' DIGIT*)?
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

fragment INT
 : [1-9] DIGIT*
 | '0'
 ;
 
fragment DIGIT 
 : [0-9]
 ;