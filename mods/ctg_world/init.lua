local S = minetest.get_translator("ctg_world")
local ui = unified_inventory

-- load files
local default_path = minetest.get_modpath("ctg_world")
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
if core.get_modpath("dungeon_loot") then
    dofile(default_path .. DIR_DELIM .. "loot.lua")
end
if core.get_modpath("vehicles") then
    dofile(default_path .. DIR_DELIM .. "vehicles.lua")
end
if core.get_modpath("x_farming") then
    dofile(default_path .. DIR_DELIM .. "cotton.lua")
end
if core.get_modpath("awards") then
    dofile(default_path .. DIR_DELIM .. "awards.lua")
end
dofile(default_path .. DIR_DELIM .. "doors.lua")

minetest.register_on_newplayer(function(player)
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
    minetest.after(2, function()
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
            minetest.after(0, function()
                player:set_pos(spawn_pos_str)
            end)
        else
            minetest.after(0, function()
                player:set_pos(minetest.setting_get_pos("static_spawnpoint") or {
                    x = 0,
                    y = 4500,
                    z = 0
                })
            end)
        end
    end
end)

-- Respawn player function

minetest.register_on_respawnplayer(function(player)
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
        player:set_pos(minetest.setting_get_pos("static_spawnpoint") or {
            x = 0,
            y = 4500,
            z = 0
        })
    end
    minetest.after(0.2, function()
        -- reset player velocity.
        if player then
            player:set_velocity({0, 0, 0})
        end
    end)
    return true
end)
