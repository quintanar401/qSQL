/ select
.qsql.c.sel:{
  S::x;
  ctx:.qsql.c.ctx; .qsql.c.ctx:`cmeta`id`pid`etyp!(0#ctx`cmeta;id:count .qsql.c.emap;ctx`id;`selj); g:count x`grp;
  .qsql.c.emap,:enlist .qsql.c.ctx;
  one:0=count (j:.qsql.c.selJ x`join)2; / join step 1: get the final meta and column mappings
  .qsql.c.ctx[`id`pid`etyp]:(count .qsql.c.emap;id;`sel); .qsql.c.ctx[`a2c`a2u`cmeta]:j 0; c:.qsql.c.ctx;

  w:0N!$[count w:x`whe;.qsql.c.selW w;w];
  s:0N!$[count s:x`sel;.qsql.c.selS[s;g];(u;s!flip(u;c[`cmeta] u:c[`a2u] s:distinct value c`a2c))];
  ac:distinct c[`a2u] s[0],$[count w;raze w[;2];`$()];
  r:.qsql.c.ctx; .qsql.c.ctx:ctx; r[`meta`sel`whe`join`pos`cmap]:(last each s 1;first each s 1;w;j;x`pos;ac);
  .qsql.c.emap,:enlist r;
  :(r;.qsql.t.qtypes?`Tbl;`m);
 };
/ select/main.
/ @param s list Main expression: (names;exprs;positions)
/ @returns dict Unique name -> expr mapping.
.qsql.c.selS:{[x;g]
  s:.qsql.c.check each x 1;
  if[any i:s[;2]=`m; 'string[x[2;first where i]]," wrong expression length in select"];
  if[any i:null s[j;1]:.qsql.t.qtypesNxt t:s[j:$[g;::;where s[;2]=`1];1]; 'string[x[2;first where i]," unsupported expression type"]];
  if[not g;s:$[(count s)=count j;.[s;(j;0);{(enlist;x)}];.[s;(j where t=.qsql.t.tC;0);{(#;(count;`i);(enlist;x))}]]];
  n:`x^(.qsql.c.ctx[`a2c]first each cl:.qsql.c.extract each s)^{x[where x="."]:"_";`$x} each string x 0;
  if[not (count distinct n)=count n; n:{x[y]:`$n,string(1+)/[{(`$y,string z)in x}[x;n:string x y];1];x}/[n;raze 1_'value group n]]; / rename identical columns
  :(raze cl;n!s[;0 1]);
 };
/ select/where, phase 1 - AND transformation, type check, extract column names.
/ @param x list Where expression: (expr;pos)
/ @returns list AND expressions: (expr;pos;cols), expr returns b/B, 1/n.
.qsql.c.selW:{
  a:{$[0=type x;$[`and~x 0;enlist[(x[2;0];y)],.z.s[x[2;1];x 1];enlist (x;y)];enlist (x;y)]} . x;
  a:{w:.qsql.c.check x 0; if[not (.qsql.t.qtypes w 1)in `b`B; 'string[x 1]," wrong 'where' type: ",.qsql.t.qnames[w 1],", must be boolean[]"];
    if[`m=w 2; 'string[x 1]," wrong expression length in 'where' clause"];
    (w 0;x 1;distinct .qsql.c.extract w 0)} each a;
  :a;
 };
/ select/join, phase 1 - resolve tables, create column maps.
/ @param x list Joins: (1st tbl;[(join type;tbl;on cond)])
/ @returns list (total cmap as (a2c;a2u;meta);(1st tbl as dict;other tbls);submaps;[(join type;cond)])
.qsql.c.selJ:{
  t:(.qsql.c.selT[x 0;("00";"")0=count t];.qsql.c.selT'[t;string til count t:x[1;;1]]); / tables
  if[0=count t 1; :(t[0]`a2c`a2u`cmeta;t;();())]; / only 1 table
  m:{(y`a2c`a2u`cmeta),'x}\[t[0]`a2c`a2u`cmeta;t 1]; / column mappings
  :(last m;t;m;x[1;;0 2]);
 };
/ select/join, phase 2 -
/ @param j list Result of .qsql.c.selJ
/ @param ac (symbol list) Required columns (unique names)
.qsql.c.selJ2:{[j;ac;w]
  if[0=count last j; .qsql.c.selJ2_1Tbl[j[1;0];w]];
  '"J2 unimpl";
 };
.qsql.c.selJ2_1Tbl:{[j;w]
  if[`val in key j; :j`val];
  :j`name;
 };
/ select/join/on j=[(c1;c2;pos)]
.qsql.c.selJOn:{[t;T;j]
  if[0=count j 1;:()];
  {if[null f:first where (z[1 0]in key x`a2c)&(z[0 1]in key y 0);'string[z 2]," invalid 'on' condition"]; }[t;T] each j;
 };
/ select/join/table - ensure it is a table, create mappings.
/ @param x list Table: (name/expr;as_name;pos)
/ @returns dict Table definition including a2c, a2u column maps, as_name as the alias.
.qsql.c.selT:{
  if[not `Tbl=.qsql.t.qtypes (t:.qsql.c.check (`:get;x 2;x 0)) 1; 'string[x 2]," table is expected"];
  t:t 0; if[not null x 1; t[`alias]:x 1];
  t[`a2c]:(c!c),((a:` sv/:t[`alias],/:c)!c),(u:`$y,/:string c)!c:key t`meta; / unique+aliases+original -> original
  t[`a2u]:u:(c,a)!u,u; / aliases+original -> unique
  t[`cmeta]:(u key m)!value m:t`meta; / rename to unique
  :t;
 };
/ Extract column names.
.qsql.c.extract:{$[type[x]in 0 11h;$[`:col~first x;x 1;raze .z.s each x];`$()]};
