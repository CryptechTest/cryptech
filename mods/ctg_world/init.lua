local S = core.get_translator("ctg_world")
local ui = unified_inventory

-- load files
local default_path = core.get_modpath("ctg_world")
dofile(default_path .. DIR_DELIM .. "commands.lua")
dofile(default_path .. DIR_DELIM .. "coregen.lua")
dofile(default_path .. DIR_DELIM .. "atmosgen.lua")
dofile(default_path .. DIR_DELIM .. "biomes.lua")
dofile(default_path .. DIR_DELIM .. "resources.lua")
dofile(default_path .. DIR_DELIM .. "resources_core.lua")
dofile(default_path .. DIR_DELIM .. "plants.lua")
dofile(default_path .. DIR_DELIM .. "berries.lua")
dofile(default_path .. DIR_DELIM .. "mapgen.lua")
dofile(default_path .. DIR_DELIM .. "mapgen_border.lua")
dofile(default_path .. DIR_DELIM .. "mapgen_decor.lua")
dofile(default_path .. DIR_DELIM .. "items.lua")
dofile(default_path .. DIR_DELIM .. "lamps.lua")
if core.get_modpath("dungeon_loot") then
    dofile(default_path .. DIR_DELIM .. "loot.lua")
end
if core.get_modpath("vehicle_mash") then
    dofile(default_path .. DIR_DELIM .. "vehicles.lua")
end
if core.get_modpath("x_farming") then
    dofile(default_path .. DIR_DELIM .. "cotton.lua")
end
if core.get_modpath("awards") then
    dofile(default_path .. DIR_DELIM .. "awards.lua")
end
dofile(default_path .. DIR_DELIM .. "doors.lua")

core.register_on_newplayer(function(player)
    local inv = player:get_inventory()
    inv:add_item("main", "default:pick_diamond")
    inv:add_item("main", "default:shovel_diamond")
    inv:add_item("main", "default:torch")
    inv:add_item("main", "mesecons_torch:mesecon_torch_on")
    inv:add_item("main", "ctg_jetpack:jetpack_copper")
    inv:add_item("main", "vacuum:air_bottle 1")
    if core.get_modpath("mobs") then
        inv:add_item("main", "mobs:meat 5")
    end
    if core.get_modpath("bottles") then
        inv:add_item("main", "ctg_world:coffee_cup_hot_3 3")
    end

    local player = player
    -- 3d_armor´s inventory is not fully set up in the beginning. They use a delay of 0, so we wait a bit for them and afterwards equip the spacesuit.
    core.after(2, function()
        armor:equip(player, ItemStack("spacesuit:helmet_base"))
        armor:equip(player, ItemStack("spacesuit:chestplate_base"))
        armor:equip(player, ItemStack("spacesuit:pants_base"))
        armor:equip(player, ItemStack("spacesuit:boots_base"))
        -- armor:equip(player, ItemStack("ctg_jetpack:jetpack_iron"))
    end)

    local has_spawned = player:get_attribute("has_spawned")
    if not has_spawned then
        player:set_attribute("has_spawned", "true")
        local spawn_pos_str = player:get_attribute("spawn")

        if spawn_pos_str ~= nil and spawn_pos_str ~= "" then
            core.after(0, function()
                player:set_pos(spawn_pos_str)
            end)
        else
            core.after(0, function()
                player:set_pos(core.setting_get_pos("static_spawnpoint") or {
                    x = 0,
                    y = 4500,
                    z = 0
                })
            end)
        end
    end
end)

-- Respawn player function

core.register_on_respawnplayer(function(player)
    local player_name = player:get_player_name()
    local spawn = nil
    if core.get_modpath("beds") then
        if beds ~= nil then
            spawn = beds.spawn[player_name]
        end
    end
    if spawn == nil then
        local inv = player:get_inventory()
        armor:remove_all(player)
        inv:add_item("main", "default:pick_diamond")
        inv:add_item("main", "default:shovel_diamond")
        inv:add_item("main", "default:torch")
        inv:add_item("main", "mesecons_torch:mesecon_torch_on")
        inv:add_item("main", "ctg_jetpack:jetpack_copper")
        inv:add_item("main", "vacuum:air_bottle 1")
        if core.get_modpath("mobs") then
            inv:add_item("main", "mobs:meat 5")
        end
        if core.get_modpath("bottles") then
            inv:add_item("main", "ctg_world:coffee_cup_hot_3 3")
        end

        armor:equip(player, ItemStack("spacesuit:helmet_base"))
        armor:equip(player, ItemStack("spacesuit:chestplate_base"))
        armor:equip(player, ItemStack("spacesuit:pants_base"))
        armor:equip(player, ItemStack("spacesuit:boots_base"))
        -- armor:equip(player, ItemStack("ctg_jetpack:jetpack_iron"))
        player:set_pos(core.setting_get_pos("static_spawnpoint") or {
            x = 0,
            y = 4500,
            z = 0
        })
    end
    core.after(0.2, function()
        -- reset player velocity.
        if player then
            player:set_velocity({0, 0, 0})
        end
    end)
    return true
end)

-- uranium ore fix

local stones = {"default:stone", "ctg_world:corestone"}
local uranium_params = {
	offset = 0,
	scale = 1,
	spread = {x = 100, y = 100, z = 100},
	seed = 420,
	octaves = 3,
	persist = 0.7
}
local uranium_threshold = 0.55

minetest.register_ore({
	ore_type = "scatter",
	ore = "technic:mineral_uranium",
	wherein = stones,
	clust_scarcity = 8*8*8,
	clust_num_ores = 5,
	clust_size = 3,
	y_min = -3000,
	y_max = -300,
	noise_params = uranium_params,
	noise_threshold = uranium_threshold,
})

minetest.register_ore({
	ore_type = "scatter",
	ore = "technic:mineral_uranium",
	wherein = stones,
	clust_scarcity = 7*7*7,
	clust_num_ores = 5,
	clust_size = 3,
	y_min = -10000,
	y_max = -3000,
	noise_params = uranium_params,
	noise_threshold = uranium_threshold,
})
