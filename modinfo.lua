---@diagnostic disable: lowercase-global
local function trim(s) return s:gsub("^%s*(.-)%s*$", "%1") end

-- custom field for description and in-game constants
_src_url = "https://github.com/gyroplast/mod-dont-starve-prefab-counter"

name = "Prefab Counter"
author = "Gyroplast"
version = "1.0.1dev"
forumthread = ""
api_version = 10
dont_starve_compatible = false
reign_of_giants_compatible = false
dst_compatible = true
icon_atlas = "modicon.xml"
icon = "modicon.tex"
all_clients_require_mod = false
client_only_mod = false
server_filter_tags = {"prefab counter"}

description = trim [[
Version __VERSION__, Steam ID 2618765953
Easily count a configurable list of prefabs/items in a world, like walrus camps,
amount of reeds, etc., to quickly check if a generated world is worth playing.

Just run PC:Count() in the remote console to show a fresh count of items in the current shard.

Sources: __SRC_URL__
]]:gsub("__VERSION__", version):gsub("__SRC_URL__", _src_url)
configuration_options = {
    {
        name = "title_general_settings",
        label = "General Settings",
        hover = "",
        options = {{description = "", data = ""}},
        default = ""
    }, {
        name = "log_level",
        label = "Log Level",
        hover = "Write log messages to file with selected or higher severity. Trace may contain sensitive data and/or be very chatty!",
        options = {
            {description = "Trace", data = "TRACE"},
            {description = "Debug", data = "DEBUG"},
            {description = "Info", data = "INFO"},
            {description = "Warning", data = "WARNING"},
            {description = "Error", data = "ERROR"}
        },
        default = "INFO"
    }, {
        name = "show_zero_counts",
        label = "Show zero-count items",
        hover = "When reporting item counts, also show items of which none are found.",
        options = {
            {description = "Yes", data = true},
            {description = "No", data = false}
        },
        default = true
    }, {
        name = "title_show_counts",
        label = "Show Counts",
        hover = "",
        options = {{description = "", data = ""}},
        default = ""
    }, {
        name = "count_trap_starfish",
        label = "Anenemies",
        hover = "Count number of anenemies in the world.",
        options = {
            {description = "Yes", data = true},
            {description = "No", data = false}
        },
        default = true
    }, {
        name = "count_beefalo",
        label = "Beefalos",
        hover = "Count number of beefalos in the world.",
        options = {
            {description = "Yes", data = true},
            {description = "No", data = false}
        },
        default = true
    }, {
        name = "count_beehive",
        label = "Beehives",
        hover = "Count number of beehives in the world.",
        options = {
            {description = "Yes", data = true},
            {description = "No", data = false}
        },
        default = true
    }, {
        name = "count_berrybushes",
        label = "Berry Bushes",
        hover = "Count number of berry bushes (normal and leafy) in the world.",
        options = {
            {description = "Yes", data = true},
            {description = "No", data = false}
        },
        default = true
    }, {
        name = "count_chessjunk",
        label = "Broken Clockworks",
        hover = "Count number of broken clockworks in the world.",
        options = {
            {description = "Yes", data = true},
            {description = "No", data = false}
        },
        default = true
    }, {
        name = "count_clockworks",
        label = "Clockworks",
        hover = "Count number of clockworks (enemy knight, rook, bishop) in the world.",
        options = {
            {description = "Yes", data = true},
            {description = "No", data = false}
        },
        default = true
    }, {
        name = "count_berrybush_juicy",
        label = "Juicy Berry Bushes",
        hover = "Count number of juicy berry bushes in the world.",
        options = {
            {description = "Yes", data = true},
            {description = "No", data = false}
        },
        default = true
    }, {
        name = "count_wasphive",
        label = "Killer Beehives",
        hover = "Count number of killer beehives in the world.",
        options = {
            {description = "Yes", data = true},
            {description = "No", data = false}
        },
        default = true
    }, {
        name = "count_mandrake_planted",
        label = "Mandrakes",
        hover = "Count number of planted mandrakes in the world.",
        options = {
            {description = "Yes", data = true},
            {description = "No", data = false}
        },
        default = true
    }, {
        name = "count_marblepillar",
        label = "Marble Pillars",
        hover = "Count number of marble pillars in the world.",
        options = {
            {description = "Yes", data = true},
            {description = "No", data = false}
        },
        default = true
    }, {
        name = "count_marble_statues",
        label = "Marble Statues",
        hover = "Count number of marble statues in the world.",
        options = {
            {description = "Yes", data = true},
            {description = "No", data = false}
        },
        default = true
    }, {
        name = "count_marbletree",
        label = "Marble Trees",
        hover = "Count number of marble trees in the world.",
        options = {
            {description = "Yes", data = true},
            {description = "No", data = false}
        },
        default = true
    }, {
        name = "count_statuemaxwell",
        label = "Maxwell Statues",
        hover = "Count number of Maxwell statues in the world.",
        options = {
            {description = "Yes", data = true},
            {description = "No", data = false}
        },
        default = true
    }, {
        name = "count_mermhouse",
        label = "Merm Houses",
        hover = "Count number of merm houses in the world.",
        options = {
            {description = "Yes", data = true},
            {description = "No", data = false}
        },
        default = true
    }, {
        name = "count_pighouse",
        label = "Pig Houses",
        hover = "Count number of pig houses in the world.",
        options = {
            {description = "Yes", data = true},
            {description = "No", data = false}
        },
        default = true
    }, {
        name = "count_rabbithouse",
        label = "Rabbit Hutches",
        hover = "Count number of rabbit hutches/houses in the world.",
        options = {
            {description = "Yes", data = true},
            {description = "No", data = false}
        },
        default = true
    }, {
        name = "count_reeds",
        label = "Reeds",
        hover = "Count number of reeds in the world.",
        options = {
            {description = "Yes", data = true},
            {description = "No", data = false}
        },
        default = true
    }, {
        name = "count_sapling",
        label = "Saplings",
        hover = "Count number of saplings in the world.",
        options = {
            {description = "Yes", data = true},
            {description = "No", data = false}
        },
        default = true
    }, {
        name = "count_rock_avocado_bush",
        label = "Stone Fruit Bushes",
        hover = "Count number of stone fruit bushes in the world.",
        options = {
            {description = "Yes", data = true},
            {description = "No", data = false}
        },
        default = true
    }, {
        name = "count_lightninggoat",
        label = "Volt Goats",
        hover = "Count number of in the world.",
        options = {
            {description = "Yes", data = true},
            {description = "No", data = false}
        },
        default = true
    }, {
        name = "count_walrus_camp",
        label = "Walrus Camps",
        hover = "Count number of walrus camps in the world.",
        options = {
            {description = "Yes", data = true},
            {description = "No", data = false}
        },
        default = true
    }, {
        name = "count_wormhole",
        label = "Wormholes",
        hover = "Count number of wormholes in the world.",
        options = {
            {description = "Yes", data = true},
            {description = "No", data = false}
        },
        default = true
    }
}
