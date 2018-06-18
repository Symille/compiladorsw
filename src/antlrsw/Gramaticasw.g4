grammar Gramaticasw;

programa: 'program' IDENTIFICADOR '{' constantes* variaveis* funcao*  block '}' EOF; // estrutura basica
     
constantes
    : 'const' 'string' IDENTIFICADOR '='  STRING ';'
    | 'const' 'int' IDENTIFICADOR '='  INT ';'
    | 'const' 'float' IDENTIFICADOR '=' FLOAT ';'
    | 'const' 'boolean' IDENTIFICADOR '=' bool ';'
    ;

variaveis: tipo ':' listaVariaveis ';' ;

funcao : 'func' tipo  IDENTIFICADOR '(' decFuncao? ')' '{' corpoFuncao* '}' ;

block: 'block' '{' corpoBlock* '}';

corpoFuncao
    : funcaoIF  
    | funcaoFor 
    | itemGeral    
    | 'return' '(' expressao? ')' ';' 
    ;

corpoBlock
    : blockIF 
    | blockFor  
    | itemGeral
    ;

itemGeral
    : IDENTIFICADOR ( '++' | '--') ';'
    | print
    | read
    | IDENTIFICADOR'(' listaVariaveis? ')' ';'
    | atribuicao ';'
    ;

atribuicao: IDENTIFICADOR '=' expressao ;

expressao
    : subExpressao
    | '-'expressao
    | expressao operacao subExpressao
    |  '(' expressao ')'
    ;

subExpressao
    : IDENTIFICADOR 
    | valor 
    | IDENTIFICADOR'(' listaVariaveis? ')' 
    | IDENTIFICADOR'(' expressao? ')' 
    ;

decFuncao
    :  tipo ':' IDENTIFICADOR (',' IDENTIFICADOR )* 
    |  decFuncao ';' tipo ':' IDENTIFICADOR(',' IDENTIFICADOR )* 
    ;
       
listaVariaveis 
    : IDENTIFICADOR
    | valor  
    | listaVariaveis ',' IDENTIFICADOR
    | IDENTIFICADOR'(' listaVariaveis? ')'
    ;                  

blockIF: 'if' '(' expressaoListaCondicao ')' '{' corpoBlock '}' ('else' '{' corpoBlock '}' )? ;
funcaoIF: 'if' '(' expressaoListaCondicao ')' '{' corpoFuncao '}' ('else' '{' corpoFuncao '}' )? ;

expressaoListaCondicao
    :  expressaoListaCondicao operacaoIGUAL // eliminar ou e e
    |  operacaoIGUAL
    |  bool 
    |  expressao
    ;

funcaoFor: 'for' '(' forCondition ')' '{' corpoFuncao '}';
blockFor: 'for' '(' forCondition ')' '{' corpoBlock '}';

forCondition: atribuicao? ';' expressaoListaCondicao? ';' atribuicao? ;
   
operacaoIGUAL
    : operecaoCOMP
    | expressao '==' expressao
    | expressao '!=' expressao
    ;
  
 operecaoCOMP
    :   expressao '<' expressao
    |   expressao '>'expressao
    |   expressao '<='expressao
    |   expressao '>='expressao
    ;
   
operacaoAdicao
    :  operacaoMultiplicacao
    |  operacaoAdicao '+' operacaoMultiplicacao
    |  operacaoAdicao '-' operacaoMultiplicacao
    ;
   
operacaoMultiplicacao
    :  expressao
    |  operacaoMultiplicacao '*' expressao
    |  operacaoMultiplicacao '/' expressao
    ;

valor: 'TRUE' | 'FALSE' |  FLOAT |  INT |  STRING;

print: 'print' '(' impressao ')' ';' ;

impressao
    :STRING(',' IDENTIFICADOR)*
    | IDENTIFICADOR 
    ;

read: 'read' '(' IDENTIFICADOR(',' IDENTIFICADOR)* ')' ';' ;
operacao: '+' | '-' | '*' | '/' ;
tipo: TipoInt | TipoFloat | TipoBoolean | TipoString;
bool: 'TRUE' | 'FALSE' ;

//refazer o int e float e negativos
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
DIVIDIR : '/';
NEGACAO : '!';
DOISPONTO : ':';
PONTOVIRGULA : ';';
PONTOFINAL: '.';
ASPASDUPLAS: '"';
VIRGULA : ',';
ATRIBUIR : '=';
IGUAL : '==';
DIFERENTE : '!=';
TRUE: 'TRUE';
FALSE: 'FALSE';
INT : [0-9]+;
FLOAT: '-'?[0-9]*'.'[0-9]+?;
STRING: '"' ('""'|~'"')* '"' ;
IDENTIFICADOR: [a-zA-Z][a-zA-Z0-9]*;
WS: [ \t\r\n]+ -> skip ;
COMMENT :   '/*' .*? '*/' -> channel(HIDDEN) ;
LINE_COMMENT:   '//' ~[\r\n]* -> channel(HIDDEN) ;