grammar Gramaticasw;
/*
01 faltando geração da AST
02 faltando: A linguagem NÃO deve suportar declarações aninhadas de funções ou procedimentos,
03 faltando: pode conter várias chamadas a funções/procedimentos aninhadas
04 faltando: A linguagem possui funções built-in, utilizadas para realizar IO (print e read) através do console
05 faltando: Tipos e operadores
JAVA Simplificado é fortemente tipada e dá suporte aos seguintes tipos: inteiros, reais
strings e booleanos. Os únicos operadores disponíveis na linguagem são:
• ‘!’: negação, inverte o valor booleano ao qual foi aplicada – unário;
• ‘-’: menos unário, inverte o valor inteiro ou real ao qual foi aplicada – unário;
• ‘+’: soma – binário;
• ‘-‘: subtração – binário;
• ‘*’: multiplicação – binário;
• ‘/’: divisão inteira e real – binário;
• ‘++’ incremento – unário
• ‘--‘ decremento – unário
• ‘==’: comparação, checa se os operadores são iguais – binário;
• ‘!=’: comparação, checa se os operadores são diferentes – binário;
• ‘>=’: maior ou igual que – binário;
• ‘<=’: menor ou igual que – binário;
• ‘>’: maior que – binário;
• ‘<’: menor que – binário;

06 faltando: Precedência de operadores
I. Quando dois operadores diferentes forem utilizados ao mesmo tempo, o
operador de maior precedência será avaliado primeiro;
II. Operadores de mesma precedência serão avaliados da esquerda para a direita;
III. É possível forçar a precedência de uma operação, colocando-a entre
parênteses.


07 faltando: const <tipo> <identificador> = <valor> ;
08 faltando: print e read
09 faltando: Comandos de atribuições Sintaxe: ID = <expressão>;
10 faltando: IF-ELSE
if (<teste_logico>){
...
}[else{

11 faltando: FOR
Sintaxe:
for (<variáveis de controle>; <condição>; <incrementos>){
...
[break]
...
}

12 faltando: Comentários	são	permitidos	e	podem	ser	escritos	com	“//”	–	comentário	de	linha	ou	
“/*	...	*/	-	comentário	para	múltiplas	linhas.	



*/
@header{
    package antlrsw;
}
prog: 'program' ID '{' dec* func* bloco '}'
    ;
dec : decVars
    | decConst
    ;
decVars: tipo ':' listaId ';'
    ;
decConst: 'const' tipo ID '=' ID ';'
    ;
tipo returns [int t]
    : 'int'    {$t=0;}
    | 'string' {$t=1;}
    | 'boolean'{$t=2;}
    | 'float'  {$t=3;}
    ;
func: 'func' tipo ID '(' ')' '{' comandos* '}'
    ;
bloco: 'block' '{' comandos* '}'
    ;
comandos: 'read' '(' listaId ')' ';'
    | 'print' '(' listaExpr ')' ';'
    ;
listaId: ID (',' ID)*
    ;
listaExpr: expr (',' expr)*
    ;
expr: STRING
    ;

operador: '='
	| '*='
	| '/='
	| '%='
	| '+='
	| '-='
	| '<<='
	| '>>='
	| '>>>='
	| '&='
	| '^='
	| '|='
    ;

TK_program: 'program';
TK_block: 'block';
TK_read: 'read';
TK_print: 'print';
TK_const: 'const';
TK_int: 'int';
TK_string: 'string';
TK_boolean: 'boolean';
TK_float:'float';
TK_abreChaves: '{';
TK_fechaChaves: '}';
TK_abrePars: '(';
TK_fechaPars: ')';
TK_ptVirg: ';';
TK_virgula: ',';
TK_doisPontos: ':';
STRING: '"' .*? '"' ;
ID: [A-Za-z][A-Za-z0-9]*;
WS: [ \t\r\n]+ -> skip;