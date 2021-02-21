
local sqlite3 = require("init")

-- open in memory database
local db = sqlite3.open("")

db:pragma("journal_mode", "MEMORY")
db:pragma("synchronous", "OFF")

db:exec [[
  create table t(id integer primary key, name text);
  insert into t(name) values ('name1');
  insert into t(name) values ('name2');
]]

local r

r = db:exec "SELECT * FROM t;"
assert(r[0][1] == "id")
assert(r[0][2] == "name")
assert(r.id[1] == 1)
assert(r.id[2] == 2)
assert(r.name[1] == "name1")
assert(r.name[2] == "name2")
assert(#r == 2)
