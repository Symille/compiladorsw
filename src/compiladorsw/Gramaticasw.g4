grammar Gramaticasw;

@header{
    package antlrsw;
}
prog: 'program' ID '{' decVars* decFuncs bloco '}'
    ;
decVars: tipo ':' listaId ';'
       ;
tipo returns [int t]
    : 'int'    {$t=0;}
    | 'string' {$t=1;}
    | 'boolean'{$t=2;}
    | 'float'  {$t=3;}
    ;
decFuncs:
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

TK_program: 'program';
TK_block: 'block';
TK_read: 'read';
TK_print: 'print';
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
WS: [ \t\r\n] -> skip;