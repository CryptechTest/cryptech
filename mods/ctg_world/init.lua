local S = minetest.get_translator("ctg_world")
local ui = unified_inventory

-- load files
local default_path = minetest.get_modpath("ctg_world")
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
dofile(default_path .. DIR_DELIM .. "loot.lua")
dofile(default_path .. DIR_DELIM .. "commands.lua")
dofile(default_path .. DIR_DELIM .. "vehicles.lua")
dofile(default_path .. DIR_DELIM .. "cotton.lua")
dofile(default_path .. DIR_DELIM .. "awards.lua")
local function give_or_drop_item(player, itemstack)
    local inv = minetest.get_inventory({
        type = "player",
        name = player:get_player_name()
    })
    local remaining = inv:add_item("main", itemstack)
    minetest.add_item(player:get_pos(), remaining)
end

-- allow player to use an air bottle to fill their suit
local function refill_player_suit(itemstack, player, pointed_thing)
    local name, invs = armor:get_valid_player(player, "[refill_spacesuit]")
    if not name then
        return
    end
    for i, item in ipairs(invs:get_list("armor")) do
        if item and item:get_name() ~= "" then
            if item:get_name() == "spacesuit:helmet_base" or item:get_name() == "spacesuit:chestplate_base" or
                item:get_name() == "spacesuit:pants_base" or item:get_name() == "spacesuit:boots_base" then
                local max_refill = math.min(item:get_wear(), 65535)
                armor:damage(player, i, item, -max_refill)
            end
        end
    end

    itemstack:set_count(itemstack:get_count() - 1)
    give_or_drop_item(player, "vessels:steel_bottle")
    return itemstack
end

minetest.override_item("vacuum:air_bottle", {
    on_secondary_use = refill_player_suit,
    on_place = refill_player_suit
})

minetest.register_on_newplayer(function(player)
    local inv = player:get_inventory()
    inv:add_item("main", "default:pick_diamond")
    inv:add_item("main", "default:shovel_diamond")
    inv:add_item("main", "default:torch")
    inv:add_item("main", "mesecons_torch:mesecon_torch_on")
    inv:add_item("main", "ctg_jetpack:jetpack_copper")
    inv:add_item("main", "vacuum:air_bottle 1")
    inv:add_item("main", "mobs:meat 5")
    inv:add_item("main", "ctg_world:coffee_cup_hot_3 3")
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
    local spawn = beds.spawn[player_name]
    if spawn == nil then
        local inv = player:get_inventory()
        armor:remove_all(player)
        inv:add_item("main", "default:pick_diamond")
        inv:add_item("main", "default:shovel_diamond")
        inv:add_item("main", "default:torch")
        inv:add_item("main", "mesecons_torch:mesecon_torch_on")
        inv:add_item("main", "ctg_jetpack:jetpack_copper")
        inv:add_item("main", "vacuum:air_bottle 1")
        inv:add_item("main", "mobs:meat 5")
        inv:add_item("main", "ctg_world:coffee_cup_hot_3 3")

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
            player:set_velocity({ 0, 0, 0 })
        end
    end)
    return true
end)
