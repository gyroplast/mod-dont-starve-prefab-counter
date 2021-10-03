-- [[ generic utilities ]] --
local M = {}
local json = require("json")

local TheNet = _G.TheNet

-- remove leading and trailing whitespace from a string
function M.trim(s)
    return (type(s) == "string" and s:gsub("^%s*(.-)%s*$", "%1") or "")
end

-- round a number to the nearest decimal places
function M.round(val, decimal)
    if (decimal) then
        return math.floor((val * 10 ^ decimal) + 0.5) / (10 ^ decimal)
    else
        return math.floor(val + 0.5)
    end
end

-- return true iff a bit flag is set in a value; Lua 5.1 doesn't know bitwise operators.
function M.FlagIsSet(flag, value) return (value / flag) % 2 >= 1 end

-- return true iff str starts with start, without other preceding characters
function M.starts_with(str, start)
    return (type(str) == "string" and (str:sub(1, #start) == start) or false)
end

function M.join(tbl)
    return (type(tbl) == "table" and
               ("{ \"" .. table.concat(tbl, "\", \"") .. "\" }") or "")
end

-- pretty-print table only one level deep
function M.table2str(t)
    if type(t) ~= "table" then return tostring(t) end
    local buf = {}
    for k, v in pairs(t) do buf[k] = type(v) == "table" and tostring(v) or v end
    return json.encode(buf)
end

-- @see http://lua-users.org/wiki/StringRecipes
local function wrap(str, limit, indent)
    indent = indent or ""
    limit = limit or 72
    local here = 1 - #indent
    local function check(sp, st, word, fi)
        if fi - here > limit then
            here = st - #indent
            return "\n" .. indent .. word
        end
    end
    return indent .. str:gsub("(%s+)()(%S+)()", check)
end

-- Reflow and word-wrap text.
-- @see http://lua-users.org/wiki/StringRecipes
function M.reflow(text, limit, indent)
    return (text:gsub("[^\n]+",
                      function(line) return wrap(line, limit, indent) end))
end

-- announce arbitrary system messages, word-wrapped, accepts table[str] for multi-line strings.
function M.announce_all(msg, limit, indent)
    if type(msg) == "table" then
        msg = table.concat(msg, "\n")
    else
        msg = tostring(msg)
    end
    TheNet:SystemMessage(M.reflow(msg, limit, indent))
end

return M
