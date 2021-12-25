-- server-only mod, exit early on client
if not GLOBAL.TheNet:GetIsServer() then do return end end

modimport("lib/const")    -- imports "C"
modimport("lib/util")     -- imports "util"
modimport("lib/logging")  -- imports "Log"

-- convenient aliases and simple helpers
local _G = GLOBAL
local TheNet = _G.TheNet

local CFG_SHOW_ZERO_COUNTS = GetModConfigData("show_zero_counts")

-- declare exports
_G.PC = nil

local PrefabCounter = Class(function(self)
    self.items_to_count = self:GetItemsToCount(modinfo.configuration_options)
end)

--[[ return table of items to count, based on configuration options, indexed by the display name.

    Example:
    {
      "Berry Bushes" = {
        prefabs = { "berrybush", "berrybush2" },
        count = 0
      },
      ...
    }
  ]]
function PrefabCounter:GetItemsToCount(configuration_options)
    Log:Trace(
        "getItemsToCount(): creating table of prefabs to count from configuration")
    local ret = {}
    for _, item in ipairs(configuration_options) do
        Log:Trace("getItemsToCount(): checking config item name for count: %s",
                  item.name)
        if item.label and util.starts_with(item.name, "count_") and
            GetModConfigData(item.name) == true then
            local config_prefab = item.name:gsub("^count_", "")
            Log:Trace("getItemsToCount(): extracted config prefab: %s",
                      config_prefab)
            ret[item.label] = {
                prefabs = C.COUNT_PREFAB_CONFIG_MAP[config_prefab] or
                    {config_prefab},
                count = 0
            }
            Log:Trace("getItemsToCount(): entry[%s] = %s", item.label,
                      util.join(ret[item.label]["prefabs"]))
        end
    end
    return ret
end

-- pimped c_countprefabs to consider exceptions for prefab "variants"
function PrefabCounter:CountPrefab(prefab)
    local count = 0
    for k,v in pairs(_G.Ents) do
        -- spiderden tiers are represented by components.growable.stage
        if v.prefab == "spiderden" and util.starts_with(prefab, "spiderden") then
            Log:Trace("CountPrefab(\"%s\") handling %s", tostring(prefab), tostring(v.prefab))

            if (prefab == "spiderden" and v.components.growable and v.components.growable.stage == 1) or
               (prefab == "spiderden_2" and v.components.growable and v.components.growable.stage == 2) or
               (prefab == "spiderden_3" and v.components.growable and v.components.growable.stage == 3) then
                count = count + 1
                Log:Trace("CountPrefab(\"%s\") counted %s stage %d", tostring(prefab), tostring(v.prefab), v.components.growable.stage)
            end
        -- non-exceptional prefabs are counted as-is
        elseif v.prefab == prefab then
            count = count + 1
        end
    end
    Log:Trace("CountPrefab(\"%s\") -> %d", tostring(prefab), count)
    return count
end

function PrefabCounter:Count()
    local ret = {}
    for display_name, item in pairs(self.items_to_count) do
        item.count = 0 -- reset item count to prevent accumulation on each call
        for _, prefab in ipairs(item.prefabs) do
            local prefab_count = _G.c_countprefabs(prefab, true)
            Log:Trace("prefabs counted: %d %s", prefab_count, prefab)
            item.count = item.count + prefab_count -- sum count of all listed prefabs for an item
        end
        Log:Debug("total item count: %d %s", item.count, display_name)
        if item.count ~= 0 or CFG_SHOW_ZERO_COUNTS then
            ret[#ret + 1] = string.format("%s: %d", display_name, item.count)
        end
    end
    -- sort array of result string alphabetically, descending, ignoring case
    table.sort(ret, function(a, b) return a:upper() < b:upper() end)

    util.announce_all(table.concat(ret, ", "))
end

local function main()
    Log:Info("starting")
    Log:Info("CFG: log level set to %s", Log:GetLogLevel())

    -- export main access object
    _G.PC = PrefabCounter()

    -- dump config state to server log
    Log:Debug("CFG: show zero-count items = %s",
              CFG_SHOW_ZERO_COUNTS and "YES" or "NO")

    for display_name, item in pairs(_G.PC.items_to_count) do
        Log:Debug("activated counting of %s (prefabs = %s)", display_name,
                  util.join(item.prefabs))
    end

    Log:Info("finished initialization")
end

main()
