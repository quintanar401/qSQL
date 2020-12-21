/ time to q time
.qsql.t.t2qt:`year`month`day`hour`minute`second!`year`mm`dd`hh`uu`ss;

/ time intervals
.qsql.t.tInt:`frac`second`minute`hour`day`week`month`quarter`year!("n"$"t"$1),("n"$00:00:01 00:01 01:00),1D 7D 31D 92D 365D;

/ date intervals
.qsql.t.dInt:`month`quarter`year!1 3 12;

/ Native types - atom + vector + vector of vector
.qsql.t.qtypes:(`Lst^`$(reverse[string .Q.t],1_upper .Q.t),upper[.Q.t],'.Q.t),`Nul;
@[`.qsql.t.qtypes;10 23;:;`a`A]; / Use name "a" for char columns
@[`.qsql.t.qtypes;0 40 61;:;`k`K`Kk]; / enumerations
.qsql.t.qtypesMap:{raze{x!count[x]#enlist x}each (til count x)value group distinct each lower string x}.qsql.t.qtypes; / type -> similar types: s -> s S sS
.qsql.t.qtypesMin:min each .qsql.t.qtypesMap;

.qsql.t.qtypes_a:.qsql.t.qtypes where{lower[x]=x:x[;0]} string .qsql.t.qtypes; / atoms
.qsql.t.qtypes_aA:distinct`j,.qsql.t.qtypes where 1=count each string .qsql.t.qtypes; / atoms + vectors
.qsql.t.qtypes_aAa:distinct`j,.qsql.t.qtypes except `Lst`Nul; / atoms + vectors + vectors of vectors
.qsql.t.qtypes_n:distinct`j,.qsql.t.qtypes except`Cc`Ss`g`G`Gg`C`s`S`Lst`Nul`A`a; / numeric types, put j in front to make it the default null type

/ type groups
.qsql.t.tgroup:(!). flip(
  (`;`); / simplify val^grp`val
  (`Str;`C`s`S`Cc);
  (`STR;`C`s`S`Cc`Ss); / symbols + strings
  (`Date;`d`D`p`P`m`M`z`Z);
  (`DATE;`d`D`Dd`p`P`Pp`m`M`Mm`z`Z`Zz); / all date related types
  (`TIME;`p`P`Pp`n`N`Nn`t`T`Tt`u`U`Uu`v`V`Vv`z`Z`Zz); / all time related types
  (`DATETIME;`d`D`Dd`p`P`Pp`m`M`Mm`z`Z`Zz`t`T`Tt`u`U`Uu`v`V`Vv); / date+time
  (`num;.qsql.t.qtypes_n inter .qsql.t.qtypes_a);
  (`Num;.qsql.t.qtypes_n inter .qsql.t.qtypes_a,.qsql.t.qtypes_aA);
  (`NUM;.qsql.t.qtypes_n); / all integer based types
  (`All;.qsql.t.qtypes_aA,`Cc); / all atoms+vectors+string[]
  (`ALL;.qsql.t.qtypes_aAa)
 );

/ Primitives: nulls and non-nulls
/ .qsql.t.qnulls:({$[(x in -20 20 41h)|(.qsql.t.qtypes x+20)=`Lst;();21>x;(abs[x]$())1;("h"$x-21)$()]} each "h"$-20+til -1+count .qsql.t.qtypes),(::);
.qsql.t.qnulls:({$[(x in -20 20 41h)|(.qsql.t.qtypes x+20)=`Lst;();x=3;"";x=-11;(),`;0>x;(abs[x]$())1;21>x;x$();()]} each "h"$-20+til -1+count .qsql.t.qtypes),(::);
.qsql.t.qones:{a:x~u:upper x; v:$["Lst"~x;:enlist (::);x~"Nul";::;(f:first u)in"ZDM";lower[f]$10;f="A";" ";f="K";`1;f$"10"]; $[a;enlist v;2=count u;enlist enlist v;v]} each string .qsql.t.qtypes;
.qsql.t.qnames:{$[x~(::);"null";x~enlist(::);"list";x~" ";"char";x~()," ";"string";0>type x;string key (),x;.z.s[first x],"[]"]} each .qsql.t.qones;
.qsql.t.qnames[23]:"char[]";

/ odbc type to q type map + q types
.qsql.t.odbc2q:(`char`varchar`tinyint`smallint`integer`bigint`double`numeric!(10;10;16;15;14;13;11;11)),
   {(@[;where k in`minute`second`month;{`$"q",string x}] k:key each 0#'.qsql.t.qones t)!t:(til 20) except 0 17 10}[];
.qsql.t.castMap:("h"$20-.qsql.t.odbc2q),.qsql.t.t2qt;

/ get null for an odbc type
.qsql.t.null:{$[x in key m:.qsql.t.odbc2q;.qsql.t.qnulls m x;0N]};
.qsql.t.qnull:{$[0>type n:.qsql.t.qnulls .qsql.t.qtype x;n;count[x]#enlist n]};
.qsql.t.getnull:{$[0>t:type n:.qsql.t.qnulls x;$[-11=t;count[y]#enlist n;n];count[y]#enlist n]}; / suitable null for assign expression
.qsql.t.getnull2:{.qsql.t.qnulls .qsql.t.qtypesMap[x] ()~n:.qsql.t.qnulls x};

/ extract day from a date odbc value(s)
.qsql.t.day:{1+x-"d"$"m"$x}"d"$;

/ normalize odbc type name
.qsql.t.normType:{$[(x:lower$[10=type x;x;string x])~"sql_tsi_frac_second";`frac;`$last "_" vs x]};

/ return type with a enum mapped to a normal type, functions/tables/dicts mapped to 0
.qsql.t.type:{$[not t:type x;$[(first[t]within 1 20h)&1=count t:distinct type each x;21+.z.s x 0;41];x~(::);62;76<t;count .qsql.t.qtypes;20>abs t;20+t;11=abs t:type value key x;20+t;14 26 t>0]};
.qsql.t.qtype:{.qsql.t.type $[type[x]in 0 11h;$[1=count x;x 0;x];x]}; / like type but for eval expressions

/ return select what expression
.qsql.t.what:{[v1;v2] v:enlist[v1],v2; ({@/[x;v;:;`$string[key g]{$[1=count y;(),x;x,/:y]}'string til each count each v:value g:group x]}`xcol^{$[null x;first .qsql.t.e2syms[x],`;x]}each v[;0])!v[;1]};

/ extract all names except function names from an expression
.qsql.t.e2syms:{$[not type x;raze .z.s each 1_x;-11=type x;x;0#`]};

/ Check name against internal functions/other names.
.qsql.t.resolveName:{$[(l:lower x)in key .qsql.F;` sv `.sql.F,l;x]};

/ special values {x v}
.qsql.t.spl:{.[.qsql.t.splP;(y;z);{'"At ",.ll.posErr[x]," ",y}x]}
.qsql.t.splP:{
  if[x in`n`I`i`d`t`ts;
    if[not (1=count y)&type[y]in 10 11h; '"special value: string/symbol is expected"];
    y:$[10=type y;`$y;y 0];
    if[x=`n; :.qsql.t.null y];
    if[x in`I`i; :((max;min)x=`I) 0#.qsql.t.null y];
    :((`d`t`ts!"DTP")x)$string y;
  ];
  if[x=`fn; :y];
  '"special value: unknown format"
 };
