luajit-sqlite3: SQLite3 bindings for luajit.
============================

Pure LuaJIT binding for [SQLite3](http://sqlite.org) databases.

Forked from https://github.com/stepelu/lua-ljsqlite3

## Features

- all SQLite3 types are supported and mapped to LuaJIT types
- efficient implementation via value-binding methods and prepared statements
- ability to extend SQLite3 via scalar and aggregate (Lua) callback functions
- command-line shell feature
- results by row or by whole table

```lua
local sql = require "luajit-sqlite3"
local conn = sql.open("") -- Open a temporary in-memory database.
  
-- Execute SQL commands separated by the ';' character:
conn:exec [[
  CREATE TABLE t(id TEXT, num REAL);
  INSERT INTO t VALUES('myid1', 200);
]]
  
-- Prepared statements are supported:
local stmt = conn:prepare("INSERT INTO t VALUES(?, ?)")
for i = 2, 4 do
  stmt:reset():bind('myid'..i, 200 * i):step()
end
  
-- Command-line shell feature which here prints all records:
conn "SELECT * FROM t"
--> id    num
--> myid1 200
--> myid2 400
--> myid3 600
--> myid4 800
  
local t = conn:exec("SELECT * FROM t") -- Records are by column.
-- Access to columns via column numbers or names:
assert(t[1] == t.id)
-- Nested indexing corresponds to the record number:
assert(t[1][3] == 'myid3')
  
-- Convenience function returns multiple values for one record:
local id, num = conn:rowexec("SELECT * FROM t WHERE id=='myid3'")
print(id, num) --> myid3 600
 
-- Custom scalar function definition, aggregates supported as well.
conn:setscalar("MYFUN", function(x) return x/100 end)
conn "SELECT MYFUN(num) FROM t"
--> MYFUN(num)
--> 2
--> 4
--> 6
--> 8
 
conn:close() -- Close stmt as well.
```

## Install

Copy the init.lua to your project and rename it to whatever you want, e.g. `sqlite3.lua`

## Documentation

> TBD
