grammar Gramaticasw;

programa: 'program' IDENTIFICADOR '{' constantes* variaveis* funcao*  block '}' EOF; 
     
constantes
    : 'const' 'string' IDENTIFICADOR'='  STRING ';'
    | 'const' 'int' IDENTIFICADOR'='  INT ';'
    | 'const' 'float' IDENTIFICADOR'=' FLOAT ';'
    | 'const' 'boolean' IDENTIFICADOR'=' BOOLEAN ';'
    ;

variaveis: tipo ':' IDENTIFICADOR (',' IDENTIFICADOR)* ';' ;

funcao : 'func' tipo  IDENTIFICADOR'(' decFuncao? ')' '{' corpoFuncao* '}' ;

decFuncao
    :  tipo ':' IDENTIFICADOR(',' IDENTIFICADOR)* 
    |  decFuncao ';' tipo ':' IDENTIFICADOR(',' IDENTIFICADOR)* 
    ;

block: 'block' '{' corpoBlock* '}';

corpoFuncao
    : funcaoIF  
    | funcaoFor 
    | itemGeral    
    | 'return' '(' operacaoCOMP? ')' ';' 
    ;

corpoBlock
    : blockIF 
    | blockFor  
    | itemGeral ';'
    ;

itemGeral
    : IDENTIFICADOR( '++' | '--') 
    | print
    | read
    | IDENTIFICADOR'(' listaVariaveis? ')' 
    | atribuicao
    ;

atribuicao: IDENTIFICADOR '=' operacaoCOMP ;

blockIF: 'if' '(' operacaoCOMP ')' '{' corpoBlock '}' ('else' '{' corpoBlock '}' )? ;
funcaoIF: 'if' '(' operacaoCOMP ')' '{' corpoFuncao '}' ('else' '{' corpoFuncao '}' )? ;

funcaoFor: 'for' '(' forCondition ')' '{' corpoFuncao '}';
blockFor: 'for' '(' forCondition ')' '{' corpoBlock '}';

forCondition: atribuicao? ';' operacaoCOMP? ';' atribuicao? ;

operacaoCOMP
    : operacaoIGUAL
    | operacaoIGUAL ( '<'|'>'|'<='|'>=') operacaoIGUAL
    ;

operacaoIGUAL
    : operacaoAdicao
    | operacaoAdicao ( '==' | '!=') operacaoAdicao
    ;
  
operacaoAdicao
    :  operacaoMultiplicacao
    |  operacaoAdicao '+' operacaoMultiplicacao
    |  operacaoAdicao '-' operacaoMultiplicacao
    ;
   
operacaoMultiplicacao
    : unario
    | operacaoMultiplicacao '*' unario
    | operacaoMultiplicacao '/' unario
    ;

unario: '!' unarioExp | '-' unario | fator;

unarioExp // inpedir !10
    : '!' unarioExp
    | '(' operacaoCOMP ')' 
    | IDENTIFICADOR    
    | IDENTIFICADOR'(' listaVariaveis? ')' 
    ;

fator
    : '(' operacaoCOMP ')' 
    | IDENTIFICADOR
    | valor 
    | IDENTIFICADOR'(' listaVariaveis? ')' 
    ;

listaVariaveis 
    : IDENTIFICADOR
    | valor  
    | operacaoCOMP
    | listaVariaveis ',' ( IDENTIFICADOR |  valor )
    | IDENTIFICADOR'(' listaVariaveis? ')'
    ;       

print: 'print' '(' impressao ')' ';' ;

impressao
    :STRING(',' IDENTIFICADOR)*
    | IDENTIFICADOR
    ;

read: 'read' '(' IDENTIFICADOR(',' IDENTIFICADOR)* ')' ';' ;

valor: BOOLEAN | FLOAT | INT | STRING;
tipo: TipoInt | TipoFloat | TipoBoolean | TipoString;

PROGRAM: 'program';
BROCK: 'block';
PRINT: 'print' ;
READ: 'read' ;
FUNC: 'func';
BREAK: 'break';
TipoString: 'string';
TipoFloat : 'float';
TipoInt : 'int';
TipoBoolean : 'boolean';
CONST :'const';
ELSE : 'else';
FOR : 'for';
IF : 'if';
RETURN : 'return';
APARENTESE : '(';
FPARENTESE: ')';
ACHAVE : '{';
FCHAVE : '}';
MENORQ : '<';
MENORIGUALQ : '<=';
MAIORQ : '>';
MAIOREMENORQ : '>=';
MAIS : '+';
INCREMENTAR : '++';
MENUS : '-';
DECREMENTAR : '--';
MULTIPLICAR : '*';
DIVIDENTIFICADORIR : '/';
NEGACAO : '!';
DOISPONTO : ':';
PONTOVIRGULA : ';';
PONTOFINAL: '.';
ASPASDUPLAS: '"';
VIRGULA : ',';
ATRIBUIR : '=';
IGUAL : '==';
DIFERENTE : '!=';
BOOLEAN: 'TRUE'| 'FALSE';
INT : [0-9]+;
FLOAT: [0-9]*'.'[0-9]+?;
STRING: '"' ('""'|~'"')* '"' ;
IDENTIFICADOR: [a-zA-Z][a-zA-Z0-9]*;
WS: [ \t\r\n]+ -> skip ;
COMMENT :   '/*' .*? '*/' -> channel(HIDDEN) ;
LINE_COMMENT: '//' ~[\r\n]* -> channel(HIDDEN) ;