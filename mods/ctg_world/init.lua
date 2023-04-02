local ui = unified_inventory

local function give_or_drop_item(player, itemstack)
    local inv = minetest.get_inventory({type="player", name=player:get_player_name()})
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
			if item:get_name() == "spacesuit:helmet_base" or
			   item:get_name() == "spacesuit:chestplate_base" or
			   item:get_name() == "spacesuit:pants_base" or
			   item:get_name() == "spacesuit:boots_base" then
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
	on_place = refill_player_suit,
})


minetest.register_on_newplayer(function(player)
    local inv = player:get_inventory()
    inv:add_item("main", "default:pick_diamond")
    inv:add_item("main", "default:shovel_diamond")
    inv:add_item("main", "default:torch")        
    inv:add_item("main", "sum_jetpack:jetpack")
    inv:add_item("main", "sum_jetpack:jetpack_fuel 2")
    inv:add_item("main", "vacuum:air_bottle 1")
    inv:add_item("main", "mobs:meat 5")
    local player = player
    -- 3d_armor´s inventory is not fully set up in the beginning. They use a delay of 0, so we wait a bit for them and afterwards equip the spacesuit.
    minetest.after(2, function()
        armor:equip(player, ItemStack("spacesuit:helmet_base"))
        armor:equip(player, ItemStack("spacesuit:chestplate_base"))
        armor:equip(player, ItemStack("spacesuit:pants_base"))
        armor:equip(player, ItemStack("spacesuit:boots_base"))
        
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
                player:set_pos(minetest.setting_get_pos("static_spawnpoint") or {x = 0, y = 4500, z = 0})
            end)
        end
    end
    
    
end)



-- Respawn player function

minetest.register_on_respawnplayer(function(player)  
    local hasMobs = minetest.get_modpath("mobs")
    if hasMobs then mobs.detach(player) end
    local player_name = player:get_player_name()
    local home = ui.home_pos[player_name]
    if home ~= nil then
		player:set_pos(home)       
		return true
    else 
        local inv = player:get_inventory()
        armor:remove_all(player)
        inv:add_item("main", "default:pick_diamond")
        inv:add_item("main", "default:shovel_diamond")
        inv:add_item("main", "default:torch")        
        inv:add_item("main", "sum_jetpack:jetpack")
        inv:add_item("main", "sum_jetpack:jetpack_fuel 2")
        inv:add_item("main", "vacuum:air_bottle 1")
        inv:add_item("main", "mobs:meat 5")
        
        armor:equip(player, ItemStack("spacesuit:helmet_base"))
        armor:equip(player, ItemStack("spacesuit:chestplate_base"))
        armor:equip(player, ItemStack("spacesuit:pants_base"))
        armor:equip(player, ItemStack("spacesuit:boots_base"))
        player:set_pos(minetest.setting_get_pos("static_spawnpoint") or {x = 0, y = 4500, z = 0})
	end    
	return true
end)