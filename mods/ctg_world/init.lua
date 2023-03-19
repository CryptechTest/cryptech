-- Spawn newplayer function

minetest.register_on_newplayer(function(player)
	--local inv = player:get_inventory()
	--inv:add_item("main", "default:pick_diamond 4")
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

end)