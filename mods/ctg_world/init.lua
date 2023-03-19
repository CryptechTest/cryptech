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
			if item:get_name() == "spacesuit:helmet" or
			   item:get_name() == "spacesuit:chestplate" or
			   item:get_name() == "spacesuit:pants" or
			   item:get_name() == "spacesuit:boots" then
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

minetest.register_on_player_hpchange(function(player, hp_change, reason)
    if reason.type == "fall" and hp_change < 0 then
        -- Check if player is falling into water
        local pos = player:get_pos()
        local node = minetest.get_node({x = pos.x, y = pos.y, z = pos.z})
        local node_def = minetest.registered_nodes[node.name]
        local node_below = minetest.get_node({x = pos.x, y = pos.y - 1, z = pos.z})
        local node_below_def = minetest.registered_nodes[node_below.name]
        if node_def and node_def.groups then
            -- Access the group values for the node definition
            local group_value = node_def.groups["liquid"]
            if group_value then
                -- Do something based on the group value
                return 0
            end
        elseif node_below_def and node_below_def.groups then
            -- Access the group values for the node definition
            local group_value = node_def.groups["liquid"]
            if group_value then
                -- Do something based on the group value
                return 0
            end
        end
    end
end)

minetest.register_on_joinplayer(function(player)
    local has_received_items = player:get_attribute("has_received_items")
    if not has_received_items then
        local inv = player:get_inventory()
        inv:add_item("main", "default:pick_diamond")
        inv:add_item("main", "vacuum:air_bottle 5")
        inv:add_item("main", "animalia:beef_cooked 5")
        player:set_attribute("has_received_items", "true")
        --inv:add_item("main", "default:shovel_diamond 4")
        --inv:add_item("main", "farming:hoe_diamond 4")
        local player = player
        -- 3d_armor´s inventory is not fully set up in the beginning. They use a delay of 0, so we wait a bit for them and afterwards equip the spacesuit.
        minetest.after(2, function()
            armor:equip(player, ItemStack("spacesuit:helmet"))
            armor:equip(player, ItemStack("spacesuit:chestplate"))
            armor:equip(player, ItemStack("spacesuit:pants"))
            armor:equip(player, ItemStack("spacesuit:boots"))
            
        end)
        
    end
    local has_spawned = player:get_attribute("has_spawned")
    if not has_spawned then 
        player:set_attribute("has_spawned", "true")
        local spawn_pos_str = player:get_attribute("spawn")

        if spawn_pos_str ~= nil and spawn_pos_str ~= "" then
            minetest.after(2, function()
                player:set_pos(spawn_pos_str)
            end)
        else
            minetest.after(2, function()
                player:set_pos(minetest.setting_get_pos("static_spawnpoint") or {x = 0, y = 27000, z = 0})
            end)
        end
    end
    
    
end)



-- Respawn player function

minetest.register_on_respawnplayer(function(player)
	local inv = player:get_inventory()
	inv:add_item("main", "vacuum:air_bottle 2")
    inv:add_item("main", "animalia:beef_cooked 2")
	armor:remove_all(player)
	armor:equip(player, ItemStack("spacesuit:helmet"))
	armor:equip(player, ItemStack("spacesuit:chestplate"))
	armor:equip(player, ItemStack("spacesuit:pants"))
	armor:equip(player, ItemStack("spacesuit:boots"))
	return true
end)