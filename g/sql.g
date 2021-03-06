GNAME SQL

lex: NAME | NUM | SYM | STR | WS | COMMENT | "(" | ")" | "[" | "]" | "{" | "}" | ";"
   | "+" | "-" | "*" | "/" | "~" | "@" | "#" | "$" | "^" | "&" | "=" | "<" | ">" | "?" | "." | "|" | "<>" | "!=" | "<=" | ">=" | "," | "%" | "'"

NUM: DIGIT+ FRAC? | "." DIGIT+ FRAC? | DIGIT+ "." DIGIT+ FRAC?
DIGIT: "0"-"9"
FRAC: ("e"|"E") ("+"|"-")? DIGIT+

NAME: ID_START ("."? ID_CONTINUE)* ".*"?
ID_START: "_" | "a"-"z" | "A"-"Z"
ID_CONTINUE: ID_START | DIGIT

WS: (" " | "\t" | "\n" | "\r")+

SYM: "'" SYM2
SYM2: ("'\\"^)* ("''" SYM2 | "'" | "\\" ("n" | "r" | "t" | DIGIT DIGIT DIGIT) SYM2)

STR: "\"" STR2
STR2: ("\"\\"^)* ("\"" | "\\" ("n" | "r" | "t" | DIGIT DIGIT DIGIT) STR2)

COMMENT: "--" ("\n"^)*

Q .ll.sqlKW:`select`update`delete`insert`distinct`into`from`where`group`by`having`order`asc`desc`limit`create`table`values`set`drop`not`in`like`as`left`cross`inner`join`case`extract`when`then`else`end`or`and`div`like`is`null`position`true`false`cast`on`between`remote`global`parted
Q .ll.qVars:`current_date`current_timestamp`current_user`database
Q .ll.lexmap:{[v]
  v:.[v;(0;j:where `SQL.NAME=v 1);`$]; / all names into symbols
  v:.[v;(1;j i);:;k i:where (k:lower v[0;j])in .ll.sqlKW]; / bring out keywords, ignore case
  v[0;i]:{[v;i] @[value;v[0;i];{'"Wrong ",(lower 4_string x[1;i])," ",x[0;y]," at ",.ll.posErrIn[x;y]; z}[v;i]]}[v] each i:where v[1] in`SQL.NUM`SQL.STR; / convert num/str
  v[0;i]:{[v;i] `$@[value;"\"",(-1_1_ssr[v[0;i];"''";"'"]),"\"";{'"Wrong symbol ",x[0;y]," at ",.ll.posErrIn[x;y]; z}[v;i]]}[v] each i:where `SQL.SYM=v 1; / in syms subst '' with '
  v
 }

LEXER lex

TOKENS: LEXER

start: sel | cre | ins | upd | del | drp | expr
sel: (`parted|`remote|`global)? `select `distinct? selA (`into name 2)? (`from join 2)? (`where expr4 {:(v2;P+1)})? (`group `by exprLst 3)? (`having expr 2)? (`order `by expr (`asc|`desc)? {:(v3;$[count v4;v4;`asc])})? (`limit expr 2)?
  {:`sql`pos`flag`dis`sel`into`join`whe`grp`hav`ord`lmt!(`sel;P;$[count v1;v1;`];count v3;v4;$[count v5;v5;`];v6;v7;v8;v9;v10;v11)}
selexp: sel {:(`list;v1`pos;enlist v1)}
cre: `create `table name "(" decl ("," decl)* ")"
ins: `insert `into name exprLstP? (`values exprLstPLst | sel)
upd: `update name `set exprLst `where expr
del: `delete `from name `where expr
drp: `drop `table name

selA: "*" {:()} | namedExpr ("," namedExpr 2)* {:flip enlist[v1],v2}
expr: expr4 (`or expr)? {:$[count v2;(`or;P;(v1;v2 1));v1]}
expr4: `not expr4 {:(`not;P;enlist v2)} | expr3 (`and expr4)? {:$[count v2;(`and;P;(v1;v2 1));v1]}
expr3: expr2 (("=" {:`eq}|"<>" {:`neq}|"!=" {:`neq}|">" {:`gt}|"<" {:`lt}|">=" {:`gte}|"<=" {:`lte}) expr3 |
   `is `not? `null {:$[count v2;{(`not;y;enlist(`is_null;y;enlist x))};{(`is_null;y;enlist x)}]} |
   `not? `in "(" (selexp | {P:.ll.p_i} exprLst2 {:(`list;P-1;v1)}) ")" {:$[count v1;{(`not;z;enlist(`in_;z;x y))};{(`in_;z;x y)}](;v4)} |
   `not? `between expr2 `and expr2 {v:(;v3;v5); :$[count v1;{(`not;z;enlist(`within;z;x y))};{(`within;z;x y)}]v})? {:$[0=count v2;v1;99<type v2;v2[v1;P];(v2 0;P;(v1;v2 1))]}
expr2: expr1 ((`not? (`like {:`.qsql.ff.like}) {:(v2;count v1)} |"+" {:`plus} |"-" {:`minus}) expr2)? {:$[count v2;v2[0],(P;(v1;v2 1));v1]}
expr1: expr0 (("*" {:`mult} | "/" {:`divide} | "div" {:`div}) expr1)? {:$[count v2;(v2 0;P;(v1;v2 1));v1]}
expr0: "(" (expr|selexp) ")" 2 | "-" expr0 {:(`neg;P;enlist v2)} | fnCall | fnCall2 | atom | case | extcast | "{" name expr "}" {:.qsql.t.spl[P;v2;v3]}
namedExpr: {p:.ll.p_i} expr (`as? name)? {:($[count v2;v2 1;`];v1;p)}
exprLst: "*" | exprLst2
exprLst2: expr ("," expr 2)* {:enlist[v1],v2}
exprLstP: "(" exprLst ")" 2
exprLstPLst: exprLstP ("," exprLstP 2)* {:enlist[v1],v2}

fnCall: {p:.ll.p_i} (name | `insert | `left) "(" exprLst? ")" {:(v1;p;v3)} | `position "(" expr0 `in expr ")" {:(`locate;P;(v3;v5;1))}
fnCall2: (`sum | `avg | `count | `min | `max | `every | `any) "(" `distinct? expr ")" | `count "(" "*" ")"
atom: {p:.ll.p_i} name {:$[(l:lower v1) in .ll.qVars;(l;p;());(`:get;p;v1)]} | `null {:(::)}| STR {:(),v1} | NUM | SYM {:enlist v1} | `true {:1b} | `false {:0b}
name: NAME
case: `case expr? (`when expr {p:.ll.p_i} `then expr {:((v2;P);(v4;p))})+ (`else expr {:(v2;P)})? `end {v:raze v3; :(`decode;P,v[;1],$[count v4;v4 1;P];enlist[v2],v[;0],enlist$[count v4;v4 0;::])}
extcast: `extract "(" name `from expr ")" {:(`convert;P;(v5;enlist v3))} | `cast "(" expr `as type ")" {:(`convert;P;(v3;v5))}
type: name ("(" exprLst? ")")? {:enlist v1}
join: tbl ((((`left|`right|`full) `outer? {:v1} | `inner | `cross)? `join {:$[count v1;v1;`cross]}| "," {:`cross}) tbl (`on jexpl 2)?)* | "(" join ")" 2
jexpl: jexp ("," jexp 2)* {:enlist[v1],v2}
jexp: name "=" name {:(v1;v3;P)}
tbl: {p:.ll.p_i} (fnCall | name | "(" sel ")" 2) (`as? name 2)? {:(v1;$[count v2;v2;`];p)}
decl: name type

PARSER start
