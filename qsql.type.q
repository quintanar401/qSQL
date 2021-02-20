/ time to q time
.qsql.t.t2qt:`year`month`day`hour`minute`second!`year`mm`dd`hh`uu`ss;

/ time intervals
.qsql.t.tInt:`frac`second`minute`hour`day`week`month`quarter`year!("n"$"t"$1),("n"$00:00:01 00:01 01:00),1D 7D 31D 92D 365D;

/ date intervals
.qsql.t.dInt:`month`quarter`year!1 3 12;

/ Native types - atom + vector + vector of vector
.qsql.t.qtypes:(`Lst^`$(reverse[string .Q.t],1_upper .Q.t),upper[.Q.t],'.Q.t),`Nul`Tbl;
@[`.qsql.t.qtypes;10 23;:;`a`A]; / Use name "a" for char columns
@[`.qsql.t.qtypes;0 40 61;:;`k`K`Kk]; / enumerations
.qsql.t.qtypesMap:{raze{x!count[x]#enlist x}each (til count x)value group distinct each lower string x}.qsql.t.qtypes; / type -> similar types: s -> s S sS
.qsql.t.qtypesMin:min each .qsql.t.qtypesMap; / base type: S,Ss -> s
.qsql.t.qtypesNxt:raze {-1_x!next x} each .qsql.t.qtypesMap; / next type: s -> S
.qsql.t.q2qtype:{(v,u)!`$u,(u:upper v),'v:.Q.t except " "}[]; / map from q char types ("j") -> sql types
.qsql.t.q2qtype["c"]:`A; / char list, not string
.qsql.t.lmt1:1+.qsql.t.qtypes?`b; / first block - atoms
.qsql.t.tnul:.qsql.t.qtypes?`Nul;
.qsql.t.tj:.qsql.t.qtypes?`j;
.qsql.t.ti:.qsql.t.qtypes?`i;
.qsql.t.ts:.qsql.t.qtypes?`s;
.qsql.t.tS:.qsql.t.qtypes?`S;
.qsql.t.tC:.qsql.t.qtypes?`C;
.qsql.t.tsC:.qsql.t.qtypes?`s`C;
.qsql.t.tCc:.qsql.t.qtypes?`Cc;
.qsql.t.ta:.qsql.t.qtypes?`a;
.qsql.t.tA:.qsql.t.qtypes?`A;
.qsql.t.tK:.qsql.t.qtypes?`K;

.qsql.t.qtypes_a:.qsql.t.qtypes where{lower[x]=x:x[;0]} string .qsql.t.qtypes; / atoms
.qsql.t.qtypes_aA:distinct`j,.qsql.t.qtypes where 1=count each string .qsql.t.qtypes; / atoms + vectors
.qsql.t.qtypes_aAa:distinct`j,.qsql.t.qtypes except `Lst`Nul`Tbl; / atoms + vectors + vectors of vectors
.qsql.t.qtypes_n:distinct`j,.qsql.t.qtypes except`Cc`Ss`g`G`Gg`C`s`S`Lst`Nul`Tbl`A`a; / numeric types, put j in front to make it the default null type

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
.qsql.t.qnulls:({$[(t:.qsql.t.qtypes x)in`k`K`Kk`Lst;();t=`A;"";t=`s;(),`;0>x:"h"$x-.qsql.t.lmt1;(abs[x]$())1;x<.qsql.t.lmt1+1;x$();()]} each til -1+count .qsql.t.qtypes),(::);
.qsql.t.qones:{a:x~u:upper x; v:$["Lst"~x;:enlist (::);x~"Nul";::;x~"Tbl";([]a:1#1);(f:first u)in"ZDM";lower[f]$10;f="A";" ";f="K";`1;f$"10"]; $[a;enlist v;2=count u;enlist enlist v;v]} each string .qsql.t.qtypes;
.qsql.t.qnames:{$[x~(::);"null";x~enlist(::);"list";x~" ";"char";x~()," ";"string";98=type x;"table";0>type x;string key (),x;.z.s[first x],"[]"]} each .qsql.t.qones;
.qsql.t.qnames[.qsql.t.tA]:"char[]";

/ odbc type to q type map + q types
.qsql.t.odbc2q:(`char`varchar`tinyint`smallint`integer`bigint`double`numeric!.qsql.t.qtypes?`a`a`x`h`i`j`f`f),
   {(@[;where k in`minute`second`month;{`$"q",string x}] k:key each 0#'.qsql.t.qones t)!t:(til 20) except 0 17 10}[];
.qsql.t.castMap:("h"$.qsql.t.lmt1-.qsql.t.odbc2q),.qsql.t.t2qt;

/ get null for an odbc type
.qsql.t.null:{$[x in key m:.qsql.t.odbc2q;.qsql.t.qnulls m x;0N]};
.qsql.t.qnull:{$[0>type n:.qsql.t.qnulls .qsql.t.qtype x;n;count[x]#enlist n]};
.qsql.t.getnull:{$[0>t:type n:.qsql.t.qnulls x;$[-11=t;count[y]#enlist n;n];count[y]#enlist n]}; / suitable null for assign expression
.qsql.t.getnull2:{.qsql.t.qnulls .qsql.t.qtypesMap[x] ()~n:.qsql.t.qnulls x};

/ extract day from a date odbc value(s)
.qsql.t.day:{1+x-"d"$"m"$x}"d"$;

/ normalize odbc type name
.qsql.t.normType:{$[(x:lower$[10=type x;x;string x])~"sql_tsi_frac_second";`frac;`$last "_" vs x]};

/ return type with a enum mapped to a normal type, functions
.qsql.t.type:{$[not t:type x;$[(first[t]within 1 20h)&1=count t:distinct type each x;.qsql.t.lmt1+1+.z.s x 0;1+.qsql.t.lmt1*2];x~(::);.qsql.t.tnul;76<t;count .qsql.t.qtypes;20>abs t;.qsql.t.lmt1+t;11=abs t:type value key x;.qsql.t.lmt1+t;(.qsql.t.qtypes?`i`I) t>0]};
.qsql.t.qtype:{.qsql.t.type $[type[x]in 0 11h;$[1=count x;x 0;x];x]}; / like type but for eval expressions

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

.qsql.t.throw:{e:.ll.posErrIn[x;"J"$(n:y?" ")#y]; '$[n=count y;y;"At ",e,":",n _ y]};

.qsql.t.classes:`small`big`splayed`parted;

.qsql.t.trNew:{enlist each (0;0#0),x};
.qsql.t.trAddL:{@[x;::;,;.qsql.t.trNew y]; -1+count (get x)0};
.qsql.t.trAddN:{@[x;::;,;enlist each (0;z),y]; .[x;(0;z);:;c:-1+count get x]; c};
