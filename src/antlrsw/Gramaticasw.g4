grammar Gramaticasw;

programa: 'program' Identificador '{' declaracoes?  block '}'; // estrutura basica

declaracoes
    : declaracao
    | declaracoes declaracao
    ;
     
declaracao: constantes ';' | variaveis ';' | funcao ;

constantes
    : 'const' 'string' Identificador '='  TipoString 
    | 'const' 'int' Identificador '='  TipoInt 
    | 'const' 'float' Identificador '=' TipoFloat 
    | 'const' 'boolean' Identificador '=' TipoBoolean 
    ;

variaveis: tipo ':' listaVariaveis ;

funcao : 'func' tipo  Identificador '(' directFunc? ')' '{' corpoFuncao '}' ;

block: 'block' '{' corpoBlock? '}';

corpoFuncao
    :   itemFuncao
    |   corpoFuncao itemFuncao
    ;

corpoBlock
    :   itemBlock
    |   corpoBlock itemBlock
    ;

itemFuncao
    : funcaoIF  
    | funcaoFor 
    | itemGeral    
    | 'return' '(' expressao? ')' ';' // fazer return
    ;

itemBlock
    : blockIF 
    | blockFor  
    | itemGeral
    ;

itemGeral
    : incrementar
    | print
    | read
    | Identificador'(' listaVariaveis? ')' ';'//chamada de funcao
    | Identificador '=' expressao ';' // fazer atribuicao  
    ;


expressao
    : subExpressao
    | expressao operacao subExpressao
    |  '(' expressao ')'
    ;
subExpressao
    : incrementar  
    | atribuicao
    | Identificador'(' listaVariaveis? ')' //chamada de funcao
    | Identificador'(' expressao? ')' //chamada de funcao    
    ;

directFunc
    :  tipo ':' Identificador 
    |  directFunc ',' tipo  ':' Identificador 
    ;
       
listaVariaveis //declaração de variaveis
    : Identificador
    | Identificador '=' valor
    | listaVariaveis ',' Identificador
    | Identificador'(' listaVariaveis? ')'
    ;                  

blockIF: 'if' '(' expressaoListaCondicao ')' '{' corpoBlock '}' ('else' '{' corpoBlock '}' )? ;
funcaoIF: 'if' '(' expressaoListaCondicao ')' '{' corpoFuncao '}' ('else' '{' corpoFuncao '}' )? ;

expressaoListaCondicao
    :  expressaoListaCondicao operacaoOU
    |  operacaoOU
    |  TipoBoolean 
    |  expressao
    ;

funcaoFor: 'for' '(' forCondition ')' '{' corpoFuncao '}' ;
blockFor: 'for' '(' forCondition ')' '{' corpoBlock '}';

forCondition
    :   variaveis? ';' expressaoListaCondicao? ';' expressao?
    |   expressao? ';' expressaoListaCondicao? ';' expressao?
    ;

 operacaoOU
    :  operacaoE
    |   operacaoOU '||'operacaoE
    ;
 
operacaoE
    : operacaoIGUAL
    |  operacaoE '&&' operacaoIGUAL
    ;
 
operacaoIGUAL
    : operecaoCOMP
    | operacaoIGUAL '==' operecaoCOMP
    | operacaoIGUAL '!=' operecaoCOMP
    ;
  
 operecaoCOMP
    :  operacaoAdicao
    |   operecaoCOMP '<'operacaoAdicao
    |   operecaoCOMP '>'operacaoAdicao
    |   operecaoCOMP '<='operacaoAdicao
    |   operecaoCOMP '>='operacaoAdicao
    ;
   
operacaoAdicao
    :   operacaoMultiplicacao
    |  operacaoAdicao '+' operacaoMultiplicacao
    |  operacaoAdicao '-' operacaoMultiplicacao
    ;
   
operacaoMultiplicacao
    :  expressao
    |  operacaoMultiplicacao '*' expressao
    |  operacaoMultiplicacao '/' expressao
    ;

incrementar 
    :  ( '++' | '--') Identificador // x++ ou x--   
    |  Identificador ( '++' | '--') // ++x ou --x 
    ;

atribuicao: Identificador | valor ;

valor: TipoBoolean |  TipoFloat |  TipoInt |  TipoString ;

print: 'print' '(' impressao ')' ';' ;
impressao
    :TipoString (',' Identificador)*
    | Identificador 
    ;

read: 'read' '(' Identificador ')' ';' ;
operacao: '+' | '-' | '*' | '/' ;
tipo: Int | Float | Boolean | String;

Program: 'program';
Block:   'block';
Print: 'print' ;
Read: 'read' ;
Func: 'func';
Break: 'break';
String: 'string';
Const :'const';
Else : 'else';
Float : 'float';
For : 'for';
If : 'if';
Int : 'int';
Return : 'return';
Boolean : 'boolean';
AbrirParentese : '(';
FecharParentese : ')';
AbrirChave : '{';
FechaChave : '}';
MenorQ : '<';
MenorIqualQ : '<=';
MaiorQ : '>';
MaiorIqualQ : '>=';
Mais : '+';
Incrementar : '++';
Menus : '-';
Decrementar : '--';
Multiplicar : '*';
Dividir : '/';
LogicaE : '&&';
LogicaOU : '||';
Negacao : '!';
DoisPonto : ':';
PontoFinal : ';';
Virgula : ',';
Atribuir : '=';
Iqual : '==';
Diferente : '!=';

TipoInt: '0' | NonZeroDigit (Digits? ) ;
TipoFloat: Digits '.' Digits? |	'.' Digits ;
TipoBoolean: 'TRUE' | 'FALSE' ;
TipoString: '"' StringCharacters? '"' ;
Identificador: [a-zA-Z$_] [a-zA-Z0-9$_]*;

fragment Digits: Digit( Digit)? ;
fragment Digit : '0' |	NonZeroDigit ;
fragment NonZeroDigit :	[1-9] ;
fragment StringCharacters: StringCharacter+ ;
fragment StringCharacter: ~["\\\r\n] | '\\' [btnfr"'\\]	;

WS: [ \t\r\n\u000C]+ -> skip ;
COMMENT :   '/*' .*? '*/' -> channel(HIDDEN) ;
LINE_COMMENT:   '//' ~[\r\n]* -> channel(HIDDEN) ;