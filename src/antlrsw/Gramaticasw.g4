grammar Gramaticasw;

programa: 'program' Identificador '{' declaracoes?  block '}'; // estrutura basica

declaracoes //forçando derivação e esquerda
    : declaracao
    | declaracoes declaracao
    ;
     
declaracao
    : constantes ';'  
    | variaveis ';'     
    | funcao
    ;

constantes
    : 'string' Identificador '='  TipoString 
    | 'const' 'int' Identificador '='  TipoInt 
    | 'const' 'float' Identificador '=' TipoFloat 
    | 'const' 'boolean' Identificador '=' TipoBoolean 
    ;

variaveis: tipo ':' listaVariaveis ;

funcao : 'func' tipo  Identificador '(' directFunc? ')' '{' corpoFuncao '}' ;

corpoFuncao //forçando deviraçao a esquerda
    :   itemFuncao
    |   corpoFuncao itemFuncao
    ;

itemFuncao
    : funcaoIF // ter if
    | funcaoFor // ter for
    | incrementar // incrementar
    | Identificador'(' listaVariaveis? ')' ';'//chamada de funcao
    | Identificador '=' expressao ';' // fazer atribuicao   
    | 'return' '(' expressao? ')' ';' // fazer return
    ;
expressao
    : subExpressao
    | expressao operacao subExpressao
    |  '(' expressao ')'
    ;
subExpressao
    :   atribuicao
    |   Identificador'(' listaVariaveis? ')' //chamada de funcao
    |   Identificador'(' expressao? ')' //chamada de funcao    
    ;

directFunc
    :  tipo ':' Identificador 
    |  directFunc ',' tipo  ':' Identificador 
    ;
       
listaVariaveis //declaração de variaveis
    : Identificador
    | Identificador '=' valor
    | listaVariaveis ',' Identificador
    ;                  

// definição do bloco
block: 'block' '{' corpoBlock? '}';

// corpo do bloco
corpoBlock
    :   blockItem
    |   corpoBlock blockItem
    ;

blockItem
    : blockIF 
    | blockFor 
    | incrementar
    | Identificador'(' listaVariaveis? ')' ';'//chamada de funcao
    | Identificador '=' expressao';'   
    ;

blockIF: 'if' '(' expressaoListaCondicao ')' '{' corpoBlock '}' ('else' '{' corpoBlock '}' )? ;
funcaoIF: 'if' '(' expressaoListaCondicao ')' '{' corpoFuncao '}' ('else' '{' corpoFuncao '}' )? ;

expressaoListaCondicao
    :  expressaoListaCondicao operacaoOU
    |  operacaoOU
    |  TipoBoolean 
    |  expressao
    ;
     
//declaração do dfor
funcaoFor:  'for' '(' forCondition ')' '{' corpoFuncao '}' ;
blockFor:  'for' '(' forCondition ')' '{' corpoBlock '}';

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

atribuicao
    : Identificador
    | valor
    ;
valor
    :  TipoBoolean
    |  TipoFloat
    |  TipoInt
    |  TipoString
    ;

operacao: '+' | '-' | '*' | '/' ;
tipo: Int | Float | Boolean | String;

TipoInt: '0' | NonZeroDigit (Digits? ) ;
fragment Digits: Digit( Digit)? ;
fragment Digit : '0' |	NonZeroDigit ;
fragment NonZeroDigit :	[1-9] ;

TipoFloat
	:	Digits '.' Digits? 
	|	'.' Digits 	
	;

TipoBoolean
	:	'TRUE'
	|	'FALSE'
	;

// 
CharacterLiteral
	:	'\'' SingleCharacter '\''
	|	'\'' EscapeSequence '\''
	;

fragment
SingleCharacter
	:	~['\\\r\n]
	;

// §3.10.5 String Literals

TipoString: '"' StringCharacters? '"' ;

fragment
StringCharacters
	:	StringCharacter+
	;

fragment
StringCharacter
	:	~["\\\r\n]
	|	EscapeSequence
	;

// §3.10.6 Escape Sequences for Character and String Literals

fragment
EscapeSequence
	:	'\\' [btnfr"'\\]	
	;

Program: 'program';
Block:   'block';
Func: 'func';
Break:   'break';
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

Identificador: JavaLetter JavaLetterOrDigit*;

fragment
JavaLetter
	:	[a-zA-Z$_] // these are the "java letters" below 0x7F
	|	// covers all characters above 0x7F which are not a surrogate
		~[\u0000-\u007F\uD800-\uDBFF]
		{Character.isJavaIdentifierStart(_input.LA(-1))}?
	|	// covers UTF-16 surrogate pairs encodings for U+10000 to U+10FFFF
		[\uD800-\uDBFF] [\uDC00-\uDFFF]
		{Character.isJavaIdentifierStart(Character.toCodePoint((char)_input.LA(-2), (char)_input.LA(-1)))}?
	;

fragment
JavaLetterOrDigit
	:	[a-zA-Z0-9$_] // these are the "java letters or digits" below 0x7F
	|	// covers all characters above 0x7F which are not a surrogate
		~[\u0000-\u007F\uD800-\uDBFF]
		{Character.isJavaIdentifierPart(_input.LA(-1))}?
	|	// covers UTF-16 surrogate pairs encodings for U+10000 to U+10FFFF
		[\uD800-\uDBFF] [\uDC00-\uDFFF]
		{Character.isJavaIdentifierPart(Character.toCodePoint((char)_input.LA(-2), (char)_input.LA(-1)))}?
	;

//
// Whitespace and comments
//

WS  :  [ \t\r\n\u000C]+ -> skip
    ;

COMMENT
    :   '/*' .*? '*/' -> channel(HIDDEN)
    ;

LINE_COMMENT
    :   '//' ~[\r\n]* -> channel(HIDDEN)
    ;
