grammar Gramaticasw;

prog: 'program' Identificador '{' preBloco bloco '}' ;

preBloco
    : expVariaveis* 
    | expConstantes*
    | expFuncoes*
    ;

expVariaveis : tipo ':' listaIndentificador ';' ;

expConstantes
    : 'const' 'int' Identificador '=' tipoInt ';'
    | 'const' 'float' Identificador '=' tipoFloat ';'
    | 'const' 'string' Identificador '=' tipoStringl';'
    | 'const' 'boolean' Identificador '=' tipoBoolean';'    
    ;

expFuncoes : 'func' tipo Identificador '(' listaVariaveisFunc* ')' '{' corpoFunc '}' ;

listaIndentificador : Indentificador (',' listaIndentificador )* ;

listaVariaveisFunc : tipo ':' Indentificador (',' expVariaveisFunc )*;

bloco: 'block' '{' corpo '}';

corpo
    : expPrint ';' corpo*  // print
    | expRead  ';' corpo*  // read    |  
    | atribuicao ';' corpo* // atribuição
    | expressao ';' corpo*  //expressao 
    | Identificador '(' listaVariaveisFunc* ')' ';' corpo* // chamar funcao
    | expFor ';' corpo* // chamar 
    | expIF ';' corpo*
    ;

corpoFunc: corpo 'return' expressao ;

primaryExpression  // 
    :   Identificador // letra (letra | numero )*
    |   Constant   // constante inteira, real ou caractere
    |   tipoStringl+ // nao sei o que é
    |   '(' expressao ')' //    
    |   '(' compoundStatement ')' // Blocks (GCC extension)
    |   '(' unaryExpression ',' typeName ')'
    |   '(' typeName ',' unaryExpression ')'
    ;

genericAssociation
    :   typeName ':' assignmentExpression
    |   'default' ':' assignmentExpression
    ;

postfixExpression
    :   primaryExpression   
    |   postfixExpression '(' argumentExpressionList? ')'
    |   postfixExpression '.' Identificador   
    |   postfixExpression '++'
    |   postfixExpression '--'
    |   '(' typeName ')' '{' initializerList '}'
    |   '(' typeName ')' '{' initializerList ',' '}'
    |   '(' typeName ')' '{' initializerList '}'
    |   '(' typeName ')' '{' initializerList ',' '}'
    ;

argumentExpressionList
    :   assignmentExpression
    |   argumentExpressionList ',' assignmentExpression
    ;

unaryExpression
    :   postfixExpression
    |   '++' unaryExpression
    |   '--' unaryExpression
    |   unaryOperator castExpression 
    |   '&&' Identificador // GCC extension address of label
    ;

unaryOperator
    :   '*' | '+' | '-' | '!'
    ;

castExpression
    :   '(' typeName ')' castExpression
    |   unaryExpression
    |   DigitSequence // for
    ;

multiplicativeExpression
    :   castExpression
    |   multiplicativeExpression '*' castExpression
    |   multiplicativeExpression '/' castExpression
    |   multiplicativeExpression '%' castExpression
    ;

additiveExpression
    :   multiplicativeExpression
    |   additiveExpression '+' multiplicativeExpression
    |   additiveExpression '-' multiplicativeExpression
    ;

relationalExpression
    :   additiveExpression
    |   relationalExpression '<' additiveExpression
    |   relationalExpression '>' additiveExpression
    |   relationalExpression '<=' additiveExpression
    |   relationalExpression '>=' additiveExpression
    ;

equalityExpression
    :   relationalExpression
    |   equalityExpression '==' relationalExpression
    |   equalityExpression '!=' relationalExpression
    ;

andExpression
    :   equalityExpression
      ;

logicalAndExpression
    :   inclusiveOrExpression
    |   logicalAndExpression '&&' inclusiveOrExpression
    ;

logicalOrExpression
    :   logicalAndExpression
    |   logicalOrExpression '||' logicalAndExpression
    ;

conditionalExpression
    :   logicalOrExpression ('?' expressao ':' conditionalExpression)?
    ;

assignmentExpression
    :   conditionalExpression
    |   unaryExpression assignmentOperator assignmentExpression
    |   DigitSequence // for
    ;

assignmentOperator
    :   '=' | '*=' | '/=' | '%=' | '+=' | '-=' | '<<=' | '>>=' | '&=' | '^=' | '|='
    ;

expressao //usado
    :   assignmentExpression
    |   expressao ',' assignmentExpression
    ;

constantExpression
    :   conditionalExpression
    ;

declaration
    :   declarationSpecifiers initDeclaratorList ';'
    | 	declarationSpecifiers ';'
    |   staticAssertDeclaration
    ;

declarationSpecifiers
    :   declarationSpecifier+
    ;

declarationSpecifiers2
    :   declarationSpecifier+
    ;

declarationSpecifier
    :   tipo
    |   typeQualifier
    |   functionSpecifier
    |   alignmentSpecifier
    ;

initDeclaratorList
    :   initDeclarator
    |   initDeclaratorList ',' initDeclarator
    ;

initDeclarator
    :   declarator
    |   declarator '=' initializer
    ;

tipo
    :   'int'
    |   'float'  
    |   'boolean'
    |   'string'   
    ;

structDeclarationList
    :   structDeclaration
    |   structDeclarationList structDeclaration
    ;

structDeclaration
    :   specifierQualifierList structDeclaratorList? ';'
    |   staticAssertDeclaration
    ;

specifierQualifierList
    :   tipo specifierQualifierList?
    |   typeQualifier specifierQualifierList?
    ;

structDeclaratorList
    :   structDeclarator
    |   structDeclaratorList ',' structDeclarator
    ;

declarator
    :   pointer? directDeclarator gccDeclaratorExtension*
    ;

directDeclarator
    :   Identificador
    |   '(' declarator ')'
    |   directDeclarator '[' typeQualifierList? assignmentExpression? ']'
    |   directDeclarator '[' 'static' typeQualifierList? assignmentExpression ']'
    |   directDeclarator '[' typeQualifierList 'static' assignmentExpression ']'
    |   directDeclarator '[' typeQualifierList? '*' ']'
    |   directDeclarator '(' parameterTypeList ')'
    |   directDeclarator '(' identifierList? ')'
    |   Identificador ':' DigitSequence  // bit field
    |   '(' tipo? pointer directDeclarator ')' // function pointer like: (__cdecl *f)
    ;

gccAttributeList
    :   gccAttribute (',' gccAttribute)*
    |   // empty
    ;

typeQualifierList
    :   typeQualifier
    |   typeQualifierList typeQualifier
    ;

parameterTypeList
    :   parameterList
    |   parameterList ',' '...'
    ;

parameterList
    :   parameterDeclaration
    |   parameterList ',' parameterDeclaration
    ;

parameterDeclaration
    :   declarationSpecifiers declarator
    |   declarationSpecifiers2 abstractDeclarator?
    ;

identifierList
    :   Identificador
    |   identifierList ',' Identificador
    ;

typeName
    :   specifierQualifierList abstractDeclarator?
    ;

abstractDeclarator
    :   pointer
    |   pointer? directAbstractDeclarator gccDeclaratorExtension*
    ;

directAbstractDeclarator
    :   '(' abstractDeclarator ')' gccDeclaratorExtension*
    |   '[' typeQualifierList? assignmentExpression? ']'
    |   '[' 'static' typeQualifierList? assignmentExpression ']'
    |   '[' typeQualifierList 'static' assignmentExpression ']'
    |   '[' '*' ']'
    |   '(' parameterTypeList? ')' gccDeclaratorExtension*
    |   directAbstractDeclarator '[' typeQualifierList? assignmentExpression? ']'
    |   directAbstractDeclarator '[' 'static' typeQualifierList? assignmentExpression ']'
    |   directAbstractDeclarator '[' typeQualifierList 'static' assignmentExpression ']'
    |   directAbstractDeclarator '[' '*' ']'
    |   directAbstractDeclarator '(' parameterTypeList? ')' gccDeclaratorExtension*
    ;

initializerList
    :   designation? initializer
    |   initializerList ',' designation? initializer
    ;

designation
    :   designatorList '='
    ;

designatorList
    :   designator
    |   designatorList designator
    ;

designator
    :   '[' constantExpression ']'
    |   '.' Identificador
    ;

corpo_IF_For // usado
    :   labeledStatement
    |   compoundStatement
    |   expressaoStatement
    |   expIF
    |   expFor
    |   jumpStatement
    ;

compoundStatement
    :   '{' blockItemList? '}'
    ;

blockItemList
    :   blockItem
    |   blockItemList blockItem
    ;

blockItem
    :   corpo_IF_For
    |   declaration
    ;

expressaoStatement :  expressao? ';' ;

expIF: 'if' '(' expressao ')' corpo_IF_For ('else' corpo_IF_For)? ;
expFor: For '(' forCondition ')' corpo_IF_For ;

forCondition
	:   forDeclaration ';' forExpression? ';' forExpression?
	|   expressao? ';' forExpression? ';' forExpression?
	;

forDeclaration
    :   declarationSpecifiers initDeclaratorList
	| 	declarationSpecifiers
    ;

forExpression
    :   assignmentExpression
    |   forExpression ',' assignmentExpression
    ;

jumpStatement
    :  'break' ';'
    |  'return' expressao? ';'  ;

compilationUnit
    :   translationUnit? EOF
    ;

translationUnit
    :   externalDeclaration
    |   translationUnit externalDeclaration
    ;

externalDeclaration
    :   functionDefinition
    |   declaration
    |   ';' // stray ;
    ;

functionDefinition
    :   declarationSpecifiers? declarator declarationList? compoundStatement
    ;

declarationList
    :   declaration
    |   declarationList declaration
    ;

Block:   'block';
Program: 'program';
Break:   'break';
String : 'string';
Const :'const';
Else : 'else';
Float : 'float';
For : 'for';
If : 'if';
Int : 'int';
Return : 'return';
String : 'string';
Boolean : 'boolean';
LeftParen : '(';
RightParen : ')';
LeftBrace : '{';
RightBrace : '}';
Less : '<';
LessEqual : '<=';
Greater : '>';
GreaterEqual : '>=';
Plus : '+';
PlusPlus : '++';
Minus : '-';
MinusMinus : '--';
Star : '*';
Div : '/';
Mod : '%';
AndAnd : '&&';
OrOr : '||';
Not : '!';
Question : '?';
Colon : ':';
Semi : ';';
Comma : ',';
Assign : '=';
// '*=' | '/=' | '%=' | '+=' | '-=' | '<<=' | '>>=' | '&=' | '^=' | '|='
StarAssign : '*=';
DivAssign : '/=';
ModAssign : '%=';
PlusAssign : '+=';
MinusAssign : '-=';
Equal : '==';
NotEqual : '!=';

Identificador : IdentificadorNondigit(   IdentificadorNondigit |   Digit )* ;

fragment
IdentificadorNondigit
    :   Nondigit
    |   UniversalCharacterName
    //|   // other implementation-defined characters...
    ;

fragment valor
    : tipoInt
    | RealConstante
    | StringContante
    ;

fragment Nondigit : [a-zA-Z_] ;
fragment Digit : [0-9] ;

fragment tipoInt: NaozeroDigito Digit*;
fragment NaozeroDigito: [1-9];

fragment
FloatingConstant
    :   DecimalFloatingConstant
    |   HexadecimalFloatingConstant
    ;

fragment
DecimalFloatingConstant
    :   tipoFloat ExponentPart? FloatingSuffix?
    |   DigitSequence ExponentPart FloatingSuffix?
    ;

fragment
tipoFloat
    :   DigitSequence? '.' DigitSequence
    |   DigitSequence '.'
    ;

// §3.10.3 Boolean Literals

tipoBoolean
    : 'TRUE'
    | 'FALSE'
    ;

// §3.10.4 Character Literals

CharacterLiteral
	:	'\'' SingleCharacter '\''
	|	'\'' EscapeSequence '\''
	;

fragment
SingleCharacter
	:	~['\\\r\n]
	;

// §3.10.5 String Literals

tipoStringl :	'"' StringCharacters? '"' ;

fragment StringCharacters : StringCharacter+ ;

fragment
StringCharacter
    :	~["\\\r\n]
    |	EscapeSequence
    ;

// §3.10.6 Escape Sequences for Character and String Literals

fragment
EscapeSequence
    :	'\\' [btnfr"'\\]
    |	OctalEscape
    |   UnicodeEscape // This is not in the spec but prevents having to preprocess the input
    ;

fragment 
Sign
    :   '+' | '-'
    ;

DigitSequence : Digit+;
tipoStringl : EncodingPrefix? '"' SCharSequence? '"' ;
Whitespace:[ \t]+ -> skip ;
Newline
    :   (   '\r' '\n'?
        |   '\n'
        )
        -> skip
    ;
BlockComment : '/*' .*? '*/'-> skip ;
LineComment : '//' ~[\r\n]* -> skip ;