Prefab Counter
==================

Easily count a configurable list of prefabs/items in a world, like walrus camps,
amount of reeds, etc., to quickly check if a generated world is worth playing.

Just run `PC:Count()` in the remote console to show a fresh count of the items in the current shard.

- [Prefab Counter](#prefab-counter)
  - [Features and Usage](#features-and-usage)
  - [Installation and Setup](#installation-and-setup)
    - [Mod Installation using the Steam Workshop](#mod-installation-using-the-steam-workshop)
      - [Edit dedicated_server_mods_setup.lua in mods directory](#edit-dedicated_server_mods_setuplua-in-mods-directory)
      - [Edit modoverrides.lua in server/shard directory](#edit-modoverrideslua-in-servershard-directory)
    - [Mod Installation Without Steam Workshop](#mod-installation-without-steam-workshop)
  - [Roadmap](#roadmap)
  - [Acknowledgements](#acknowledgements)
    - [Source Code](#source-code)
  - [Changelog](#changelog)
    - [Version 1.0.2 (2021-10-06)](#version-102-2021-10-06)
    - [Version 1.0.1 (2021-10-04)](#version-101-2021-10-04)
    - [Version 1.0.0 (2021-10-03)](#version-100-2021-10-03)


Features and Usage
------------------

The **Prefab Counter** mod is purely server-side, intended to be used by a server admin to get a quick overview over the generated Overworld and Caves to see at a glance if worlds have been generated with enough resources for the intended playstyle. Typically, one could be interested in the number of walrus camps, reeds, marble sources, or planted mandrakes, and if the world spawned with too little of a resource, a new chance is just a simple world regeneration away. Go ahead, whisk away the lives of every single soul inhabiting the constant, without a second thought.

To count the configured items/prefabs in the shard you're currently in, simply run `PC:Count()` in the Remote Console as an admin, and the results will be printed to the chat and server log as a system message. After the results fade out, you can open the chat again (default key: `Y`) to see the text for as long as you need to ponder bringing armageddon upon the world. You monster.

Certain items only ever spawn in the Caves, so if you're interested in those, you'll have to enter the Caves first and run the same command there to count again in that shard. The same applies to any other shards you may have set up in a multi-shard cluster.

The mod can count the following items, prefab names given for reference:

  - Anememies ("trap_starfish")
  - Beefalos ("beefalo")
  - Beehives ("beehive")
  - Berry Bushes ("berrybush", "berrybush2")
  - Broken Clockworks ("chessjunk1", "chessjunk2", "chessjunk3")
  - Clockworks ("knight", "bishop", "rook", "knight_nightmare", "bishop_nightmare", "rook_nightmare")
  - Juicy Berry Bushes ("berrybush_juicy")
  - Killer Beehives ("wasphive")
  - Lureplants ("lureplant")
  - Mandrakes ("mandrake_planted")
  - Marble Pillars ("marblepillar")
  - Marble Statues ("statue_marble", "statue_marble_muse", "statue_marble_pawn")
  - Marble Trees ("marbletree")
  - Maxwell Statues ("statuemaxwell")
  - Merm Houses ("mermhouse")
  - Pig Houses ("pighouse")
  - Rabbit Hutches ("rabbithouse")
  - Reeds ("reeds", "reeds_water")
  - Saplings ("sapling")
  - Stone Fruit Bushes ("rock_avocado_bush")
  - Volt Goats ("lightninggoat")
  - Walrus Camps ("walrus_camp")
  - Wormholes ("wormhole")

**Counting any of these items can be disabled** in the configuration as required, all items are counted by default. You may also **choose to not show any item with a zero count** to reduce the amount of text to read. By default, however, all results will be shown.

The **log level** can safely be left alone on the default `Info`, but if you want detailed tracing or debug information printed in the server's logfile, feel free to lower the severity to `Debug` or even `Trace`, for example to verify your configuration settings being set correctly on a dedicated server.


Installation and Setup
----------------------

Please follow generic installation instructions on how to install a mod on your dedicated or
client-hosted server, this mod works exactly the same as any other mod in that regard.

### Mod Installation using the Steam Workshop

#### Edit dedicated_server_mods_setup.lua in mods directory

Add this snippet to the file `<dedicated_server_install>/mods/dedicated_server_mods_setup.lua` to automatically let the server download the mod from the Steam Workshop on boot. This does not activate the mod, yet.

```lua
-- Prefab Counter by Gyroplast
-- https://steamcommunity.com/sharedfiles/filedetails/?id=2618765953
ServerModSetup("2618765953")
```

#### Edit modoverrides.lua in server/shard directory

Add configuration options and enable the mod in the server's `modoverrides.lua` file. Please note that this file is server specific! As Overworld and Caves are technically two independent servers, you will generally want to modify this file in at least two locations, most of the time identically, unless you want differing configuration for any mod from Caves to Overworld.

Below is a commented, comprehensive default configuration for this mod that can be copied into the file directly to configure the Steam Workshop installation of the mod.

```lua
  -- Prefab Counter by Gyroplast
  -- https://steamcommunity.com/sharedfiles/filedetails/?id=2618765953
  ["workshop-2618765953"]={
    configuration_options={
      log_level="INFO",  -- server log level: TRACE, DEBUG, INFO, WARN, ERROR
      show_zero_counts=true,  -- when reporting item counts, also show items of which none are found
      -- enable or disable counting of individual prefabs
      count_beefalo=true,            -- Beefalos ("beefalo")
      count_beehive=true,            -- Beehives ("beehive")
      count_berrybush_juicy=true,    -- Juicy Berry Bushes ("berrybush_juicy")
      count_berrybushes=true,        -- Berry Bushes ("berrybush", "berrybush2")
      count_chessjunk=true,          -- Broken Clockworks ("chessjunk1", "chessjunk2", "chessjunk3")
      count_clockworks=true,         -- Clockworks ("knight", "bishop", "rook", "knight_nightmare", "bishop_nightmare", "rook_nightmare")
      count_lightninggoat=true,      -- Volt Goats ("lightninggoat")
      count_lureplant=true,          -- Lureplant ("lureplant")
      count_mandrake_planted=true,   -- Mandrakes ("mandrake_planted")
      count_marble_statues=true,     -- Marble Statues ("statue_marble", "statue_marble_muse", "statue_marble_pawn")
      count_marblepillar=true,       -- Marble Pillars ("marblepillar")
      count_marbletree=true,         -- Marble Trees ("marbletree")
      count_mermhouse=true,          -- Merm Houses ("mermhouse")
      count_pighouse=true,           -- Pig Houses ("pighouse")
      count_rabbithouse=true,        -- Rabbit Hutches ("rabbithouse")
      count_reeds=true,              -- Reeds ("reeds", "reeds_water")
      count_rock_avocado_bush=true,  -- Stone Fruit Bushes ("rock_avocado_bush")
      count_sapling=true,            -- Saplings ("sapling")
      multicount_spiders=true,       -- Spider Den 1/2/3/Queen/Eggs ("spiderden"/"spiderden_2"/"spiderden_3"/"spiderqueen"/"spidereggsack")
      count_statuemaxwell=true,      -- Maxwell Statues ("statuemaxwell")
      count_trap_starfish=true,      -- Anememies ("trap_starfish")
      count_walrus_camp=true,        -- Walrus Camps ("walrus_camp")
      count_wasphive=true,           -- Killer Beehives ("wasphive")
      count_wormhole=true,           -- Wormholes ("wormhole")
    },
    enabled=true
  },
```

### Mod Installation Without Steam Workshop

If you prefer to install the mod without using the Steam Workshop, download the release you want as an archive, and extract it into the `mods` directory in the dedicated server installation directory, where the `dedicated_server_mods_setup.lua` file resides. After extraction, you should have a new directory for the mod in the `mods` directory, named `Prefab_Counter-<version>`, similar to this:

```
.../
    Don't Starve Together Dedicated Server/
        mods/
            Prefab_Counter-1.0.2/
                lib/
                LICENSE
                modicon.tex
                modicon.xml
                modinfo.lua
                modmain.lua
                README.md
            INSTALLING_MODS.txt
            MAKING_MODS.txt
            dedicated_server_mods_setup.lua
            modsettings.lua
```

Take note of the *exact* name of the mod directory, `Prefab_Counter-1.0.2` in this example. The mod configuration must refer to this exact, case-sensitive directory name. The actual directory name is not important, but it must be consistent with the `modoverrides.lua` entry for the mod, otherwise the server will not be able to associate the configuration with the mod, and the mod will stay disabled entirely.

To achieve the required consistency, you may now either just rename the mod directory to `workshop-2618765953`, and edit the `modoverrides.lua` files exactly as described in the [Steam Workshop Installation above](#edit-modoverrideslua-in-servershard-directory), 

**OR**

replace the `workshop-2618765953` reference in the `modoverrides.lua` file with the exact, case-sensitive name of the mod, i. e. `Prefab_Counter-1.0.2` in this case, like this:

```lua
  -- Prefab Counter by Gyroplast
  -- https://steamcommunity.com/sharedfiles/filedetails/?id=2618765953
  ["Prefab_Counter-1.0.2"]={
    configuration_options={
      [""]="",
      ...
```

**Do not edit the `dedicated_server_mods_setup.lua` file to include the `ServerModSetup("2618765953")` line.**

The `ServerModSetup`'s *only job* is to download the mod files from the Steam Workshop, which is unnecessary after downloading, extracting, and placing the mod files manually.
In fact, if you renamed the directory to `workshop-2618765953`, leaving the `ServerModSetup` line active would overwrite the manually installed mod with the Steam Workshop version on server start, so ensure there is no `ServerModSetup("2618765953")` line in the `dedicated_server_mods_setup.lua` file, or leave the mod directory name as-is.


Roadmap
-------

This is a list of changes and features that are planned to be implemented,
in no particular order.

- [ ] port to single-player Dont' Starve and DLCs
- [ ] check if and how set pieces and biomes can be counted


Acknowledgements
--------------

### Source Code

Please see the enclosed [license file](LICENSE),
applicable to the sources unless noted otherwise. Mod sources are hosted on
[GitHub](https://github.com/gyroplast/mod-dont-starve-prefab-counter).


Changelog
---------

### Version 1.0.2 (2021-10-06)
  **Bugfixes**
  - server crash when run with Chat Announcements 1.2.0    
    Fixes [#1](https://github.com/gyroplast/mod-dont-starve-prefab-counter/issues/1).
  - count correct prefab for saplings    
    Fixes [#2](https://github.com/gyroplast/mod-dont-starve-prefab-counter/issues/2).

### Version 1.0.1 (2021-10-04)
  - Initial Public Release, added Steam ID

### Version 1.0.0 (2021-10-03)
  - Initial Hidden Release
