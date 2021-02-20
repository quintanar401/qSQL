.qsql.eval:{[s]
  p:.ll.parse s:.ll.lexer s; .qsql.c.ctx:`meta`id`pid`pos`etyp!((0#`)!();1;0N;0;`start);
  .qsql.c.emap:(`id`pid!0 0;.qsql.c.ctx);
  v:@[{first 0N!.qsql.c.check x};p;.qsql.t.throw s];
  .qsql.e.ctx:`plan`typ`targets`tid!(();`start;([] id:`$());`$());
  .qsql.e.updTargets[];
  .qsql.e.makePlan v;
  :@[eval;v;.qsql.t.throw s];
 };
.S.e:{.qsql.eval x};
.qsql.e.makePlan:{$[0=t:type x;.z.s each x;99=t;.qsql.e.plan1 x;x]};
.qsql.e.plan:{$[`val=x`etyp;.qsql.e.planV;.qsql.e.planS]x};
/ Variable must be requested within the existng context. If both are remote: a) the same remote srvs: inline; b) small variable: request separately; c) exception otherwise.
/ Do not allow tables outside select from (except small).
.qsql.e.planV:{
  t:.qsql.e.tmap x`id`pid; isJ:`sqlj=.qsql.c.emap[x`pid]`etyp; / 2#(targets;class)
  if[not(`small=t[0;1])|f:t[0;0]~t[1;0]; v:t[0;0] inter t[1;0];'string[x`pos]," different set of remote servers vs the main expression. Difference: main - ",(","sv string t[1;0] except v)," , this - ",","sv string t[0;0] except v];
  if[f;
    if[not isJ|`small=t[0;1]; 'string[x`pos]," large tables can be used only in select from clause"];
    :x `name`val `val in key x;
  ];
  if[count t[0;0]; .qsql.e.ctx[`plan],:enlist(`remReq;x`pos;id:.z.P;t[0;0];x`name)];
  if[count t[1;0]; .qsql.e.ctx[`plan],:enlist(`remSnd;x`pos;id;t[1;0];x`name)];
  :(`.qsql.e.map;id);
 };
.qsql.e.planS:{
  c:.qsql.e.ctx; t:.qsql.e.getSTargets x[`join]1;
  .qsql.e.ctx:`plan`typ`targets`tid!(();`join;t;t`id);
 };
/ .qsql.e.getSTargets:{{$[(count[y`targets]&`small=x 1)|0=count x 0;y`targets`class;x]}/[$[`val=x`etype;x[0]`targets`class;(`$();`small];x 1]};
/ Calculate targets for selects and etc.
.qsql.e.updTargets:{.qsql.e.tmap:count[e:.qsql.c.emap]#enlist (::);.qsql.e.upd1Target[{x[0]group x 1}flip e@\:`id`pid;1]};
.qsql.e.upd1Target:{
  if[`val=t:(v:.qsql.c.emap[y])`etyp;:.qsql.e.tmap[y]:v`targets`class]; / vars already have target info
  if[0=count c:x y; :.qsql.e.tmap[y]:(([] id:`$());`small)]; / no dependencies = no targets
  .qsql.e.tmap[y]:mx:.qsql.e.maxTarget[.qsql.e.upd1Target[x] each c]; / update leaves first
  if[(`selj=v`etyp)&not `small=mx 1; .qsql.e.tmap[last c]:mx]; / join expr has priority
  :mx;
 };
/ Select the 1) largest target 2) remotest
.qsql.e.maxTarget:{
  if[1=count x;:x 0];
  j:first where cl=max cl:.qsql.t.classes?c:x[;1]; / max sized value
  if[`small=c j; i:asc each x[;0]@\:`id; :$[~/[i];(x[0;0];`small);(([]id:`$());`small)]]; / if all are small execute remotely only if all srvs are the same
  :x;
 };

.qsql.c.check:{
  if[0=t:type x;
    if[(3=count x)&-11=type n:x 0; / (`fn;pos;(args))
      if[n in key .qsql.f; :.qsql.c.checkSysFn x];
      if[n=`:get; :.qsql.c.resolve x];
    ];
    '"not impl";
  ];
  if[99=t; :.qsql.c[x`sql] x]; / SQL exprs
  :(x;.qsql.t.qtype x;`1);
 };

/ Variable resolver: returns simple value or dict. Dict (result of .qsql.ext.resolveName) will be extended with the following fields:
/ @param x list Varable: (`:get;pos;name).
/ @returns dict See descr below.
/ <ul><li>name - real variable name, x by default</li>
/ <li>targets - servers with this var, empty by default</li>
/ <li>class - value category: part, splay, big, small(default)</li>
/ <li>pos - position in the expression</li>
/ <li>id - unique ID within the expression</li>
/ <li>pid - ID of the current context</li>
/ <li>etyp - expression type, `val in this case</li>
/ <li>alias - the original name</li>
/ <li>meta - for tables, map column->type</li>
/ </ul>
.qsql.c.resolve:{
  if[(n:x 2)in key m:.qsql.c.ctx`a2u; :((`:col;n);.qsql.c.ctx[`cmeta]m n;`n)]; / columns
  if[0=count v:.qsql.ext.resolveName n; 'string[x 1]," unknown variable ",string n]; / external vars
  if[99=type v; / value may not be available atm
    v:(`name`targets`class`alias!(n;([] id:`$());`small;n)),v; v[`pos`id`pid`etyp]:(x 1;count .qsql.c.emap;.qsql.c.ctx`id;`val);
    if[`Tbl=t:v`typ;
      if[not `meta in key v; v[`meta]:meta v`val];
      if[not 11=type key m:v`meta; v[`meta]:exec c!.qsql.t.q2qtype t from m];
      if[not 7=type value m:v`meta; v[`meta]:.qsql.t.qtypes?m];
    ];
    .qsql.c.emap,:enlist v;
    :(v;.qsql.t.qtypes?t;`m`1 t in .qsql.t.qtypes_a);
  ];
  :($[abs[type v]in 0 11h;enlist v;v];.qsql.t.qtype v;`1`m 0<type v);
 };
/ calculate arg types+dims, return type, fix nulls. Returns: ((exprs;types;dims);rtype)
.qsql.c.checkTypes:{[f;a;pos]
  if[0=count a; :(enlist (1;.qsql.t.tj;`1);f[`rtype]0)]; / 0 args functions
  if[(null t:f[`rtype]f[`atnum]sv i)|any j:f[`atnum]=i:f[`atype]?'at:(a:.qsql.c.check each a)[;1];
    / try to recover if the problem is in nulls
    if[not (all .qsql.t.tnul=at j)&count j:where j;
      'string[pos]," invalid argument type(s)",$[any j;", position(s): "," "sv string 1+j;""],", inferred types: ",", "sv .qsql.t.qnames at;
    ];
    if[null t:f[`rtype]f[`atnum]sv @[i;j;:;nn:f[`nulls]j];
      'string[pos]," can't assign types to nulls, inferred types: ",", "sv .qsql.t.qnames at;
    ];
    a:.[a;(j;0);:;.qsql.t.qnulls nt:f[`atype;j]@'nn];
    a:.[a;(j;1);:;nt];
    a:.[a;(j;2);:;?[(nt=.qsql.t.tC)|nt<.qsql.t.lmt1;`1;`m]];
  ];
  :(a;t);
 };
/ create expr: f - function, a - arg exprs, rt - return type, dim - (prefix expr;return dim)
/ returns either ((f;a);rt;rdim) or (dim[0],(f;(enlist;a));rt;rdim) - the second is needed when there may be length error
.qsql.c.retExpr:{[f;a;rt;dim] ($[c:count dim 0;dim[0],(f;enlist[enlist],a);enlist[f],a];rt;dim 1)};
/ type check for a general lib function (name;pos;args)
.qsql.c.checkSysFn:{
  if[not((f:.qsql.f n:x 0)`anum) count a:x 2;
    / try to recover if there are optional args
    if[`opt in key f; if[not ()~first o:count[a]_f`opt; a:a,o]];
    if[not f[`anum] count a; 'string[x 1]," invalid number of args in ",string n];
  ];
  if[`tchk in key f; :f[`tchk][f;a;x 1]];
  a:.qsql.c.checkTypes[f;a;x 1]; / (arg type info;ret type)
  if[any i:a[0;;1] in .qsql.t.ta,.qsql.t.tA; a[0;0;0]:(enlist;::;where i;a[0;0;0])]; / hack, need to somehow indicate char vectors
  if[(f`catch)&0=count first dim:.qsql.c.getDim[f;a[0;;2];x 1]; dim[0]:({.[y;z;{'string[x]," ",y}x]};x 1)];
  :.qsql.c.retExpr[f`fn;a[0;;0];a 1;dim];
 };
/ list function
.qsql.c.list:{[f;l;pos]
  t:(l:.qsql.c.check each l)[;1]; l:l[;0];
  if[enlist[`Tbl]~.qsql.t.qtypes t;
    if[not 1=count m:l[0]`meta; 'string[pos]," table must have only one column, found: ",","sv string key m];
    :(({x:first value 0!x; $[1=count x;x 0;x]};l);first value m;`m);
  ];
  if[(any tt=.qsql.t.tA)|(any .qsql.t.tK<tt)|not 1=count tt:distinct t except .qsql.t.tnul;
    if[not(2=count tt)&(all tt in .qsql.t.ts,.qsql.t.tC)|all tt in .qsql.t.tS,.qsql.t.tCc;
      'string[pos],$[0=count tt;" non null is expected in list";any .qsql.t.tK<tt;" list arguments must be atoms or typed vectors";
        any .qsql.t.tA=tt;" lists of char vectors are not allowed, use strings";" all arguments must have the same type in list"],", inferred types: ",", "sv .qsql.t.qnames t;
    ];
    l:@[l;where t in .qsql.t.ts,.qsql.t.tS;{(string;x)}]; / if there are syms and strings cast all to string
    tt:(),.qsql.t.type l 0;
  ];
  if[any i:t=.qsql.t.tnul;l:@[l;i;:;.qsql.t.getnull[tt 0;i:where i]]];
  :(enlist[enlist],l;.qsql.t.qtypesNxt tt 0;`m); / promote tt 1 step up
 };
/ all kinds of = > <
.qsql.c.xeq:{[f;a;pos] a:.qsql.c.checkTypes[f;a;pos]; dim:.qsql.c.getDim[f;a[0;;2];pos]; .qsql.c.xeq0[f;a;dim;pos]};
.qsql.c.xeq0:{[f;aa;dim;pos]
  a:first aa;
  if[any i:(t:a[;1])in .qsql.t.qtypes?`a`A`C`Cc; / strings + char column
    a:.[a;(where not i;0);{(string;x)}]; / convert syms -> str
    if[any i:t in .qsql.t.qtypes?`a`A; / char column, make another arg char too
      if[not all i; a:.[a;(where not i;0);{({$[-10=type x;x;$[type x;@;each][{$[1=count x;x 0;"\000"]};x]]};x)}]];
      :.qsql.c.retExpr[f`fn;a[;0];aa 1;dim]; / keep the original fns
    ];
    ad:$[all t:t in .qsql.t.qtypes?`S`Cc;';t 0;\:;t 1;/:;::];
    fn:$[`eq=n:f`name;ad(~);`neq=n;(')[not;ad(~)];`lt=n;ad .qsql.ff.strlt;`gt=n;ad .qsql.ff.strgt;`lte=n;(')[not;ad .qsql.ff.strgt];(')[not;ad .qsql.ff.strlt]];
    :.qsql.c.retExpr[fn;a[;0];aa 1;dim];
  ];
  :.qsql.c.retExpr[f`fn;a[;0];aa 1;dim];
 };
.qsql.c.within:{[f;a;pos]
  if[not ()~r:.[.qsql.c.withinDef;(f;a;pos);()]; :r]; / within can handle this
  :.qsql.c.checkSysFn (`and;pos;((`gte;pos;(a 0;a 1));(`lte;pos;(a 0;a 2)))); / transform into x>=y and x<=z
 };
.qsql.c.withinDef:{[f;a;pos]
  a:.qsql.c.checkTypes[f;a;pos];
  dim:.qsql.c.getDim[f;a[0;;2];pos];
  :.qsql.c.retExpr[f`fn;{(x 0;(enlist;x 1;x 2))}a[0;;0];a 1;dim];
 };
.qsql.c.typefn:{[f;a;pos] a:.qsql.c.check each a; (.qsql.t.qnames a[0;1];30;`1)};
.qsql.c.convert:{[f;a;pos]
  a:$[(::)~a 0;.[;0 0;:;::];::] first .qsql.c.checkTypes[f;a;pos]; / restore null
  if[not(type t:a[1;0])in 10 11h; 'string[pos]," convert requires explicit type argument as a string/symbol"];
  if[null tt:.qsql.t.castMap .qsql.t.normType t:$[10=type t;t;t 0]; 'string[pos]," unknown type ",string t];
  if[null rt:(.qsql.t.qtypesMap $[-11=type tt;.qsql.t.tj;10=tt;.qsql.t.tC;.qsql.t.lmt1-tt])(.qsql.t.qtypesMap t)?t:a[0;1]; 'string[pos]," can't convert ",.qsql.t.qnames[t]," to ",$[-11=type tt;string tt;.qsql.t.qnames .qsql.t.lmt1-tt]];
  dim:.qsql.c.getDim[f;a[;2];pos];
  :(({[p;t;x;y].[.qsql.ff.convert;(y;x;t);{'string[x]," ",y}p]};pos;t),a[;0];rt;dim 1);
 };
.qsql.c.decode:{[f;a;pos]
  if[noA0:()~a 0; a[0]:1]; if[df:count[a]mod 2; a:a,(::)]; if[nif:`:dec~last a; a:(-1_a),(::)];
  t:(a:$[nif;{(-1_x),enlist`:dec,1_first x};::] .qsql.c.check each a)[;1]; v:a[;0];
  ic:1+2*til (count[t]-1)div 2; iv:(ic+1),count[t]-1;
  / nulls
  if[(all vi:.qsql.t.tnul=t iv)|(noA0&all ci:.qsql.t.tnul=t ic)|.qsql.t.tnul=t 0; :(::;.qsql.t.tnul;`1)]; / main expr is null, subconds are null or value expr are null
  if[any vi;v:@[v;i;:;.qsql.t.getnull[it:.qsql.t.qtypesMin t iv first where not vi;i:iv where vi]]; t:@[t;i;:;it]]; / fix nulls
  if[any ci;
    if[not noA0; v:@[v;i;:;.qsql.t.getnull[it:.qsql.t.qtypesMin t 0;i:ic where ci]]; t:@[t;i;:;it]]; / case expr when null ...
    if[noA0; ic:ic ci:where ci; iv:iv 1+ci]; / case when null then ..  -- just remove null conditions
  ];
  / conditional expr
  if[not noA0; / check that all exp0=expN are correct
    if[any i:{(null x[`rtype]x[`atnum]sv i)|any x[`atnum]=i:x[`atype]?'(y;z)}[.qsql.f.eq;t 0] each t ic;
      'string[first pos]," types in the following conditions are incompatible with the main value: ",(" "sv string 1+(ic where i) div 2),", inferred types: ",", "sv .qsql.t.qnames neg[df]_t;
    ];
    c:first each .qsql.c.xeq0[.qsql.f.eq;;(();`n);first pos] each (;0) each ((`:dec;t 0);) each flip (v;t)[;ic]; / check each condition against the first value, there will be no exc
  ];
  if[noA0; c:v ic; if[not all t[ic]in .qsql.t.qtypes?`b`B; 'string[first pos]," all conditions must have boolean or boolean[] type, inferred condition types: ",", "sv .qsql.t.qnames t ic]];
  / value expressions
  if[1<>count distinct .qsql.t.qtypesMin d:t iv;
    'string[first pos]," all values in decode/case must have the same type, inferred value types: ",", "sv .qsql.t.qnames t neg[df]_iv;
  ];
  :((`.qsql.c.decode2;$[noA0;::;a[0;0]];enlist c,1b;enlist v iv;enlist (count[iv],2)#1_count[a]#pos;max d);max d;$[all `1=dim:a[;2] 0,iv;`1;`n in dim;`n;`m]);
 };
.qsql.c.decode2:{[cc;c;v;pos;rt]
  f:$[(::)~cc;::;.qsql.ff.substn[3;enlist[`:dec]!enlist $[(abs type cc) in 11 0h;enlist cc;cc]]];
  :last .qsql.c.decode3[f;rt]/[(1b;::);c;v;pos];
 };
.qsql.c.decode3:{[f;rt;b;c;v;pos]
  if[not any b 0;:b];
  c:@[eval;f c;{'string[x],$[y~"length";" arguments must be atoms/equal length vectors";y like "[0-9]*";y;" ",y]}pos 0]; / c must be a bool or bool[]
  if[(0>type b 0)&isV:0<type c; b:count[c]#/:enlist each b]; / convert b into vector
  if[isV&count[c]<>count b 0; 'string[pos 0]," incompatible length: expected ",string[count b 0],", got ",string count c];
  if[$[isb:0>type b 0;not i:c;0=count i:where c&b 0]; :b]; b[0]:$[isb;0b;@[b 0;i;:;0b]];
  if[isb&isV:((.qsql.t.tA=rt)|not 10=type v)&0<=type v:eval f v; b:count[v]#/:enlist each b; isb:0b];
  if[isV&count[v]<>count b 0; 'string[pos 1]," incompatible length: expected ",string[count b 0],", got ",string count v];
  b[1]:$[isb;v;@[b 1;i;:;$[isV;v i;10=type v;count[i]#enlist v;v]]];
  :b;
 };
.qsql.c.greatest:{[f;a;pos] .qsql.c.checkSysFn {(`or;x;(y;z))}[pos]/[a]};
.qsql.c.least:{[f;a;pos] .qsql.c.checkSysFn {(`and;x;(y;z))}[pos]/[a]};
.qsql.c.nullif:{[f;a;pos] .qsql.c.checkSysFn (`decode;pos;(a 0;a 1;::;`:dec))};
/ ideal.real -> 1 means either atom or irrelevant, n means vector with some fixed size (column in a table), m - unknown/irrelevant
.qsql.c.dMap:(!). flip(`1.1`1;`1.n`e;`1.m`m;`n.1`1;`m.1`1;`n.n`n;`n.m`m;`m.n`1;`m.m`1);
/ get the return dimension, (fn;input dims;pos) -> (() or (`check;pos);return dim)
.qsql.c.getDim:{[a;d;i]
  if[`e in d:0N!.qsql.c.dMap` sv/:((di:a[`dims]) 0),'d;'string[i]," atomic value is expected in args"];
  :($[(1<sum`m=d)|all`n`m in d;(`.qsql.c.dcheck;i);()];$[(rt:di 1)in`1`m;rt;`n in d;`n;all`1=d;`1;`m]);
 };
.qsql.c.dcheck:{[i;f;a]
  0N!(`dcheck;f;a);
  // if[1<count distinct count each ai where -1<type each ai:a idx; 'string[i]," all arguments in positions ",(" "sv string 1+idx)," must be atoms/equal length vectors"];
  :.[f;a;{'string[x],$[y~"length";" arguments must be atoms/equal length vectors";" ",y]}i];
 };
