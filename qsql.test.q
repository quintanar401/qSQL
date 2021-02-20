.qsql.test.runTestsFn:{[f]
  if[0=count t:.qsql.f[f]`tst; :()];
  :raze {[f;t]
    a:@[.qsql.eval;t 0;::];
    b:@[{$["Q"=first x;value 2_x;"Exc"~x;x;.qsql.eval x]};t 1;::];
    if[(10=type a)&b~"Exc"; if[a like "At *";:()]];
    :$[a~b;();enlist string[f]," test [",(";"sv t),"] failed with [",.Q.s1[a],";",.Q.s1[b],"]"];
  }[f] each t;
 };

.qsql.test.internalFns:{
 -1 raze .qsql.test.runTestsFn each `plus`list`mult`minus`divide`div`eq`neq`gt`lt`gte`lte`to_char`type`convert`not`or`and`year`week`upper`trim`translate`timestampdiff`current_date,
  `now`current_user`database`dayname`dayofmonth`dayofweek`dayofyear`degrees`exp`floor`neg`abs`acos`add_month`asin`atan`atan2`ceiling`char`ascii`concat`cos`cot`decode`greatest,
  `hour`isnull`initcap`insert`instr`last_day`lower`least`left`len`locate`localtime`localtimestamp`log`log10`lpad`ltrim`minute`mod`monthname`month`month_between`next_day`nullif,
  `pi`power`prefix`quarter`radians`rand`repeat`replace`right`round`rpad`rtrim`second`sign`sin`soundex`difference`space`sqrt`substring`suffix`tan`timestampadd;
 };

.qsql.ext.resolveName:{
  if[x=`lvar1; :1];
  if[x=`lvar123; :1 2 3];
  if[x=`tbl1; :`typ`val`class!(`Tbl;([] a:til 10; b:raze 2#'til 5);`small)];
  :();
 };
