/ Variable resolver. It should return either a value or a dictionary describing where it can be found. For unknown variables return ().
/ Dictionary must have the following fields:
/ `typ - like `s `S `Ss and etc. The variable type. All tables: `Tbl.
/ `class - optional, value category: `part, `splay (for tables), big, small (default). Only small values can be sent via sockets. For part tables all selects will require date clause and will be splitted by date.
/ `targets - optional, servers where this variable can be found. See below.
/ `name - optional, real name.
/ `val - optional, var's value.
/ All tables must be defined via this dict. Their fields:
/  `meta - name -> type mapping (sql types), or at least the actual meta. Must be present if there is no `val. Attributes and date range must be defined via targets.
/ Targets is a table with the following columns:
/  id - symbol, server unique id. (fx.EMEA.UAT.rdb.0 and etc).
/  vFilter - a fn to filter servers by date or any other virtual column. For example for RDBs it can be {.z.D in x}. x is a date list extracted from where clause.
/  class - optional, sym. For splayed, part tables we need to know its status on each server (rdbs have `big tables, hdbs - `part).
/  sCol, gCol - optional, sym list. Columns with s,g attributes.
/  pCol, vCol, psCol - mandatory for part tables, sym. vCol - virtual column in the part table (date usually), pCol - column with p attr (sym), psCol - implicitly sorted column within one pCol value (time).
.qsql.ext.resolveName:{'"undefined"};
