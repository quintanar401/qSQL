.qsql.f.neg:{
  // Negate an argument. The argument must be a number or date/time value. Example: neg(x) or -x
  // @i neg
  // @t full NUM
  // @d n -> n
  // @tst neg(1) -> -1;; neg(list(-2.3)) -> list(2.3);; neg(list(list(4.5))) -> list(list(-4.5))
  // @tst neg(null) -> {n 'long'};; neg() -> Exc;; neg('a') -> Exc;; neg(1,2) -> Exc
  neg x};

.qsql.f.abs:{
  // Absolute value of an argument. The argument must be a number or date/time value. Example: abs(x)
  // @i abs
  // @t full NUM
  // @d n -> n
  // @tst abs(1) -> 1;; abs(list(-2.3)) -> list(2.3);; abs(list(list(-4.5))) -> list(list(4.5))
  // @tst abs(null) -> {n 'long'};; abs() -> Exc;; abs('a') -> Exc;; abs(1,2) -> Exc
  abs x};

.qsql.f.acos:{
  // Arccosine of an argument. The argument must be a number or date/time value. Example: acos(x)
  // @i acos
  // @t full NUM
  // @d n -> n
  // @tst acos(0.5) -> 1.0471975511965979;; acos(list(0.5)) -> list(1.0471975511965979);; acos(list(list(0.5))) -> list(list(1.0471975511965979))
  // @tst acos(null) -> {n 'float'};; acos() -> Exc;; acos('a') -> Exc;; acos(1,2) -> Exc
  acos x};

.qsql.f.add_month:{
  // The scalar function ADD_MONTHS adds to the date value the given number of months. Example: add_month(date,num)
  // @t full DATE Num
  // @d n n -> n
  // @tst add_month({d '2020.01.10'},1) -> {d '2020.02.10'};; add_month(list({d '2020.01.10'}),2) -> list({d '2020.03.10'});; add_month(list(list({ts '2020.01.10D'})),3) -> list(list({ts '2020.04.10D'}))
  // @tst add_month({d '2020.01.10'},list(4)) -> list({d '2020.05.10'});; add_month({d '2020.01.10'},list(list(4))) -> Exc;; add_month(list({d '2020.01.10'}),list(5)) -> list({d '2020.06.10'})
  // @tst add_month({d '2020.01.10'},-1) -> {d '2019.12.10'};; add_month({d '2020.01.10'},null) -> {n 'date'};; add_month(null,2) -> {n 'date'};; add_month(null,null) -> {n 'date'}
  // @tst add_month(list({d '2020.01.10'}),list(4,5)) -> Exc;; add_month({d '2020.01.10'},4,1) -> Exc;; add_month({d '2020.01.10'}) -> Exc;; add_month(1,1)-> Exc;; add_month({d '2020.01.10'},'a')-> Exc
  .qsql.ff.addMonth[x;y]};

.qsql.f.asin:{
  // Arcsine of an argument. The argument must be a number or date/time value. Example: asin(x)
  // @i asin
  // @t full NUM
  // @d n -> n
  // @tst asin(0.5) -> 0.5235987755982989;; asin(list(0.5)) -> list(0.5235987755982989);; asin(list(list(0.5))) -> list(list(0.5235987755982989))
  // @tst asin(null) -> {n 'float'};; asin() -> Exc;; asin('a') -> Exc;; asin(1,2) -> Exc
  asin x};

.qsql.f.atan:{
  // Arctangent of an argument. The argument must be a number or date/time value. Example: atan(x)
  // @i atan
  // @t full NUM
  // @d n -> n
  // @tst atan(0.5) -> 0.4636476090008061;; atan(list(0.5)) -> list(0.4636476090008061);; atan(list(list(0.5))) -> list(list(0.4636476090008061))
  // @tst atan(null) -> {n 'float'};; atan() -> Exc;; atan('a') -> Exc;; atan(1,2) -> Exc
  atan x};

.qsql.f.atan2:{
  // The scalar function ATAN2 returns the arctangent of the x and y coordinates. Example: atan2(x,y)
  // @t full Num Num
  // @d n n -> n
  // @tst atan2(0.5,1) -> 0.4636476090008061;; atan2(list(0.5,-0.5),1) -> list(0.4636476090008061,-0.4636476090008061);; atan2(list(list(0.5)),1) -> Exc
  // @tst atan2(0.5,list(1,-1)) -> list(0.4636476090008061,2.677945044588987);; atan2(0.5,list(list(1,-1))) -> Exc
  // @tst atan2(null,1) -> {n 'float'};; atan2(1,null) -> {n 'float'};; atan2(null,null) -> {n 'float'};; atan2(1) -> Exc;; atan2(1,'a') -> Exc;; atan2('a',1) -> Exc;; atan(1,2,3) -> Exc
  1 4.$atan(x%y;(y<0)*signum x)};

.qsql.f.ascii:{
  // The scalar function ASCII returns the ASCII value of the first character of the given character expression. Example: ascii(str)
  // @t full Str
  // @d n -> n
  // @tst ascii("a") -> 97;; ascii(list('ab','bb')) -> list(97,98);; ascii(list(list('a'))) -> Exc
  // @tst ascii('ba') -> 98;; ascii(list("ab")) -> list(97);; ascii(null) -> {n 'long'};; ascii(list("aa",null)) -> list(97,{n 'long'})
  // @tst ascii(1) -> Exc;; ascii() -> Exc;; ascii("a","b") -> Exc
  $[type x:.qsql.ff.strv x;$[count x;"j"$x 0;0N];@["j"$x[;0];where 0=count each x;:;0N]]};

.qsql.f.ceiling:{
  // Smallest integer greater than or equal to expression. Example: ceiling(x)
  // @i ceiling
  // @t full NUM
  // @d n -> n
  // @tst ceiling(0.5) -> 1;; ceiling(list(-1.5)) -> list(-1);; ceiling(list(list(5))) -> list(list(5))
  // @tst ceiling(null) -> {n 'long'};; ceiling() -> Exc;; ceiling('a') -> Exc;; ceiling(1,2) -> Exc
  ceiling x};

.qsql.f.char:{
  // The scalar function CHAR returns a character string with the first character having an ASCII value equal to the argument expression. Example char(x)
  // @t full Num
  // @d n -> n
  // @tst char(42) -> "*";; char(list(42.3,43.4)) -> list("*","+");; char(list(list(1))) -> Exc
  // @tst char(null) -> "";; char(list(42,null)) -> list("*","");; char('a') -> Exc;; char() -> Exc;; char(1,2) -> Exc
  $[0>type x;$[null x;"";string "c"$x];@[string"c"$x;where null x;{""}]]};

.qsql.f.concat:{
  // The scalar function CONCAT returns a concatenated character string formed by concatenating argument one with argument two. Example: concat(x,y)
  // @t full Str Str
  // @d n n -> n
  // @tst concat("ab","cd") -> "abcd";; concat("ab",'cd') -> "abcd";; concat('ab',"cd") -> "abcd";; concat('ab','cd') -> 'abcd'
  // @tst concat(list("ab","cd"),"ed") -> list("abed","cded");; concat(list("ab","cd"),'ed') -> list("abed","cded");; concat(list('ab','cd'),"ed") -> list("abed","cded");; concat(list('ab','cd'),'ed') -> list('abed','cded')
  // @tst concat("ed",list("ab","cd")) -> list("edab","edcd");; concat('ed',list("ab","cd")) -> list("edab","edcd");; concat("ed",list('ab','cd')) -> list("edab","edcd");; concat('ed',list('ab','cd')) -> list('edab','edcd')
  // @tst concat(list("ab"),list("cd")) -> list("abcd");; concat(list('ab'),list("cd")) -> list("abcd");; concat(list("ab"),list('cd')) -> list("abcd");; concat(list('ab'),list('cd')) -> list('abcd')
  // @tst concat("ab",null) -> "ab";; concat(null,"ab") -> "ab";; concat(null,'ab') -> "ab";; concat(null,null) -> ""
  // @tst concat("ab") -> Exc;; concat("ab","cd","ed") -> Exc;; concat(2,"ab") -> Exc;; concat("ab",2) -> Exc;; concat(list(list('a')),"b") -> Exc
  .qsql.ff.str2[,;x;y]};

.qsql.f.cos:{
  // The scalar function COS returns the cosine of expression. Example: cos(x)
  // @i cos
  // @t full NUM
  // @d n -> n
  // @tst cos(0.5) -> 0.8775825618903728;; cos(list(0.5)) -> list(0.8775825618903728);; cos(list(list(0.5))) -> list(list(0.8775825618903728))
  // @tst cos(null) -> {n 'float'};; cos() -> Exc;; cos('a') -> Exc;; cos(1,2) -> Exc
  cos x};

.qsql.f.cot:{
  // The scalar function COT returns the cotangent of the expression. Example: cot(x)
  // @t full NUM
  // @d n -> n
  // @tst cot(0.5) -> 1.830487721712452;; cot(list(0.5)) -> list(1.830487721712452);; cot(list(list(0.5))) -> list(list(1.830487721712452))
  // @tst cot(null) -> {n 'float'};; cot() -> Exc;; cot('a') -> Exc;; cot(1,2) -> Exc
  1.%tan x};

.qsql.f.current_date:.qsql.f.curdate:{
  // CURDATE/CURRENT_DATE returns the current date as a DATE value. Example: curdate(), current_date
  // @i {.z.D}
  // @t full
  // @d 1 -> 1
  // @tst curdate() -> Q .z.D;; current_date -> Q .z.D;; curdate(1) -> Exc
  .z.D};

.qsql.f.getdate:.qsql.f.now:.qsql.f.current_timestamp:{
  // GETDATE/CURRENT_TIMESTAMP/NOW returns the current date and time as a TIMESTAMP value. Example: current_timestamp, now(), getdate()
  // @i {.z.P}
  // @t full
  // @d 1 -> 1
  // tst current_timestamp -> Q .z.P;; getdate() -> Q .z.P;; now() -> Q .z.P;; now(1) -> Exc
  .z.P};

.qsql.f.user:.qsql.f.current_user:{
  // CURRENT_USER/USER returns a character string identifier for the database user as specified in the current connection. Example: current_user, user()
  // @t full
  // @d 1 -> 1
  // @tst current_user -> Q .qsql.ff.user[];; user() -> Q .qsql.ff.user[];; user(1) -> Exc
  .qsql.ff.user[]};

.qsql.f.curtime:{
  // CURTIME returns the current time as a TIME value. Example: curtime()
  // @i {.z.T}
  // @t full
  // @d 1 -> 1
  .z.T};

.qsql.f.database:{
  // The scalar function DATABASE returns the name of the database corresponding to the current connection name. Example: database
  // @t full
  // @d 1 -> 1
  // @tst database -> Q .qsql.ff.database[]
  .qsql.ff.database[]};

.qsql.f.dayname:{
  // Returns a character string containing the name of the day ('sun', 'mon', ...). Example: dayname(date)
  // @t full Date
  // @d n -> n
  // @tst dayname(cast({d '2020.05.01'} as qmonth)) -> "fri";; dayname(list({d '2020.05.02'},{d '2020.05.03'})) -> list("sat","sun")
  // @tst dayname(list(list({d '2020.05.04'}))) -> Exc;; dayname({ts '2020.05.04D'}) -> "mon";; dayname({ts '2020.05.05D'}) -> "tue";; dayname({ts '2020.05.06D'}) -> "wed";; dayname({ts '2020.05.07D'}) -> "thu"
  // @tst dayname(1) -> Exc;; dayname() -> Exc;; dayname({ts '2020.05.04D'},{ts '2020.05.04D'}) -> Exc;; dayname(null) -> ""
  (0N 3#"sunmontuewedthufrisat")(-1+"d"$x) mod 7};

.qsql.f.dayofmonth:{
  // The scalar function DAYOFMONTH returns the day of the month in the argument as a short integer value in the range of 1 - 31. Example: dayofmonth(date)
  // @t full DATE
  // @d n -> n
  // @tst dayofmonth(cast({d '2020.04.21'} as qmonth)) -> 1;; dayofmonth(list({d '2020.02.29'})) -> list(29);; dayofmonth(list(list({ts '2020.04.03'}))) -> list(list(3))
  // @tst dayofmonth(null) -> {n 'long'};; dayofmonth() -> Exc;; dayofmonth(1) -> Exc;; dayofmonth({d '2010.10.10'},{d '2010.10.10'}) -> Exc
  1+.qsql.ff.day x};

.qsql.f.dayofweek:{
  // The scalar function DAYOFWEEK returns the day of the week in the argument as a short integer value in the range of 1 - 7. Example: dayofweek(date)
  // @t full DATE
  // @d n -> n
  // @tst dayofweek({d '2020.05.05'}) -> 2;; dayofweek(list({d '2020.05.04'})) -> list(1);; dayofweek(list(list({ts '2020.05.03D'}))) -> list(list(7));; dayofweek(cast({d '2020.05.05'} as qmonth)) -> 5
  // @tst dayofweek(null) -> {n 'long'};; dayofweek() -> Exc;; dayofweek({d '2020.05.04'},{d '2020.05.04'}) -> Exc;; dayofweek(1) -> Exc
  x:"d"$x;1+x-`week$x};

.qsql.f.dayofyear:{
  // The scalar function DAYOFYEAR returns the day of the year in the argument as a short integer value in the range of 1 - 366. Example: dayofyear(date)
  // @t full DATE
  // @d n -> n
  // @tst dayofyear({d '2020.05.05'}) -> 126;; dayofyear(list({d '2020.12.31'})) -> list(366);; dayofyear(list(list({ts '2020.05.03D'}))) -> list(list(124));; dayofyear(cast({d '2020.05.05'} as qmonth)) -> 122
  // @tst dayofyear(null) -> {n 'long'};; dayofyear() -> Exc;; dayofyear({d '2020.05.04'},{d '2020.05.04'}) -> Exc;; dayofyear(1) -> Exc
  .qsql.ff.dayofyear x};

.qsql.f.decode:{
  // The DECODE scalar function is a type of conditional expression.  The scalar function DECODE compares the value of the first argument expression
  // with each even numbered expression and returns the next odd numbered expression. A default expression can be provided at the end.
  // Example: decode(cond,'b','best','d','dealable','unknown')
  // @t .qsql.c.decode All All All ...
  // @tst case when 2>1 then 1 end -> 1;; case when 0>1 then 1 end -> {n 'long'};; case when 2>1 then 1 else 3 end -> 1;; case when 2=1 then 1 else 3 end -> 3
  // @tst case 1+2 when 1+1 then abs(-10) else abs(-11) end -> 11;; case 1+2 when abs(-10) then 0 when abs(-3) then 10 end -> 10
  // @tst case when "aa"='bbb' then 1 when "aa"="aa" then 2 end -> 2;; case "aa" when 'bbb' then 1 when "aa" then 2 end -> 2
  // @tst decode("aa","bb",null,"bb") -> "bb"
  // @tst case when to_char("a")="aa" then 1 when to_char("a")="a" then 2 end -> 2
  // @tst case list(1,2) when 1 then 10 when 2 then 20 when 1 then 100 end -> list(10,20);;
  // @tst decode(null,null,null) -> null;; decode(null,1,2) -> null;; decode(1,null,2) -> {n 'long'};; decode(1,2,null) -> null;; decode(1,2,null,3) -> 3
  // @tst case when null then 1 else 2 end -> 2;; case 1 when null then 1 else 2 end -> 2
  // @tst decode(1,null,2,1,3) -> 3;; decode(1,null,2,1,null) -> {n 'long'};; case list(1,null) when null then 1 when list(1,3) then 2 end -> list(2,1)
  // @tst case list(1,null) when null then 1 else 2 end -> list(2,1)
  // @tst decode(1,'a',1) -> Exc;; decode(1,'a',1,'a',1) -> Exc;; decode(1,1,'a',2,2) -> Exc;; case when 1 then 1 end -> Exc
 1};

.qsql.f.degrees:{
  // The scalar function DEGREES returns the number of degrees in an angle specified in radians by expression. Example: degrees(num)
  // @i 57.295779513082*
  // @t full NUM
  // @d n -> n
  // @tst degrees(1) -> 57.295779513082;; degrees(list(1.0)) -> list(57.295779513082);; degrees(list(list(1.0))) -> list(list(57.295779513082))
  // @tst degrees(null) -> {n 'float'};; degrees() -> Exc;; degrees('a') -> Exc;; degrees(1,2) -> Exc
  x*57.295779513082};

.qsql.f.difference:{
  // The scalar function DIFFERENCE returns an integer value that indicates the difference between the values returned by the SOUNDEX function. Example: difference(str1,str2)
  // @t full Str Str
  // @d n n -> n
  // @tst difference("Bill","bill") -> 0;; difference(list('Bill'),"bils") -> list(1);; difference('Bill',list("bilst")) -> list(2);; difference(list('Bill'),list('bivst')) -> list(3)
  // @tst difference(null,"aa") -> {n 'long'};; difference("aa",null) -> {n 'long'};; difference(null,null) -> {n 'long'}
  // @tst difference("aa") -> Exc;; difference("aa","bb","vv") -> Exc;; difference(1,"aa") -> Exc;; difference("aa",1) -> Exc
  x:.qsql.ff.soundex x; y:.qsql.ff.soundex y;
  if[(0=count x)|0=count y;:0N];
  4-sum each $[type x;$[type y;:4-sum x=y;x=/:y];type y;x=\:y;x=y]};

.qsql.f.exp:{
  // The scalar function EXP returns the exponential value of expression (e raised to the power of expression). Example: exp(num)
  // @i exp
  // @t full NUM
  // @d n -> n
  // @tst exp(1) -> 2.718281828459045;; exp(list(1.0)) -> list(2.718281828459045);; exp(list(list(1.0))) -> list(list(2.718281828459045))
  // @tst exp(null) -> {n 'float'};; exp() -> Exc;; exp('a') -> Exc;; exp(1,2) -> Exc
  exp x};

.qsql.f.floor:{
  // The scalar function FLOOR returns the largest integer less than or equal to expression. Example: floor(num)
  // @i floor
  // @t full NUM
  // @d n -> n
  // @tst floor(1) -> 1;; floor(list(-1.4)) -> list(-2);; floor(list(list(1.4))) -> list(list(1))
  // @tst floor(null) -> {n 'long'};; floor() -> Exc;; floor('a') -> Exc;; floor(1,2) -> Exc
 floor x};

.qsql.f.greatest:{
  // The scalar function GREATEST returns the greatest value among the values of the given expressions. Example: greatest(v1,v2,v3)
  // @t .qsql.c.greatest NUM NUM ...
  // @d n n -> n
  // @tst greatest(1,2) -> 2;; greatest(1,list(0,2)) -> list(1,2);; greatest(list(1,3),list(2,2)) -> list(2,3)
  // @tst greatest(1,2,3,list(5,1)) -> list(5,3)
  // @tst greatest(null,1,2,3) -> 3;; greatest(null,null,null) -> {n 'long'}
  // @tst greatest(1) -> Exc;; greatest(1,"a") -> Exc;; greatest(list(1),2,3,list(1,2,3)) -> Exc
  1};

.qsql.f.hour:{
  // The scalar function HOUR returns the hour in the argument as a short integer value in the range of 0 - 23. Example: hour(time)
  // @i `hh$
  // @t full TIME
  // @d n -> n
  // @tst hour({t '11:10'}) -> Q 11i;; hour(list({ts '2010.10.10D10:11'},{ts '2010.10.10D11:11'})) -> Q 10 11i;; hour(list(list(cast(600 as qminute)))) -> list(list(cast(10 as int)))
  // @tst hour(cast(36000 as qsecond)) -> Q 10i;; hour(cast(3600000000000 as timespan)) -> Q 1i
  // @tst hour(null) -> Q 0Ni;; hour() -> Exc;; hour({t '11:10'},{t '11:10'}) -> Exc;; hour('a') -> Exc
 `hh$x};

.qsql.f.isnull:.qsql.f.ifnull:{
  // The scalar function IFNULL/ISNULL returns value if expr is null. If expr is not null, IFNULL returns expr. Example: ifnull(price,0.0)
  // @tpp {$[all x in .qsql.t.qtypes?`a`A;max x;y]}
  // @t full All All
  // @d n n -> n
  // @tst isnull(1,2) -> 1;; isnull({n 'float'},1.1) -> 1.1;; ifnull('a','') -> 'a';; ifnull("aa","") -> "aa";; ifnull("a",'') -> "a";; ifnull('b',"a") -> "b"
  // @tst isnull(list(1,null),2) -> list(1,2);; ifnull(list("aa",""),"bb") -> list("aa","bb");; ifnull(list('aa',''),'bb') -> list('aa','bb')
  // @tst ifnull(list("aa",""),'bb') -> list("aa","bb");; ifnull(list('aa',''),"bb") -> list("aa","bb")
  // @tst isnull(list(1,null),list(2,3)) -> list(1,3);; isnull(list("a",""),list("b","c")) -> list("a","c");; isnull(list('a',''),list('b','c')) -> list('a','c')
  // @tst isnull(list("a",""),list('b','c')) -> list("a","c");; isnull(list('a',''),list("b","c")) -> list("a","c")
  // @tst ifnull(to_char("a"),to_char("")) -> to_char("aa");; ifnull(to_char("a"),"") -> "a";; ifnull(to_char("a"),'b') -> "a";;
  // @tst ifnull("b",to_char("a")) -> "b";; ifnull('b',to_char("a")) -> "b";; ifnull(list(to_char("a"),to_char(' ')),to_char("b")) -> list(to_char("a"),to_char("b"))
  // @tst ifnull(list(to_char("a"),to_char(' ')),"bb") -> list("a"," ");; ifnull(list(to_char("a"),to_char(' ')),'bb') -> list("a"," ")
  // @tst ifnull(list("a",""),to_char("c")) -> list("a","c");; ifnull(list('a',''),to_char("c")) -> list("a","c")
  // @tst ifnull(null,1) -> 1;; ifnull(null,null) -> {n 'long'};; ifnull(1,null) -> 1
  // @tst isnull({n 'float'},'a') -> Exc;; isnull(2,list(1,null)) -> Exc;; isnull(list(list(1)),2) -> Exc
  if[(::)~first x; if[2=count x 1;:y^x 2]; y:$[1=x[1;0];string y;y]; x:$[0=x[1;0];string;::]x 2]; / char/char vector
  if[-10=type x;x,:()]; if[-10=type y;y,:()];
  if[all .qsql.t.tsC in t:.qsql.t.qtypesMin .qsql.t.type each (x;y); x:.qsql.ff.strv x; y:.qsql.ff.strv y]; / convert sym -> str
  if[(not all t in .qsql.t.tsC)&any .qsql.t.tsC in t;'"Exc"];
  if[10=abs type first x; if[10=type x;:$[count x;x;y]]; i:where 0=count each x; :@[x;i;:;$[10=type y;count[i]#enlist y;y i]]];
  :y^x;
 };

.qsql.f.is_null:{
  // Returns true if a value is null, false otherwise. Example: val is null, val is not null
  // @t full All
  // @d n -> n
  // @i null
  if[10=abs type first x;'"Exc"]; / ignore strings
  null x};

.qsql.f.in_:{
  // Check that arg1 is in arg2. Example: in_(val,list(1,2)), sym in ('a','b'), sym in (select distinct sym from trade)
  // @t full All All
  // @d n m -> n
  if[(::)~first x; :(x 2)in y]; / char/char vector
  t:.qsql.t.qtypes .qsql.t.type each (x;y);
  if[any t in `C`Cc; if[not all t in `C`Cc`S`s; '"Exc"]; x:.qsql.ff.strv x; if[10=type y:.qsql.ff.strv y; y:enlist y]; :x in y];
  x in y};

.qsql.f.initcap:{
  // The scalar function INITCAP returns the result of the argument character expression after converting the first character to uppercase and the subsequent characters to lowercase. Example: initcap(str)
  // @t full STR
  // @d n -> n
  // @tst initcap("abC") -> "Abc";; initcap('abC') -> 'Abc';; initcap(list("abC","")) -> list("Abc","");; initcap(list('abC','')) -> list('Abc','')
  // @tst initcap(null) -> "";; initcap() -> Exc;; initcap("a","b") -> Exc;; initcap(1) -> Exc
  .qsql.ff.str1[{$[count x;@[x;0;upper];x]}] lower x};

.qsql.f.insert:{[s;st;l;s2]
  // The scalar function INSERT returns a character string arg1 where arg3 chars were deleted starting at arg2 and string arg4 was inserted instead. Example:  insert(str,start,len,str2)
  // @t full Str num num C.s
  // @d n 1 1 1 -> n
  // @tst insert("aaa",2,1,"bb") -> "abba";; insert('aaa',2,1,"bb") -> 'abba';; insert("aaa",2,1,'bb') -> "abba";; insert('aaa',2,1,'bb') -> 'abba'
  // @tst insert("aaa",null,1,"bb") -> "";; insert("aaa",1,null,"bb") -> "";; insert(list("aaa"),null,1,"bb") -> list("");; insert(list("aaa"),1,null,"bb") -> list("")
  // @tst insert('aaa',null,1,"bb") -> '';; insert(list('aaa'),null,1,"bb") -> list('')
  // @tst insert("aa",list(1,2),1,"aa") -> Exc;; insert("aa",1,list(1,2),"aa") -> Exc;; insert("aa",1,1,list("aa")) -> Exc;; insert("aa",1,2) -> Exc;; insert("aa",1,2,"aa","aa") -> Exc
  // @tst insert(list(list('a')),1,2,"aa") -> Exc
  if[any null (st;l); :.qsql.ff.str1[{""};s]];
  .qsql.ff.str1[{[s;st;l;s2] (st#s),s2,(st+l)_s}[;st-1;l;.qsql.ff.strv s2];s]};

.qsql.f.instr:{[s1;s2;p;c]
  // The scalar function INSTR searches for arg2 in arg1 at an optional position in arg3 for the first or optional arg4 occurence.
  // The position (with respect to the start of string corresponding to the first argument) is returned if a search is successful. Zero is returned if no match can be found. Example: instr(str1,str2,pos,cnt)
  // @opt (();();1;1)
  // @t full Str C.s num num
  // @d n 1 1 1 -> n
  // @tst instr("abcaabc","bc") -> 2;; instr("abcaabc","bbc") -> 0;; instr("abcaabc","bc",1) -> 2;; instr("abcaabc","bc",2) -> 2;; instr("abcaabc","bc",3) -> 6;;
  // @tst instr("abcaabc","bc",1,2) -> 6;; instr("abcaabc","bc",1,3) -> 0;; instr("abcaabc",'bc') -> 2;; instr('abcaabc','bc') -> 2;; instr("abcaabc","bc") -> 2
  // @tst instr(list("abcaabc","aabc"),'bc') -> list(2,3);; instr(list('abcaabc','aabc'),'bc') -> list(2,3)
  // @tst instr("aa",null) -> 1;; instr(null,"aa") -> 0;; instr("aa","bb",null) -> {n 'long'};; instr("aa","bb",1,null) -> {n 'long'}
  // @tst instr("aa") -> Exc;; instr("aa","bb",1,1,1) -> Exc;; instr(1,"aa") -> Exc;; instr("aa",2) -> Exc;; intsr("aa","bb",'a') -> Exc
  .qsql.ff.instr[s1;s2;p;c]};
.qsql.ff.instr:{[s1;s2;p;c]
  s1:.qsql.ff.strv s1; s2:.qsql.ff.strv s2;
  if[0=count s2;:1]; if[any null (p;c); :0N];
  f:{[s1;s2;p;c] 0^(pp where p<=pp:1+ss[s1;s2])c-1}[;s2;p;c]; $[type s1;f s1;f each s1]};

.qsql.f.last_day:{
  // The scalar function LAST_DAY returns the date corresponding to the last day of the month containing the argument date. Example: last_day(date)
  // @t full DATE
  // @d n -> n
  // @tst last_day({d '2020.05.10'}) -> {d '2020.05.31'};; last_day(list({ts '2020.05.10D10'})) -> list({d '2020.05.31'});; last_day(list(list({ts '2020.05.10D'}))) -> list(list({d '2020.05.31'}))
  // @tst last_day(null) -> {n 'date'};; last_day() -> Exc;; last_day({d '2010.10.10'},{d '2010.10.10'}) -> Exc;; last_day(1) -> Exc
  -1+"d"$1+`month$"d"$x};

.qsql.f.lower:.qsql.f.lcase:{
  // The scalar function LCASE/LOWER returns the result of the argument character expression after converting all the characters to lowercase. Example: lower(str)
  // @tpp {$[23 in x;23;y]}
  // @t full STR.a.A
  // @d n -> n
  // @tst lower("aB") -> "ab";; lcase(list("aB")) -> list("ab");; lcase(list(list("aB"))) -> Exc
  // @tst lower('aB') -> 'ab';; lcase(list('aB')) -> list('ab');; lcase(list(list('aB'))) -> list(list('ab'))
  // @tst lower(to_char('A')) -> to_char('a');; lower(list(to_char('A'))) -> list(to_char('a'))
  // @tst lower(null) -> ""
  // @tst lower(1) -> Exc;; lower("A","B") -> Exc;; lower() -> Exc
 lower $[(::)~first x;x 2;x]};

.qsql.f.least:{
  // The scalar function LEAST returns the lowest value among the values of the given expressions. Example: least(e1,e2,e3)
  // @t .qsql.c.least NUM NUM ...
  // @d n n -> n
  // @tst least(1,2) -> 1;; least(1,list(0,2)) -> list(0,1);; least(list(1,3),list(2,2)) -> list(1,2)
  // @tst least(1,2,3,list(0,1)) -> list(0,1)
  // @tst least(null,1,2,3) -> {n 'long'};; least(null,null,null) -> {n 'long'}
  // @tst least(1) -> Exc;; least(1,"a") -> Exc;; least(list(1),2,3,list(1,2,3)) -> Exc
  1};

.qsql.f.left:{
  // The scalar function LEFT returns the leftmost count of characters of arg1. Example: left(str,num)
  // @t full Str num
  // @d n 1 -> n
  // @tst left("a",2) -> "a";; left('abc',2) -> 'ab';; left(list("abc"),2) -> list("ab");; left(list('a'),3) -> list('a')
  // @tst left(null,2) -> "";; left(list(null,"abc"),2) -> list("","ab");; left("ab",null) -> "";; left(list('ab'),null) -> list('');; left(null,null) -> ""
  // @tst left("ab") -> Exc;; left("ab",1,2) -> Exc;; left(1,1) -> Exc;; left("ab","ab") -> Exc;;
  .qsql.ff.left[x;y]};
.qsql.ff.left:{if[null y; y:0]; .qsql.ff.str1[sublist[y];x]};

.qsql.f.octet_length:.qsql.f.length:.qsql.f.len:{
  // The scalar function LENGTH/LEN/OCTET_LENGTH returns the number of characters in arg1. Example: len(str)
  // @t full Str
  // @d n -> n
  // @tst len("abc") -> 3;; length('') -> 0;; len(list("ab")) -> list(2);; len(list('abc')) -> list(3)
  // @tst len(null) -> 0;; len() -> Exc;; len(1) -> Exc;; len("ab",1) -> Exc
  $[type x:.qsql.ff.strv x;count x;count each x]};

.qsql.f.list:{[i;l]
  // Return arguments as a list/array. There must be at least 1 non null argument. If there is one arg - a table with 1 column, return its column. Example: list(1,2), list(tbl)
  // @t .qsql.c.list All ...
  // @d m -> m
  // @tst list(1) -> Q enlist 1;; list(1,2) -> Q 1 2;; list("xx") -> Q enlist "xx";; list('z') -> Q enlist `z;; list("xx","yy") -> Q ("xx";"yy");; list('a','b') -> Q `a`b
  // @tst list(1,null) -> Q 1 0N;; list(null,'a') -> Q ``a;; list("aa",null) -> Q ("aa";"")
  // @tst list('ab',"ab") -> Q ("ab";"ab");; list(list('aa','bb'),list("aa","bb")) -> Q (("aa";"bb");("aa";"bb"))
  // @tst list(to_char('a'),to_char('b')) -> Q "ab";; type(list(to_char('a'),to_char('b'))) -> "char[]";; list(list(to_char('a'),to_char('b'))) -> Exc
  // @tst list(list(1,2),list(3,4)) -> Q (1 2;3 4);; list(list(1.0,2.0),null,list(3.0,4.0)) -> Q (1 2f;"f"$();3 4f);; list(list('a','b'),null) -> Q (`a`b;`$())
  // @tst list('aa',"bb") -> Q ("aa";"bb");; list("aa",null,'bb') -> Q ("aa";"";"bb")
  // @tst list() -> Exc;; list(null) -> Exc;; list(null,null) -> Exc;; list(1,2.2) -> Exc;; list("a",null,2) -> Exc;; list(list("a")) -> Exc
  / c.list takes care of the logic
  };

.qsql.f.locate:{
  // The scalar function LOCATE/POSITION returns the location of the first occurrence of arg1 in arg2, an optional start position can be provided in arg3. Example: locate(str1,str2,num), POSITION(str1 IN str2)
  // @opt (();();1)
  // @t full C.s Str num
  // @d n 1 1 -> n
  // @tst position("bc" in "abcaabc") -> 2;; position("bbc" in "abcaabc") -> 0;; locate("bc","abcaabc",1) -> 2;; locate("bc","abcaabc",2) -> 2;; locate("bc","abcaabc",3) -> 6;;
  // @tst position('bc' in "abcaabc") -> 2;; position('bc' in 'abcaabc') -> 2;; position("bc" in "abcaabc") -> 2
  // @tst position('bc' in list("abcaabc","aabc")) -> list(2,3);; position('bc' in list('abcaabc','aabc')) -> list(2,3)
  // @tst position(null in "aa") -> 1;; position("aa" in null) -> 0;; locate("bb","aa",null) -> {n 'long'}
  // @tst locate("aa") -> Exc;; locate("aa","bb",1,1) -> Exc;; locate("aa",1) -> Exc;; locate(2,"aa") -> Exc;; locate("aa","bb",'a') -> Exc
  .qsql.ff.instr[y;x;z;1]};

.qsql.f.localtime:{
  // The scalar function LOCALTIME returns current time as TIME value. Example: localtime()
  // @i {.z.T}
  // @t full
  // @d 1 -> 1
  .z.T};

.qsql.f.localtimestamp:{
  // The scalar function LOCALTIMESTAMP returns current date and time as TIMESTAMP value. Example: localtimestamp()
  // @i {.z.P}
  // @t full
  // @d 1 -> 1
  .z.P};

.qsql.f.log:{
  // The scalar function LOG returns the natural logarithm of arg. Example: log(num)
  // @i log
  // @t full NUM
  // @d n -> n
  // @tst log(0.5) -> -0.6931471805599453;; log(list(0.5)) -> list(-0.6931471805599453);; log(list(list(0.5))) -> list(list(-0.6931471805599453))
  // @tst log(null) -> {n 'float'};; log() -> Exc;; log('a') -> Exc;; log(1,2) -> Exc
  log x};

.qsql.f.log10:{
  // The scalar function LOG10 returns the base 10 logarithm of arg. Example: log10(num)
  // @t full NUM
  // @d n -> n
  // @tst log10(100) -> 2.0;; log10(list(100.0)) -> list(2.0);; log10(list(list(100))) -> list(list(2.0))
  // @tst log10(null) -> {n 'float'};; log10() -> Exc;; log10('a') -> Exc;; log10(1,2) -> Exc
  log[x]%log 10};

.qsql.f.lpad:{
  // The scalar function LPAD pads the character string corresponding to the first argument on the left with the character string corresponding to the third argument so that after the padding, the length of the result is length. Example: lpad(str,num,pad)
  // @t full Str num s.C
  // @d n 1 1 -> n
  // @tst lpad("ab",5,"*") -> "***ab";; lpad('abc',2,'-') -> 'ab';; lpad(list("xyzx","a","klj"),3,"-+") -> list("xyz","-+a","klj")
  // @tst lpad(null,5,"*") -> "*****";; lpad("ab",null,"a") -> "";; lpad("ab",5,null) -> ""
  // @tst lpad("ab",5) -> Exc;; lpad("ab",5,"ab","ab") -> Exc;; lpad(1,5,"a") -> Exc;; lpad("a","a","a") -> Exc;; lpad("a",5,5) -> Exc
  z:.qsql.ff.strv z;
  if[(0=count z)|null y; y:0];
  .qsql.ff.str1[{$[y>count x;((y-count x)#z),x;y sublist x]}[;y;z];x]};

.qsql.f.ltrim:{
  // The scalar function LTRIM removes all the leading characters in arg1 that are in optional arg2 (" " is the default value). Example: ltrim(str,chars)
  // @opt (();()," ")
  // @t full Str C.s
  // @d n 1 -> n
  // @tst ltrim("  aa") -> "aa";; ltrim('*aa',"*") -> 'aa';; ltrim("bb") -> "bb";; ltrim("0123xxx","0123") -> "xxx";; ltrim(list('*+*jj'),'*+') -> list('jj')
  // @tst ltrim(null) -> "";; ltrim("  aa",null) -> "  aa";; ltrim(null,"aa") -> "";; ltrim(null,null) -> ""
  // @tst ltrim(1) -> Exc;; ltrim("aa",1) -> Exc;; ltrim("aa","bb","cc") -> Exc
  .qsql.ff.str1[{$[0=count y;x;all y=" ";ltrim x;x where not &\[x in y]]}[;.qsql.ff.strv y];x]};

.qsql.f.minute:{
  // The scalar function MINUTE returns the minute value in the argument as a short integer in the range of 0 - 59. Example: minute(time)
  // @i `uu$
  // @t full TIME
  // @d n -> n
  // @tst minute({t '11:10'}) -> Q 10i;; minute(list({ts '2010.10.10D10:11'},{ts '2010.10.10D11:12'})) -> Q 11 12i;; minute(list(list(cast(601 as qminute)))) -> list(list(cast(1 as int)))
  // @tst minute(cast(36600 as qsecond)) -> Q 10i;; minute(cast(3660000000000 as timespan)) -> Q 1i
  // @tst minute(null) -> Q 0Ni;; minute() -> Exc;; minute({t '11:10'},{t '11:12'}) -> Exc;; minute('a') -> Exc
  `uu$x};

.qsql.f.mod:{
  // The scalar function MOD returns the remainder of arg1 divided by arg2. Example: mod(num1,num2)
  // @i mod
  // @t full Num Num
  // @d n n -> n
  // @tst mod(10,3) -> 1;; mod(list(11),3) -> list(2);; mod(10,list(3,4)) -> list(1,2);; mod(list(10,11),list(3,4)) -> list(1,3)
  // @tst mod(null,1) -> {n 'long'};; mod(1,null) -> {n 'long'};; mod(null,null) -> {n 'long'}
  // @tst mod(1) -> Exc;; mod(1,2,3) -> Exc;; mod("a",1) -> Exc;; mod(1,"a") -> Exc
  x mod y};

.qsql.f.monthname:{
  // Returns a character string containing the name of the month. Example: monthname(date)
  // @t full Date
  // @d n -> n
  // @tst monthname({d '2010.10.10'}) -> "oct";; monthname(list({ts '2010.03.10'})) -> list("mar")
  // @tst monthname(null) -> "";; monthname() -> Exc;; monthname({d '2010.10.10'},{d '2010.10.10'}) -> Exc;; monthname(1) -> Exc
  (0N 3#"janfebmaraprmayjunjulaugsepoctnovdec")@-1+`mm$x};

.qsql.f.month:{
  // The scalar function MONTH returns the month in the year specified by the argument as a short integer value in the range of 1 - 12. Example: month(date)
  // @i `mm$
  // @t full DATE
  // @d n -> n
  // @tst month({d '2020.05.05'}) -> Q 5i;; month(list({d '2020.03.04'})) -> Q enlist 3i;; month(list(list({ts '2020.06.03D'}))) -> list(list(cast(6 as integer)));; month(cast({d '2020.11.05'} as qmonth)) -> Q 11i
  // @tst month(null) -> {n 'integer'};; month() -> Exc;; month({d '2020.05.04'},{d '2020.05.04'}) -> Exc;; month(1) -> Exc
  `mm$x};

.qsql.f.month_between:{
  // The scalar function MONTHS_BETWEEN computes the number of months between two date values corresponding to the first and second arguments. Example: month_between(date1,date2)
  // @t full Date Date
  // @d n n -> n
  // @tst month_between({d '2010.10.10'},{d '2010.08.01'}) ->2;; month_between(list({ts '2010.10.10D10:10'}),{ts '2010.12.08D11'}) -> list(-2)
  // @tst month_between({d '2010.10.10'},list({d '2010.08.01'})) -> list(2);; month_between(list({d '2010.08.01'},{d '2011.02.01'}),list({ts '2010.10.10D10:10'},{ts '2010.12.08D11'})) -> list(-2,2)
  // @tst month_between({d '2010.08.01'},null) -> {n 'long'};; month_between(null,{d '2010.08.01'}) -> {n 'long'};; month_between(null,null) -> {n 'long'}
  // @tst month_between({d '2010.08.01'}) ->Exc;; month_between({d '2010.08.01'},{d '2010.08.01'},{d '2010.08.01'}) -> Exc;; month_between(1,{d '2010.08.01'}) -> Exc;; month_between({d '2010.08.01'},1) -> Exc
  "j"$("m"$x)-"m"$y};

.qsql.f.next_day:{
  // The scalar function NEXT_DAY returns the minimum date that is greater than the date corresponding to the first argument for which the day of the week is same as that specified by the second argument. Example: next_day(date,str)
  // @t full Date C.s.j.i
  // @d n 1 -> n
  // @tst next_day({d '2020.05.20'},"thu") -> {d '2020.05.21'};; next_day(list({ts '2020.05.20D10'}),'wed') -> list({d '2020.05.27'})
  // @tst next_day({d '2020.05.20'},3) -> {d '2020.05.27'};; next_day({d '2020.05.20'},7) -> {d '2020.05.24'}
  // @tst next_day(null,1) -> {n 'date'};; next_day(null,null) -> {n 'date'};; next_day({d '2010.10.10'},null) -> {n 'date'}
  // @tst next_day({d '2010.10.10'}) -> Exc;; next_day({d '2010.10.10'},1,1) -> Exc;; next_day(1,1) -> Exc
  m:`$0N 3#"sunmontuewedthufrisat";
  v:$[10=type y:.qsql.ff.strv y;`$lower y;y];
  v:$[-11=type v;$[v in m;m?v;0N];v];
  :d+v+(0 7)0>=v:v-(-1+d:"d"$x) mod 7;
 };

.qsql.f.nullif:{
  // The NULLIF scalar function returns a null value for arg1 if it is equal to arg2. Example:  nullif(v1,v2)
  // @t .qsql.c.nullif All All
  // @d n n -> n
  // @tst nullif(1,2) -> 1;; nullif("aa","aa") -> "";; nullif("aa","aaa") -> "aa";; nullif('ab','cd') -> 'ab';; nullif('ab',"ab") -> '';; nullif("ab",'cd') -> "ab";; nullif("ab",'ab') -> ""
  // @tst nullif(to_char('a'),to_char('b')) -> to_char('a');; nullif(to_char('a'),to_char('a')) -> to_char(" ");; nullif(to_char('a'),"a") -> to_char(" ");; nullif(to_char('a'),'a') -> to_char(" ")
  // @tst nullif(to_char('a'),"b") -> to_char("a");; nullif(to_char('a'),'b') -> to_char("a");; nullif("a",to_char('a')) -> "";; nullif('a',to_char('a')) -> '';; nullif("aa",to_char('a')) -> "aa";;
  // @tst nullif(list(1,2),2) -> list(1,{n 'long'});; nullif(list("aa","bb"),"bb") -> list("aa","");; nullif(list('aa','bb'),'bb') -> list('aa','');; nullif(list('aa','bb'),"bb") -> list('aa','')
  // @tst nullif(list("aa","bb"),'bb') -> list("aa","");; nullif(list(to_char('a'),to_char('b')),to_char('b')) -> list(to_char('a'),to_char(' '));; nullif(list(to_char('a'),to_char('b')),"b") -> list(to_char('a'),to_char(' '))
  // @tst nullif(list(to_char('a'),to_char('b')),'b') -> list(to_char('a'),to_char(' '));; nullif(list("a","b"),to_char('b')) -> list("a","");; nullif(list('a','b'),to_char('b')) -> list('a','')
  // @tst nullif(1,list(2,1)) -> list(1,{n 'long'});; nullif("aa",list("bb","aa")) -> list("aa","");; nullif('bb',list('aa','bb')) -> list('bb','');; nullif("bb",list('aa','bb')) -> list("bb","")
  // @tst nullif('bb',list("aa","bb")) -> list('bb','');; nullif(to_char('b'),list(to_char('a'),to_char('b'))) -> list(to_char('b'),to_char(' '));; nullif("b",list(to_char('a'),to_char('b'))) -> list("b","")
  // @tst nullif('b',list(to_char('a'),to_char('b'))) -> list('b','');; nullif(to_char('b'),list("a","b")) -> list(to_char('b'),to_char(' '));; nullif(to_char('b'),list('a','b')) -> list(to_char('b'),to_char(' '))
  // @tst nullif(list(1,2),list(2,2)) -> list(1,{n 'long'});; nullif(list("aa","bb"),list("a","bb")) -> list("aa","");; nullif(list('aa','bb'),list('a','bb')) -> list('aa','');; nullif(list('aa','bb'),list("a","bb")) -> list('aa','')
  // @tst nullif(list("aa","bb"),list('a','bb')) -> list("aa","");; nullif(list(to_char('a'),to_char('b')),list(to_char('b'),to_char('b'))) -> list(to_char('a'),to_char(' '));; nullif(list(to_char('a'),to_char('b')),list("aa","b")) -> list(to_char('a'),to_char(' '))
  // @tst nullif(list(to_char('a'),to_char('b')),list('aa','b')) -> list(to_char('a'),to_char(' '));; nullif(list("a","b"),list(to_char('b'),to_char('b'))) -> list("a","");; nullif(list('a','b'),list(to_char('b'),to_char('b'))) -> list('a','')
  .qsql.t.qones .qsql.t.qtypesMap[.qsql.t.type x] 0<type .qsql.ff.xeq[x;y]};

.qsql.f.pi:{
  // The scalar function PI returns the constant value of pi as a floating point value. Example: pi()
  // @t full
  // @d 1 -> 1
  // @tst pi() -> 3.141592653589793;; pi(1) -> Exc
  4*atan 1};

.qsql.f.power:{
  // The scalar function POWER returns arg1 raised to the power of arg2. Example: power(num,num)
  // @i xexp
  // @t full Num Num
  // @d n n -> n
  // @tst power(2,2) -> 4.0;; power(2.0,list(2.0,3.0)) -> list(4.0,8.0);; power(list(2.0,3.0),2.0) -> list(4.0,9.0);; power(list(2.0,3.0),list(2.0,3.0)) -> list(4.0,27.0)
  // @tst power(null,1) -> {n 'float'};; power(1,null) -> {n 'float'};; power(null,null) -> {n 'float'}
  // @tst power(1) -> Exc;; power(1,2,3) -> Exc;; power("a",1) -> Exc;; power(1,'a') -> Exc;; power(list(1),list(1,2)) -> Exc;;
 x xexp y};

.qsql.f.prefix:{
  // The scalar function PREFIX returns the substring of a character string starting from the position specified by start position, and ending before the specified character. Example: prefix(str,num,ch)
  // @t full Str num C.s
  // @d n 1 1 -> n
  // @tst prefix("abcde",2,"d") -> "bc";; prefix('abcde',-1,'xx') -> 'abcde';; prefix("abcde",1,'xxe') -> "abcd";; prefix('abcde',10,'e') -> '';; prefix(list("abcde","bcdef"),2,"d") -> list("bc","c")
  // @tst prefix(list('abcde','bcdef'),2,'d') -> list('bc','c');; prefix(list("abcde","bcdef"),2,'d') -> list("bc","c");; prefix(list('abcde','bcdef'),2,"d") -> list('bc','c')
  // @tst prefix(null,1,"aa") -> "";; prefix("aa",null,"a") -> "";; prefix("aa",1,null) -> "";; prefix('aa',1,null) -> '';; prefix(null,null,null) -> ""
  // @tst prefix("aa",1) -> Exc;; prefix("aa",1,"bb","vv") -> Exc;; prefix(1,1,"aa") -> Exc;; prefix("aa","aa","aa") -> Exc;; prefix("aa",1,1) -> Exc
  z:.qsql.ff.strv z;
  if[null y; z:""];
  .qsql.ff.str1[{$[count z;(count[x]^first where x in z)#x:y _ x;""]}[;(1|y)-1;z];x]};

.qsql.f.quarter:{
  // The scalar function QUARTER returns the quarter in the year specified by the argument as a short integer value in the range of 1 - 4. Example: quarter(date)
  // @t full Date
  // @d n -> n
  // @tst quarter({d '2010.02.20'}) -> 1;; quarter(list({ts '2010.04.01D00'})) -> list(2);; quarter({d '2010.07.01'}) -> 3
  // @tst quarter(null) -> {n 'long'};; quarter() -> Exc;; quarter({d '2010.02.20'},{d '2010.02.20'}) -> Exc;; quarter(1) -> Exc
  1+(-1+`mm$x)div 3};

.qsql.f.radians:{
  // The scalar function RADIANS returns the number of radians in an angle specified in degrees by expression. Example: radians(num)
  // @t full NUM
  // @d n -> n
  // @tst radians(1) -> 0.017453292519943;; radians(list(1.0)) -> list(0.017453292519943);; radians(list(list(1))) -> list(list(0.017453292519943))
  // @tst radians() -> Exc;; radians(1,2) -> Exc;; radians('a') -> Exc;; radians(null) -> {n 'float'}
   x*0.017453292519943};

.qsql.f.rand:{
  // The scalar function RAND returns a randomly-generated number. Example: rand()
  // @t full
  // @d 1 -> 1
  // @tst type(rand()) -> "float";; rand() <> rand() -> true;; rand(1) -> Exc
  first 1?1.};

.qsql.f.repeat:{
  // The scalar function REPEAT returns a character string composed of arg1 repeated arg2 times. Example: repeat(str,num)
  // @t full Str num
  // @d n 1 -> n
  // @tst repeat("ab",3) -> "ababab";; repeat(list('ade'),2) -> list('adeade');; repeat(null,1) -> "";; repeat("aa",null) -> "";; repeat('a',null) -> '';; repeat(null,null) -> ""
  // @tst repeat("ab") -> Exc;; repeat("ab",1,1) -> Exc;; repeat(1,1) -> Exc;; repeat("ab","ab") -> Exc
  .qsql.ff.str1[{(count[x]*0|y)#x}[;y];x]};

.qsql.f.replace:{
  // The scalar function REPLACE replaces all occurrences of arg2 in arg1 with arg3. Example: replace(str1,str2,str3)
  // @t full Str C.s C.s
  // @d n 1 1 -> n
  // @tst replace("abcabcd","bc","xx") -> "axxaxxd";; replace("abc",'de','de') -> "abc";; replace('abcd',"bc",'xx') -> 'axxd'
  // @tst replace(list("abcd"),'bc',"xx") -> list("axxd");; replace(list('abcd'),"bc","xx") -> list('axxd')
  // @tst replace(null,"ab","ab") -> "";; replace("ab",null,"xx") -> "ab";; replace('ab','a',null) -> 'b';; replace("ab",null,null) -> "ab"
  if[0=count y:.qsql.ff.strv y; :x];
  .qsql.ff.str1[ssr[;.qsql.ff.strv y;.qsql.ff.strv z];x]};

.qsql.f.right:{
  // The scalar function RIGHT returns the rightmost count of characters of arg1. Example: right(str,num)
  // @t full Str num
  // @d n 1 -> n
  // @tst right("a",2) -> "a";; right('abc',2) -> 'bc';; right(list("abc"),2) -> list("bc");; right(list('a'),3) -> list('a')
  // @tst right(null,2) -> "";; right(list(null,"abc"),2) -> list("","bc");; right("ab",null) -> "";; right(list('ab'),null) -> list('');; right(null,null) -> ""
  // @tst right("ab") -> Exc;; right("ab",1,2) -> Exc;; right(1,1) -> Exc;; right("ab","ab") -> Exc;;
  .qsql.ff.left[x;neg y]};

.qsql.f.truncate:.qsql.f.round:{
  // The scalar function rounds arg1 to arg2 decimal places (negative means before the floating point). Example: round(num1,num2), truncate(num1,num2)
  // @t full NUM num
  // @d n 1 -> n
  // @tst round(1.2345,2) -> 1.23;; truncate(123.45,-2) -> 100.0;; round(list(10),3) -> list(10);; truncate(list(123),-2) -> list(100);; round(list(list(12.34)),1) -> list(list(12.3))
  // @tst truncate(12.34,0) -> 12.0;; truncate(null,2) -> {n 'long'};; truncate(1.2,null) -> {n 'float'};; truncate(null,null) -> {n 'long'}
  // @tst round(1) -> Exc;; round(1,2,3) -> Exc;; round(1,"a") -> Exc;; round("a",1) -> Exc
  (abs type x)$("j"$x*y)%y:10 xexp y};

.qsql.f.rpad:{
  // The scalar function RPAD pads the character string in arg1 on the right using an optional arg3 to the length in arg2. Example: rpad(str,num,strpad)
  // @t full Str num s.C
  // @d n 1 1 -> n
  // @tst rpad("ab",5,"*") -> "ab***";; rpad('abc',2,'-') -> 'bc';; rpad(list("xyzx","a","klj"),3,"-+") -> list("yzx","a-+","klj")
  // @tst rpad(null,5,"*") -> "*****";; rpad("ab",null,"a") -> "";; rpad("ab",5,null) -> ""
  // @tst rpad("ab",5) -> Exc;; rpad("ab",5,"ab","ab") -> Exc;; rpad(1,5,"a") -> Exc;; rpad("a","a","a") -> Exc;; rpad("a",5,5) -> Exc
  z:.qsql.ff.strv z;
  if[(0=count z)|null y; y:0];
  .qsql.ff.str1[{$[y>count x;x,(y-count x)#z;neg[y] sublist x]}[;y;z];x]};

.qsql.f.rtrim:{
  // The scalar function RTRIM removes all the trailing characters in arg1 that are in optional arg2 (" " is the default value). Example: rtrim(str,chars)
  // @opt (();()," ")
  // @t full Str C.s
  // @d n 1 -> n
  // @tst rtrim("aa  ") -> "aa";; rtrim('*aa*',"*") -> '*aa';; rtrim("bb") -> "bb";; rtrim("xxx0123","0123") -> "xxx";; rtrim(list('jj*+*'),'*+') -> list('jj')
  // @tst rtrim(null) -> "";; rtrim("aa  ",null) -> "aa  ";; rtrim(null,"aa") -> "";; rtrim(null,null) -> ""
  // @tst rtrim(1) -> Exc;; rtrim("aa",1) -> Exc;; rtrim("aa","bb","cc") -> Exc
  .qsql.ff.str1[{$[0=count y;x;all y=" ";rtrim x;x where reverse not &\[reverse x in y]]}[;.qsql.ff.strv y];x]};

.qsql.f.second:{
  // The scalar function SECOND returns the seconds in the argument as a short integer value in the range of 0 - 59. Example: second(time)
  // @i `ss$
  // @t full TIME
  // @d n -> n
  // @tst second({t '11:10:12'}) -> Q 12i;; second(list({ts '2010.10.10D10:11:12'},{ts '2010.10.10D11:12:13'})) -> Q 12 13i;; second(list(list(cast(36001 as qsecond)))) -> list(list(cast(1 as int)))
  // @tst second(cast(36602 as qsecond)) -> Q 2i;; second(cast(3665000000000 as timespan)) -> Q 5i
  // @tst second(null) -> Q 0Ni;; second() -> Exc;; second({t '11:10'},{t '11:12'}) -> Exc;; second('a') -> Exc
  `ss$x};

.qsql.f.sign:{
  // The scalar function SIGN returns 1 if expression is positive, -1 if expression is negative, or zero if it is zero. Example: sign(num)
  // @i signum
  // @t full NUM
  // @d n -> n
  // @tst sign(-1) -> Q -1i;; sign(list(10.1)) -> Q enlist 1i;; sign(list(list(0.0))) -> Q enlist enlist 0i
  // @tst sign(null) -> Q -1i;; sign() -> Exc;; sign(1,2) -> Exc;; sign("a") -> Exc
  signum x};

.qsql.f.sin:{
  // The scalar function SIN returns the sine of expression. Example: sin(num)
  // @i sin
  // @t full NUM
  // @d n -> n
  // @tst sin(0.5) -> 0.479425538604203;; sin(list(0.5)) -> list(0.479425538604203);; sin(list(list(0.5))) -> list(list(0.479425538604203))
  // @tst sin(null) -> {n 'float'};; sin() -> Exc;; sin('a') -> Exc;; sin(1,2) -> Exc
  sin x};

.qsql.ff.scode:"BFPVCGJKQSXZDTLMNR"!"c"$raze 4 8 2 1 2 1#'string 1+til 6;
.qsql.f.soundex:{
  // @t full Str
  // @d n -> n
  // @tst soundex("ammonium") -> "A555";; soundex('implementation') -> "I514";; soundex(list("Ashcroft")) -> list("A226")
  // @tst soundex(null) -> "";; soundex(1) -> Exc;; soundex() -> Exc;; soundex("aa","bb") -> Exc
  .qsql.ff.soundex x};
.qsql.ff.soundex:{
  f:{if[0=count x;:""];x0:(x:upper x)0;4#x0,$[m[x0]=first x:x where not " "=x:x where differ x:(m:.qsql.ff.scode)x;1_x;x],"000"};
  $[type x:.qsql.ff.strv x;f x;f each x]};

.qsql.f.space:{
  // The scalar function SPACE returns a character string consisting of count spaces. Example: space(num)
  // @t full Num
  // @d n -> n
  // @tst space(2) -> "  ";; space(list(0)) -> list("");; space(null) -> "";; space() -> Exc;; space(1,2) -> Exc;; space(1,2) -> Exc
  $[0>type x;(0^x)#" ";(0^x)#\:" "]};

.qsql.f.sqrt:{
  // The scalar function SQRT returns the square root of the expression. Example: sqrt(num)
  // @i sqrt
  // @t full NUM
  // @d n -> n
  // @tst sqrt(4) -> 2.0;; sqrt(list(9.0)) -> list(3.0);; sqrt(list(list(0.0))) -> list(list(0.0))
  // @tst sqrt(null) -> {n 'float'};; sqrt() -> Exc;; sqrt(1,2) -> Exc;; sqrt("a") -> Exc
  sqrt x};

.qsql.f.substring:{
  // The scalar function SUBSTRING returns the substring of the character string corresponding to the arg1 starting at arg2 til the end of arg1 or an optional number of chars in arg3. substring(str,num,num)
  // @opt (();();0W)
  // @t full Str num num
  // @d n 1 1 -> n
  // @tst substring("abc",1,2) -> "ab";; substring("abc",1,0) -> "";; substring("abc",2,3) -> "bc";; substring("abc",4,2) -> "";; substring('abc',2,1) -> 'b';; substring(list("abc"),2) -> list("bc")
  // @tst substring(null,1,1) -> "";; substring("abc",null) -> "";; substring("abc",1,null) -> "";; substring(null,null,null) -> ""
  // @tst substring("ab") -> Exc;; substring("ab",1,2,3) -> Exc;; substring(1,2) -> Exc;; substring("ab","ab") -> Exc;; substring("an",1,"a") -> Exc
  if[null[z]|null y; z:0];
  .qsql.ff.str1[{$[z;(y;z)sublist x;""]}[;0|y-1;0|z];x]};

.qsql.f.suffix:{
  // The scalar function SUFFIX returns the substring of arg1 starting after the position specified by arg2 and character in arg3 til the end of arg1. Example: suffix(str,num,char)
  // @t full Str num C.s
  // @d n 1 1 -> n
  // @tst suffix("abcde",2,"ec") -> "de";; suffix("abcde",3,'a') -> "";; suffix('abcde',6,"d") -> '';; suffix(list("abcde"),1,"xd") -> list("e")
  // @tst suffix(null,1,"a") -> "";; suffix("abc",null,"ab") -> "";; suffix("abc",1,null) -> "";; suffix(null,null,null) -> ""
  // @tst suffix("ab",1) -> Exc;; suffix("ab",1,"ab",1) -> Exc;; suffix(1,1,"ab") -> Exc;; suffix("ab","ab","ab") -> Exc;; suffix("ab",1,1) -> Exc
  z:.qsql.ff.strv z;
  if[null y; z:""];
  .qsql.ff.str1[{$[count z;(1+count[x]^first where x in z)_x:y _ x;""]}[;0|y-1;z];x]};

.qsql.f.tan:{
  // The scalar function TAN returns the tangent of expression. Example: tan(x)
  // @i tan
  // @t full NUM
  // @d n -> n
  // @tst tan(0.5) -> 0.5463024898437905;; tan(list(0.5)) -> list(0.5463024898437905);; tan(list(list(0.5))) -> list(list(0.5463024898437905))
  // @tst tan(null) -> {n 'float'};; tan() -> Exc;; tan('a') -> Exc;; tan(1,2) -> Exc
  tan x};

.qsql.f.timestampadd:{
  // Returns the timestamp calculated by adding arg2 intervals of type arg1 (month,quarter,year,week,day,hour,minute,second,frac) to arg3. Example: timestampadd(sym,num,date)
  // @catch
  // @tpp {[a;y] t:$[7=t:first .qsql.t.qtypesMap a:last a;6;t in 2 3;1;t]; .qsql.t.qtypesMap[t] .qsql.t.qtypesMap[a]?a}
  // @t full s.C num DATETIME
  // @d 1 1 n -> n
  // @tst timestampadd('month',2,{d '2010.03.12'}) -> {d '2010.05.12'};; timestampadd('month',2,cast({d '2020.03.12'} as qmonth)) -> {d '2020.05.01'};; timestampadd('month',1,{ts '2020.01.30D10'}) -> {ts '2020.02.29D10'}
  // @tst timestampadd('month',2,{t '10:10'}) -> Exc;; timestampadd('month',2,list({d '2010.03.12'})) -> list({d '2010.05.12'});; timestampadd('month',1,list(list({ts '2020.01.30D10'}))) -> list(list({ts '2020.02.29D10'}))
  // @tst timestampadd("quarter",2,{d '2010.03.12'}) -> {d '2010.09.12'};; timestampadd("quarter",2,cast({d '2020.03.12'} as qmonth)) -> {d '2020.09.01'};; timestampadd("quarter",1,{ts '2019.11.30D10'}) -> {ts '2020.02.29D10'}
  // @tst timestampadd('year',2,{d '2010.03.12'}) -> {d '2012.03.12'};; timestampadd('year',2,cast({d '2020.03.12'} as qmonth)) -> {d '2022.03.01'};; timestampadd('year',1,{ts '2020.02.29D10'}) -> {ts '2021.02.28D10'}
  // @tst
  y:signum[y]*floor abs y; zt:first .qsql.t.qtypesMap .qsql.t.type z;
  if[not null i:.qsql.t.dInt t:.qsql.t.normType x;
    if[not zt in .qsql.t.qtypes?`d`m`p; 'string[x]," can't be used with time value"];
    :.qsql.ff.addMonth[z;y*i];
  ];
  if[null i:.qsql.t.tInt t;'"bad interval: ",string x];
  if[(j:t in `week`day)&zt in .qsql.t.qtypes?`t`v`u; 'string[x]," can't be used with time value"];
  c:$[zt in .qsql.t.qtypes?`d`m;"d"$;zt in .qsql.t.qtypes?`t`v`u;"t"$;::];
  :c z+i*y;
 };

.qsql.f.timestampdiff:{
  // Returns an integer representing the number of arg1 (month,quarter,year,day,week,hour,minute,second,frac) by which arg3 is greater than arg2. Example: timestampdiff('month',date1,date2)
  // @catch
  // @tpp {[a;y] .qsql.t.qtypesMap[13] max(.qsql.t.qtypesMap a)?'a}
  // @t full s.C DATETIME DATETIME
  // @d 1 n n -> n
  // @tst timestampdiff('year',{d '2010.10.10'}, {d '2012.10.10'}) -> 2;; timestampdiff("month",{d '2010.10.10'}, list({ts '2010.12.10D0'},{ts '2010.11.10D'})) -> list(2,1)
  // @tst timestampdiff('quarter',list({d '2010.01.10'},{d '2010.10.10'}), {ts '2010.10.10D0'}) -> list(3,0);; timestampdiff('day',list({d '2010.10.10'},{d '2010.10.10'}), list({ts '2010.10.20D0'},{ts '2010.10.22D0'})) -> list(10,12)
  // @tst timestampdiff('hour',list(list({t '10:10'})),current_date) -> list(list(-10))
  v:{$[.qsql.t.qtype[first first x]in .qsql.t.qtypes?`t`v`u;.z.D+x;"p"$x]}each (z;y);
  if[not null i:.qsql.t.dInt t:.qsql.t.normType x; :signum[v]*floor abs v:(-)/[(`month$v)%i]];
  if[null i:.qsql.t.tInt t;'"bad interval: ",string x];
  :signum[v]*floor abs v:(-)/[v]%i;
 };

.qsql.f.translate:{
  // The scalar function TRANSLATE translates each character in arg1 that is in arg2 to the corresponding character in arg3. Example: translate(str,strFrom,strTo)
  // @t full Str C.s C.s
  // @d n 1 1 -> n
  // @tst translate("abc","ac","de") -> "dbe";; translate(list("abc"),'ac',"d") -> list("dbc");; translate(list(list("abc")),'ac',"d") -> Exc
  // @tst translate('abc','a',"de") -> 'dbc';; translate(list('abc'),'','de') -> list('abc');; translate(list(list('abc')),'','de') -> Exc
  // @tst translate("abc",null,"de") -> "abc";; translate('abc',null,"de") -> 'abc';; translate("abc","de",null) -> "abc";; translate('abc',"de",null) -> 'abc'
  // @tst translate("abc",null,null) -> "abc";; translate('abc',null,null) -> 'abc';; translate(null,null,null) -> ""
  // @tst translate(1,"a","b") -> Exc;; translate("aa",1,"bb") -> Exc;; translate("aa","bb",1) -> Exc;; translate("aa","bb") -> Exc;; translate("aa","bb","cc","dd") -> Exc
  .qsql.ff.str1[{c:count[x]&count y;z^((c#x)!c#y)z} . .qsql.ff.strv each (y;z);x]};

.qsql.f.trim:{
  // The function TRIM removes both leading and trailing characters from the arg1 that are in the optional arg2 (" " by default). Example: trim(str,chars)
  // @opt (();"")
  // @t full Str C.s
  // @d n 1 -> n
  // @tst trim(" abc ") -> "abc";; trim(list(" abc ")) -> list("abc");; trim(list(list(" abc "))) -> Exc
  // @tst trim(" abc "," ac") -> "b";; trim(list(" abc ")," ac") -> list("b")
  // @tst trim('abc') -> 'abc';; trim('abc','ca') -> 'b';;  trim(list('abc'),'ca') -> list('b');; trim(list(list('abc')),'ca') -> Exc
  // @tst trim(" aba ",null) -> "aba";; trim(null,"aaa") -> "";; trim(null,'aaa') -> "";; trim('ab',null) -> 'ab';; trim(null) -> "";; trim(null,null) -> ""
  // @tst trim(1,"aa") -> Exc;; trim(1) -> Exc;; trim("aaa",1) -> Exc;; trim() -> Exc;; trim("aa","bb","cc") -> Exc
  .qsql.ff.str1[{$[count x;y where not &\[(y:reverse y where not &\[(y:reverse y) in x])in x];trim y]} .qsql.ff.strv y;x]};

.qsql.f.to_char:{
  // Convert a sym/string to char by taking the first element. Example: to_char(str)
  // @tpp {(10 30!10 23)y}
  // @t full s.S.C.Cc
  // @d n -> n
  // @tst to_char('aa') -> Q "a";; to_char("aa") -> Q "a";; to_char(list('aa','bb')) -> Q "ab";; to_char(list("aa","bb")) -> Q "ab"
  // @tst type(to_char('a')) -> "char";; type(to_char("aa")) -> "char";; type(to_char(list('aa','bb'))) -> "char[]";; type(to_char(list("aa","bb"))) -> "char[]"
  // @tst to_char(null) -> Q " ";; to_char(1) -> Exc;; to_char(list(list('a'))) -> Exc;; to_char('a','b') -> Exc
  if[11=abs type x;x:string x]; $[type x;first x;x[;0]]};

.qsql.f.type:{
  // Returns a string with type description. Example: type(expr)
  // @t .qsql.c.typefn ALL
  // @d n -> 1
  // @tst type(10) -> "long";; type("aaa") -> "string";; type(to_char('a')) -> "char";; type(to_char(list('a'))) -> "char[]";; type(list("aa")) -> "string[]";;
  // @tst type(list(1.0)) -> "float[]";; type(list(list(1.2))) -> "float[][]";; type(null) -> "null";; type(1,2) -> Exc
  ""};

.qsql.f.upper:.qsql.f.ucase:{
  // The scalar function UCASE/UPPER returns the result of the argument character expression after converting all the characters to uppercase. Example: upper(str), ucase(str)
  // @tpp {$[23 in x;23;y]}
  // @t full STR.a.A
  // @d n -> n
  // @tst upper("aB") -> "AB";; ucase(list("aB")) -> list("AB");; ucase(list(list("aB"))) -> Exc
  // @tst upper('aB') -> 'AB';; ucase(list('aB')) -> list('AB');; ucase(list(list('aB'))) -> list(list('AB'))
  // @tst upper(to_char('a')) -> to_char('A');; upper(list(to_char('a'))) -> list(to_char('A'))
  // @tst upper(null) -> ""
  // @tst upper(1) -> Exc;; ucase("A","B") -> Exc;; ucase() -> Exc
 upper $[(::)~first x;x 2;x]};

.qsql.f.week:{
  // The scalar function WEEK returns the week of the year as a short integer value (range 1 - 53). Example: week(date)
  // @t full DATE
  // @d n -> n
  // @tst week({d '2020.04.10'}) -> 15;; week(list({d '2020.04.10'})) -> list(15);; week(list(list({d '2020.04.10'}))) -> list(list(15))
  // @tst week({ts '2020.04.17D10'}) -> 16;; week(list({ts '2020.04.17D10'})) -> list(16);; week(list(list({ts '2020.04.17D10'}))) -> list(list(16))
  // @tst week(null) -> {n 'long'};; week(cast({d '2020.04.17'} as qmonth)) -> 14;; week({d '2020.01.05'}) -> 1
  // @tst week() -> Exc;; week({ts '2020.04.17D10'},{ts '2020.04.17D10'}) -> Exc;; week(1) -> Exc
  1+(-1+.qsql.ff.dayofyear[x]+d-`week$d:"d"$(1+"m"$x)-`mm$x)div 7};

.qsql.f.year:{
  // The scalar function YEAR returns the year as a short integer value in the range of 0 - 9999. Example: year(date)
  // @i `year$
  // @t full DATE
  // @d n -> n
  // @tst year({d '2010.10.10'}) -> Q 2010i;; year(list({d '2011.10.11'})) -> Q enlist 2011i;; year(list(list({d '2012.10.12'}))) -> Q enlist (),2012i
  // @tst year({ts '2010.10.10D10'}) -> Q 2010i;; year(list({ts '2011.10.11D10'})) -> Q enlist 2011i;; year(list(list({ts '2012.12.12D10'}))) -> Q enlist (),2012i
  // @tst year(null) -> {n 'int'}
  // @tst year() -> Exc;; year({ts '2010.10.10D10'},{ts '2010.10.10D10'}) -> Exc;; year(1) -> Exc
 `year$x};

.qsql.f.not:{
  // Logical not, returns false for all none 0 values. Example: not(num)
  // @i not
  // @t full NUM
  // @d n -> n
  // @tst not 1 -> false;; not false -> true;; not list(1,0) -> list(false,true);; not list(list(1)) -> list(list(false))
  // @tst not 'a' -> Exc;; not null -> false
 not x};

.qsql.f.or:{
  // Logical or and maximum of two arguments. The arguments must be numbers or date/time values. Example: x or y
  // @i |
  // @t full NUM NUM
  // @d n n -> n
  // @tst true or true -> true;; false or true -> true;; 10 or 2 -> 10;; 2 or 5.4 -> 5.4
  // @tst null or 10 -> 10;; 1.2 or null -> 1.2;; null or null -> {n 'long'}
  // @tst list(1,3) or 2 -> list(2,3);; 2 or list(1,3) -> list(2,3);; list(1,3) or list(3,1) -> list(3,3)
  // @tst list(list(1,3)) or list(list(3,1)) -> list(list(3,3));; list(1,2) or list(1) -> Exc;; list(list(1,2)) or list(list(1)) -> Exc
  // @tst 1 or 'a' -> Exc;; "a" or 1 -> Exc
  x or y};

.qsql.f.and:{
  // Logical and, also minimum of two arguments. The arguments must be numbers or date/time values. Example: x and y
  // @i &
  // @t full NUM NUM
  // @d n n -> n
  // @tst true and true -> true;; false and true -> false;; 10 and 2 -> 2;; 2.1 and 5.4 -> 2.1
  // @tst null and 10 -> {n 'long'};; 1.2 and null -> {n 'float'};; null and null -> {n 'long'}
  // @tst list(1,3) and 2 -> list(1,2);; 2 and list(1,3) -> list(1,2);; list(1,3) and list(3,1) -> list(1,1)
  // @tst list(list(1,3)) and list(list(3,1)) -> list(list(1,1));; list(1,2) and list(1) -> Exc;; list(list(1,2)) and list(list(1)) -> Exc
  // @tst 1 and 'a' -> Exc;; "a" and 1 -> Exc
  x and y};

.qsql.f.plus:{
  // Add two arguments. The arguments must be numbers or date/time values. Example: plus(x,y) or x+y
  // @i +
  // @t full NUM NUM
  // @d n n -> n
  // @tst plus(1,2) -> 3;; plus({d '2010-11-10'},10) -> {d '2010-11-20'};; plus({ts '2010-10-10D0'},{t '10:00'}) -> {ts '2010-10-10D10:00'}
  // @tst plus(1,null) -> {n 'bigint'};; plus(null,1.0) -> {n 'float'};; plus(null,null) -> {n 'bigint'}
  // @tst plus(1,list(1,2)) -> list(2,3);; plus(list(1,2),1) -> list(2,3);; plus(list(1,2),list(3,4)) -> list(4,6);; plus(null,list(1,2)) -> Q 0N 0N;; plus(list(1,2),null) -> Q 0N 0N
  // @tst plus(list(list(1,2)),list(list(1,2))) -> list(list(2,4));; plus(list(list(1,2)),list(list(1))) -> Exc
  // @tst plus(1,'a') -> Exc;; plus("aa",1) -> Exc;; plus({ts '2010-10-10D0'},{d '2010.10.10'}) -> Exc
  // @tst plus(list(1,2),list(1)) -> Exc;; plus(1,2,3) -> Exc;; plus(1) -> Exc
  x+y};

.qsql.f.minus:{
  // Subtract two arguments. The arguments must be numbers or date/time values. Example: minus(x,y) or x-y
  // @i -
  // @t full NUM NUM
  // @d n n -> n
  // @tst minus(3,1) -> 2;; minus({d '2010-11-10'},9) -> {d '2010-11-01'};; minus({ts '2010-10-10D20'},{t '10:00'}) -> {ts '2010-10-10D10:00'}
  // @tst minus(1,null) -> {n 'bigint'};; minus(null,1.0) -> {n 'float'};; minus(null,null) -> {n 'bigint'}
  // @tst minus(3,list(1,2)) -> list(2,1);; minus(list(1,2),1) -> list(0,1);; minus(list(3,4),list(1,2)) -> list(2,2);; minus(null,list(1,2)) -> Q 0N 0N;; minus(list(1,2),null) -> Q 0N 0N
  // @tst minus(list(list(3,4)),list(list(1,2))) -> list(list(2,2));; minus(list(list(1,2)),list(list(1))) -> Exc
  // @tst minus(1,'a') -> Exc;; minus("aa",1) -> Exc;; minus({ts '2010-10-10D0'},{d '2010.10.10'}) -> Exc
  // @tst minus(list(1,2),list(1)) -> Exc;; minus(1,2,3) -> Exc;; minus(1) -> Exc
  x-y};

.qsql.f.mult:{
  // Multiplicate two arguments. The arguments must be numbers or date/time values. Example: mult(x,y) or x*y
  // @i *
  // @t full NUM NUM
  // @d n n -> n
  // @tst mult(1,2) -> 2;; mult({d '2010-10-10'},2) -> {d '2021-07-19'};; mult({t '10:00'},2) -> {t '20:00'}
  // @tst mult(1,null) -> {n 'bigint'};; mult(null,1.0) -> {n 'float'};; mult(null,null) -> {n 'bigint'}
  // @tst mult(1,list(1,2)) -> list(1,2);; mult(list(1,2),1) -> list(1,2);; mult(list(1,2),list(3,4)) -> list(3,8);; mult(null,list(1,2)) -> Q 0N 0N;; mult(list(1,2),null) -> Q 0N 0N
  // @tst mult(list(list(1,2)),list(list(1,2))) -> list(list(1,4));; mult(list(list(1,2)),list(list(1))) -> Exc
  // @tst mult(1,'a') -> Exc;; mult("aa",1) -> Exc;; mult({ts '2010-10-10D0'},{t '10:10'}) -> Exc
  // @tst mult(list(1,2),list(1)) -> Exc;; mult(1,2,3) -> Exc;; mult(1) -> Exc
  x*y};

.qsql.f.divide:{
  // Divide two arguments. The arguments must be numbers or date/time values. Example: divide(x,y) or x/y
  // @i %
  // @t full NUM NUM
  // @d n n -> n
  // @tst divide(1,2) -> 0.5;; divide({d '2010-10-10'},2) -> 1967.5;; divide({t '10:00'},2) -> 1.8e+7
  // @tst divide(1,null) -> {n 'float'};; divide(null,1.0) -> {n 'float'};; divide(null,null) -> {n 'float'}
  // @tst divide(2,list(1,2)) -> list(2.0,1.0);; divide(list(1,2),1) -> list(1.0,2.0);; divide(list(1,2),list(2,4)) -> list(0.5,0.5);; divide(null,list(1,2)) -> Q 0n 0n;; divide(list(1,2),null) -> Q 0n 0n
  // @tst divide(list(list(1,2)),list(list(1,2))) -> list(list(1.0,1.0));; divide(list(list(1,2)),list(list(1))) -> Exc
  // @tst divide(1,'a') -> Exc;; divide("aa",1) -> Exc;; divide(list(1,2),list(1)) -> Exc;; divide(1,2,3) -> Exc;; divide(1) -> Exc
  x%y};

.qsql.f.div:{
  // Integer division. The arguments must be numbers or date/time values. Example: div(x,y) or x div y
  // @i div
  // @t full NUM NUM
  // @d n n -> n
  // @tst 3 div 2 -> 1;; {d '2010-10-10'} div 2 -> {d '2005.05.21'};; {t '10:00'} div 2 -> {t '05:00'}
  // @tst 1 div null -> {n 'bigint'};; null div 1.0 -> {n 'bigint'};; null div null -> {n 'bigint'}
  // @tst 10 div list(3,4) -> list(3,2);; list(3,5) div 2 -> list(1,2);; list(3,5) div list(2,2) -> list(1,2);; null div list(1,2) -> Q 0N 0N;; list(1,2) div null -> Q 0N 0N
  // @tst list(list(3,5)) div list(list(2,2)) -> list(list(1,2));; list(list(1,2)) div list(list(1)) -> Exc
  // @tst 1 div 'a' -> Exc;; "aa" div 1 -> Exc;; list(1,2) div list(1) -> Exc
  x div y};

.qsql.f.eq:{
  // Compare two arguments. Example: eq(x,y) or x=y
  // @t .qsql.c.xeq All All
  // @d n n -> n
  // @i =
  // @tst 1=1 -> true;; {d '2010.10.10'}=100 -> false;; null=1 -> false;; null=null -> true;; list(1,2)=null -> list(false,false)
  // @tst 1=list(1,2) -> list(true,false);; list(1,2)=list(3,2) -> list(false,true);; list(list(1))=1 -> Exc
  // @tst 'a'=1 -> Exc;; 1="a" -> Exc;; list(1,2)=list(1) -> Exc
  // @tst 'a'='a' -> true;; "a"="a" -> true;; 'ab'="ab" -> true;; "ab"=list('ab','cd') -> list(true,false);; list("ab","cd")=list('ab','dd') -> list(true,false)
  // @tst 'ab'=list("ab","cd") -> list(true,false);; 'a'=list(list('a','b')) -> Exc;; eq(1) -> Exc;; eq(1,2,3) -> Exc
  // @tst "a"=to_char("ab") -> true;; "ab"=to_char("ab") -> false;; 'a'=to_char("ab") -> true;; 'ab'=to_char("ab") -> false
  // @tst list(to_char('aa'),to_char('bb'))='a' -> list(true,false);; list(to_char('aa'),to_char('bb'))=list('ac','b') -> list(false,true)
  .qsql.ff.xeq[x;y]};

.qsql.f.neq:{
  // Compare two arguments. Example: neq(x,y) or x!=y or x<>y
  // @t .qsql.c.xeq All All
  // @d n n -> n
  // @i <>
  // @tst 1!=1 -> false;; {d '2010.10.10'}<>101 -> true;; null!=1 -> true;; null<>null -> false;; list(1,2)!=null -> list(true,true)
  // @tst 1<>list(1,2) -> list(false,true);; list(1,2)!=list(3,2) -> list(true,false);; list(list(1))<>1 -> Exc
  // @tst 'a'<>1 -> Exc;; 1!="a" -> Exc;; list(1,2)!=list(1) -> Exc
  // @tst 'a'<>'a' -> false;; "a"!="b" -> true;; 'ab'<>"acc" -> true;; "ab"!=list('ab','cxd') -> list(false,true);; list("ab","ccd")!=list('ab','dd') -> list(false,true)
  // @tst 'ab'!=list("ab","ccd") -> list(false,true);; 'a'<>list(list('a','b')) -> Exc;; neq(1) -> Exc;; neq(1,2,3) -> Exc
  // @tst "a"<>to_char("ab") -> false;; "ab"<>to_char("ab") -> true;; 'a'<>to_char("ab") -> false;; 'ab'<>to_char("ab") -> true
  // @tst list(to_char('aa'),to_char('bb'))!='a' -> list(false,true);; list(to_char('aa'),to_char('bb'))<>list('ac','b') -> list(true,false)
  .qsql.ff.xeq[x;y]};

.qsql.f.gt:{
  // Compare two arguments. Example: gt(x,y) or x>y
  // @t .qsql.c.xeq All All
  // @d n n -> n
  // @i >
  // @tst 2>1 -> true;; {d '2010.10.10'}>99 -> true;; null>1 -> false;; null>null -> false;; list(1,2)>null -> list(true,true)
  // @tst 1>list(0,2) -> list(true,false);; list(1,2)>list(3,1) -> list(false,true);; list(list(1))>1 -> Exc
  // @tst 'a'>1 -> Exc;; 1>"a" -> Exc;; list(1,2)>list(1) -> Exc
  // @tst 'b'>'a' -> true;; "ab">"a" -> true;; 'abc'>"ab" -> true;; "abc">list('ab','cd') -> list(true,false);; list("abc","cd")>list('ab','dd') -> list(true,false)
  // @tst 'abc'>list("ab","cd") -> list(true,false);; 'a'>list(list('a','b')) -> Exc;; gt(1) -> Exc;; gt(1,2,3) -> Exc
  // @tst "b">to_char("ab") -> true;; "bb">to_char("ab") -> false;; 'b'>to_char("ab") -> true;; 'bb'>to_char("ab") -> false
  // @tst list(to_char('bb'),to_char('aa'))>'a' -> list(true,false);; list(to_char('aa'),to_char('bb'))>list('ac','a') -> list(true,true)
  .qsql.ff.xeq[x;y]};

.qsql.f.lt:{
  // Compare two arguments. Example: lt(x,y) or x<y
  // @t .qsql.c.xeq All All
  // @d n n -> n
  // @i <
  // @tst 1<2 -> true;; {d '2010.10.10'}<99 -> false;; null<1 -> true;; null<null -> false;; list(1,2)<null -> list(false,false)
  // @tst 1<list(0,2) -> list(false,true);; list(1,2)<list(3,1) -> list(true,false);; list(list(1))<1 -> Exc
  // @tst 'a'<1 -> Exc;; 1<"a" -> Exc;; list(1,2)<list(1) -> Exc
  // @tst 'a'<'b' -> true;; "a"<"ab" -> true;; 'ab'<"abc" -> true;; "ab"<list('abc','aa') -> list(true,false);; list("ab","dd")<list('abc','dc') -> list(true,false)
  // @tst 'ab'<list("abc","aa") -> list(true,false);; 'a'<list(list('a','b')) -> Exc;; lt(1) -> Exc;; lt(1,2,3) -> Exc
  // @tst "a"<to_char("ba") -> true;; "aa"<to_char("bb") -> true;; 'a'<to_char("bb") -> true;; 'aa'<to_char("bb") -> true
  // @tst list(to_char('bb'),to_char('aa'))<'b' -> list(false,true);; list(to_char('aa'),to_char('aa'))<list('ac','b') -> list(false,true)
  .qsql.ff.xeq[x;y]};

.qsql.f.gte:{
  // Compare two arguments. Example: gte(x,y) or x>=y
  // @t .qsql.c.xeq All All
  // @d n n -> n
  // @i >=
  // @tst 2>=1 -> true;; {d '2010.10.10'}>=99 -> true;; null>=1 -> false;; null>=null -> true;; list(1,2)>=null -> list(true,true)
  // @tst 1>=list(0,2) -> list(true,false);; list(1,1)>=list(3,1) -> list(false,true);; list(list(1))>=1 -> Exc
  // @tst 'a'>=1 -> Exc;; 1>="a" -> Exc;; list(1,2)>=list(1) -> Exc
  // @tst 'a'>='a' -> true;; "ab">="a" -> true;; 'abc'>="ab" -> true;; "ab">=list('ab','cd') -> list(true,false);; list("abc","cd")>=list('ab','dd') -> list(true,false)
  // @tst 'ab'>=list("ab","cd") -> list(true,false);; 'a'>=list(list('a','b')) -> Exc;; gte(1) -> Exc;; gte(1,2,3) -> Exc
  // @tst "b">=to_char("ab") -> true;; "bb">=to_char("ab") -> false;; 'b'>=to_char("ab") -> true;; 'bb'>=to_char("ab") -> false
  // @tst list(to_char('bb'),to_char('aa'))>='a' -> list(true,true);; list(to_char('aa'),to_char('aa'))>=list('ac','a') -> list(true,true)
  .qsql.ff.xeq[x;y]};

.qsql.f.lte:{
  // Compare two arguments. Example: lte(x,y) or x<=y
  // @t .qsql.c.xeq All All
  // @d n n -> n
  // @i <=
  // @tst 1<=1 -> true;; {d '2010.10.10'}<=99 -> false;; null<=1 -> true;; null<=null -> true;; list(1,2)<=null -> list(false,false)
  // @tst 1<=list(0,2) -> list(false,true);; list(1,2)<=list(1,1) -> list(true,false);; list(list(1))<=1 -> Exc
  // @tst 'a'<=1 -> Exc;; 1<="a" -> Exc;; list(1,2)<=list(1) -> Exc
  // @tst 'a'<='a' -> true;; "a"<="ab" -> true;; 'ab'<="ab" -> true;; "ab"<=list('abc','aa') -> list(true,false);; list("ab","dd")<=list('ab','dc') -> list(true,false)
  // @tst 'ab'<=list("abc","aa") -> list(true,false);; 'a'<=list(list('a','b')) -> Exc;; lte(1) -> Exc;; lte(1,2,3) -> Exc
  // @tst "a"<=to_char("aa") -> true;; "aa"<=to_char("bb") -> true;; 'a'<=to_char("bb") -> true;; 'aa'<=to_char("bb") -> true
  // @tst list(to_char('bb'),to_char('aa'))<='b' -> list(true,true);; list(to_char('aa'),to_char('aa'))<=list('ac','b') -> list(false,true)
  .qsql.ff.xeq[x;y]};

.qsql.f.within:{
  // Check that arg1 is within (arg2,arg3) range. Example: within(price,10,11), price between 10 and 11, price not between 10 and 11
  // @t .qsql.c.within All All All
  // @d n n n -> n
  // @i within
  // @tst within(2,2,3) -> true;; within(2,2.1,3.1) -> false;; within(2,2,3.1) -> true;; within('aa','a','b') -> true
  if[any 10=abs type each (x;y;z); '"reject"]; // false reject to know when we can use the built-in within, handle strings via >=
  x within (y;z)};

.qsql.f.convert:{[x;y]
  // Cast the second argument (expression) to the type in the first expression (string). Example: cast({ts '2010.10.10D10:00'} as date) or extract(date from timeval) or convert(time,'date')
  // Also to cast between/to symbols and strings: cast(10.2 as 'char'), cast("string value" as 'symbol')
  // Get a typed null: cast(null as 'bigint') or {n 'bigint'}
  // @t .qsql.c.convert ALL s.C
  // @d n 1 -> n
  // @tst cast(1 as float) -> 1.0;; cast(list(1.2,3.4) as bigint) -> list(1,3);; cast(list(list({ts '2010.10.10D0'})) as date) -> list(list({d '2010.10.10'}))
  // @tst convert("10:10","time") -> {t '10:10'};; convert(list('1','0'),'boolean') -> list(true,false);; convert(list(list('10')),'tinyint') -> Q enlist (),0x10
  // @tst extract(year from {d '2010.10.10'}) -> Q 2010i;; extract(month from {d '2010.10.10'}) -> Q 10i;; extract(day from {ts '2010.10.11D12:00'}) -> Q 11i
  // @tst extract(hour from {t '10:11:12'}) -> Q 10i;; extract(minute from {t '10:11:12'}) -> Q 11i;; extract(second from {ts '2010.10.10D10:11:12'}) -> Q 12i
  // @tst extract(qmonth from {d '2010.11.12'}) -> Q 2010.11m;; extract(qminute from {t '10:11:12'}) -> Q 10:11;; extract(qsecond from {ts '2010.10.10D10:11:12.111'}) -> Q 10:11:12
  // @tst cast({t '10:10'} as varchar) -> "10:10:00.000";; cast("str" as char) -> "str";; cast('sym' as char) -> "sym";; cast("str" as symbol) -> 'str'
  // @tst convert(null,'long') -> {n 'bigint'};; convert(null,"char") -> "";; convert(null,'year') -> Q 0Ni
  // @tst convert(1) -> Exc;; convert(1,2,3) -> Exc;; convert(1,2) -> Exc;; convert(1,'zzz') -> Exc;;  convert(1,'symbol') -> Exc;; convert(list(list(1)),'char') -> Exc
  // @tst convert(to_char("a"),"symbol") -> 'a';; convert(to_char(list("a","b")),'char') -> list("a","b");; type(convert(to_char(list("a","b")),'char')) -> "string[]"
  1};

.qsql.help:(`$())!();
/ transform exposed functions to capture exceptions and provide help.
.qsql.ff.trans:{
  .qsql.help[n:lower last` vs x]:"no help available";
  x set a:``f`fn`name`dims`tst`catch!(::;get x;` sv x,`f;n;`1`1;();0b);
  if[count s:s where not null first each ss[;" //"]each s:"\n"vs string a`f;
    if[count h:s where not i:"@"=first each s:trim 2_'ltrim s; .qsql.help[n]:"\n "sv h];
    if[count s:s where i; a:({.qsql.ft[y][x;z]}/[a;;]).(`$;trim)@'flip (0,/:s?\:" ")_'s:1_'s];
  ];
  if[not `anum in key a; a[`anum]:(=)[count a[`dims;0]]];
  / .qsql.F[n]:{[n;i;a] .[.qsql.F n;a;.qsql.ff.exc[n;i]]}n;
  x set a;
 };
.qsql.ff.parseTag:{trim(0,where(not " "=prev x)&" "=x)_x};
/ tag functions
.qsql.ft.i:{[a;s] a[`fn]:value s; a}; / inline
.qsql.ft.t:{[a;s] / type: @t (full|function) t1.t2 t1.t2 ...
  t:raze each t^.qsql.t.tgroup t:` vs/:1_s:`$.qsql.ff.parseTag s;  / (aTypes1;5 6h;...)
  if[````~last t; t:-1_t; a[`anum]:(<)[-1+count t]];  / unlimited number of args
  a[`atype]:t:distinct each .qsql.t.qtypes?t;
  a[`atnum]:count each t;
  if[0=count t; a[`anum`atnum]:((0=);(),1); t:enlist (),.qsql.t.tj];
  a[`rtype]:.qsql.ff.makeTypeMap[a`fn;t;$[`tpp in key a;a`tpp;{y}]]; / result types
  a[`nulls]:a[`atnum]vs first where not null a`rtype; / find out suitable typed nulls
  if[not `full=first s; a[`tchk]:first s];
  :a;
 };
.qsql.ft.d:{[a;s] a[`dims]:(-1_s;last s:`$s _ -2+count s:.qsql.ff.parseTag s); a}; / dimensions: n 1 m -> n
.qsql.ft.tpp:{[a;s] a[`tpp]:value s; a}; / type post processing
.qsql.ft.tst:{[a;s] a[`tst],:trim {"->"vs x} each ";;" vs s; a}; / unit tests
.qsql.ft.opt:{[a;s] a[`opt]:value s; a}; / optional arguments, default values, all args (not only optional) must be listed
.qsql.ft.catch:{[a;s] a[`catch]:1b; a}; / wrap in catch block

/ Raise an appropriate exception
.qsql.ff.exc:{[n;i;e] 'string[i]," ",string[n]," failed with ",e};

/ apply f to all x, adjust x to be a string
.qsql.ff.str1:{[f;x] s:(type x:.qsql.ff.strv x)=type x; $[s;::;`$]$[type x;f x;f each x]};
.qsql.ff.str2:{[f;x;y] s1:(type x:.qsql.ff.strv x)=type x; s2:(type y:.qsql.ff.strv y)=type y; $[s1|s2;::;`$]$[type x;$[type y;f[x;y];x f/: y];type y;x f\: y;f'[x;y]]};
.qsql.ff.strv:{$[(t:abs type first x)=11;string x;(19h<t)&77h>t;string value x;-10=type x;(),x;x]};
.qsql.ff.symv:{$[(t:abs type first x)=10;`$x;(19h<t)&77h>t;value x;x]};

.qsql.ff.day:{x-`date$`month$x:`date$x};
.qsql.ff.dayofyear:{1+x-"d"$(1+`month$x)-`mm$x:"d"$x};
.qsql.ff.adjDate:{[f;d;v] v:f[dd:`date$d;v]; $[12=abs type first d;d-1D*dd-v;v]};
.qsql.ff.addMonth:{[d;v] .qsql.ff.adjDate[{(&).(-1;.qsql.ff.day x)+`date$y+/:1 0+\:`month$x};d;v]};

.qsql.ff.user:{`undefined};
.qsql.ff.database:{`undefined};

/ purpose - return the correct type for sym vs string
.qsql.ff.xeq:{[x;y]
  m:(.qsql.t.qtypes?`a`A`C`Cc)!(`;enlist`;`;enlist`); if[(t1:.qsql.t.type x) in key m; x:m t1]; if[(t2:.qsql.t.type y) in key m; y:m t2];
  if[1=sum(.qsql.t.qtypes t1,t2)in .qsql.t.tgroup`STR`a`A;'"exc"]; / do not allow num vs char
  x=y};
.qsql.ff.strlt:{(1=first idesc (x;y))&not x~y};
.qsql.ff.strgt:{.qsql.ff.strlt[y;x]};
.qsql.ff.convert:{[x;y;yt]
  xf:.qsql.t.castMap xx:.qsql.t.normType x;
  xn:$[-11=type x;string x;.qsql.t.qnames x];
  if[y~(::); :.qsql.t.qnulls $[-11=type xf;.qsql.t.ti;10=xf;.qsql.t.tC;.qsql.t.lmt1-xf]]; / for date parts use int
  if[xx in`char`varchar; :$[yt in .qsql.t.tC,.qsql.t.tCc;y;string y]]; / toString
  if[(yt in .qsql.t.tC,.qsql.t.tCc)|s:yt in .qsql.t.qtypes?`a`A`s`S`Ss; :(upper .Q.t $[-11=type xf;14;xf])$$[s;string y;y]]; / fromString
  if[yt in .qsql.t.qtypes?`t`T`Tt; :$[`timestamp=xx;(xx$0)+y;`date=xx;xx$0;@[xf$;y;{y;'" time can't be converted to ",x}xn]]]; / from time
  if[yt in .qsql.t.qtypes?`m`M`Mm`d`D`Dd; :$[xx in `hour`minute`second;0;@[xf$;y;{y;'" date/month can't be converted to ",x}xn]]]; / month date
  :@[xf$;y;{z;'.qsql.t.qnames[x]," can't be converted to ",y}[yt;xn]];
 };

/ create a type map (t1,...)->t for a function f
.qsql.ff.makeTypeMap:{[f;args;pp]{y[z] .[{.qsql.t.type x . .qsql.t.qones (),y};(x;z);0N]}[f;pp] each cross/[args]};

/ substitute syms from map x in y
.qsql.ff.substn:{[n;x;y] $[-11=t:type y;$[y in key x;x y;y];(1<count y)&t in 11 0h;$[n=0;y;.z.s[n-1;x] each y];y]};

.qsql.ff.trans each ` sv/:`.qsql.f,/:`plus`list`mult`minus`divide`div`eq`neq`gt`lt`gte`lte`to_char`type`convert`not`or`and`year`week`upper`ucase`trim`translate,
  `timestampdiff`current_date`curdate`current_timestamp`now`getdate`curtime`current_user`user`database`dayname`dayofmonth`dayofweek`dayofyear`degrees`exp`floor,
  `neg`abs`acos`add_month`asin`atan`atan2`ceiling`char`ascii`concat`cos`cot`decode`greatest`hour`isnull`ifnull`initcap`insert`instr`last_day`lower`lcase`least,
  `left`octet_length`len`length`locate`localtime`localtimestamp`log`log10`lpad`ltrim`minute`mod`monthname`month`month_between`next_day`nullif`pi`power`prefix,
  `quarter`radians`rand`repeat`replace`right`truncate`round`rpad`rtrim`second`sign`sin`soundex`difference`space`sqrt`substring`suffix`tan`timestampadd`within`is_null`in_;
