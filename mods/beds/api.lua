local S = minetest.get_translator("beds")
local reverse = true

local function destruct_bed(pos, n)
	local node = minetest.get_node(pos)

	local other

	if n == 2 then
		local dir = minetest.facedir_to_dir(node.param2)
		other = vector.subtract(pos, dir)
	elseif n == 1 then
		local dir = minetest.facedir_to_dir(node.param2)
		other = vector.add(pos, dir)
	end

	if reverse then
		reverse = not reverse
		minetest.remove_node(other)
		minetest.check_for_falling(other)
		beds.remove_spawns_at(pos)
		beds.remove_spawns_at(other)
	else
		reverse = not reverse
	end
	local player_name = beds.player_bed[minetest.serialize(pos)]
	if player_name then
		local player = minetest.get_player_by_name(player_name)
		if player ~= nil then
			for i = 1, 24 do
				local inv = player:get_inventory()
				local bed = inv:get_stack("beds", i)
				if not bed:is_empty() then
					local meta = bed:get_meta()
					local ppos = meta:get_string("pos")
					if minetest.serialize(pos) == ppos then
						minetest.log("bed:" .. bed:get_description())
						inv:remove_item("beds", bed)
						beds.bed_cooldown[minetest.serialize(pos)] = false
					end
				end
			end
			unified_inventory.set_inventory_formspec(player, unified_inventory.current_page[player_name])
		end
	end
end

function beds.register_bed(name, def)
	minetest.register_node(name .. "_bottom", {
		description = def.description,
		inventory_image = def.inventory_image,
		wield_image = def.wield_image,
		drawtype = "nodebox",
		tiles = def.tiles.bottom,
		use_texture_alpha = "clip",
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		stack_max = 1,
		groups = { choppy = 2, oddly_breakable_by_hand = 2, flammable = 3, bed = 1 },
		sounds = def.sounds or default.node_sound_wood_defaults(),
		node_box = {
			type = "fixed",
			fixed = def.nodebox.bottom,
		},
		selection_box = {
			type = "fixed",
			fixed = def.selectionbox,
		},
		on_place = function(itemstack, placer, pointed_thing)
			local under = pointed_thing.under
			local node = minetest.get_node(under)
			local udef = minetest.registered_nodes[node.name]
			if udef and udef.on_rightclick and
				not (placer and placer:is_player() and
				placer:get_player_control().sneak) then
				return udef.on_rightclick(under, node, placer, itemstack,
						pointed_thing) or itemstack
			end

			local pos
			if udef and udef.buildable_to then
				pos = under
			else
				pos = pointed_thing.above
			end

			local player_name = placer and placer:get_player_name() or ""

			if minetest.is_protected(pos, player_name) and
				not minetest.check_player_privs(player_name, "protection_bypass") then
				minetest.record_protection_violation(pos, player_name)
				return itemstack
			end

			local node_def = minetest.registered_nodes[minetest.get_node(pos).name]
			if not node_def or not node_def.buildable_to then
				return itemstack
			end

			local dir = placer and placer:get_look_dir() and
				minetest.dir_to_facedir(placer:get_look_dir()) or 0
			local botpos = vector.add(pos, minetest.facedir_to_dir(dir))

			if minetest.is_protected(botpos, player_name) and
				not minetest.check_player_privs(player_name, "protection_bypass") then
				minetest.record_protection_violation(botpos, player_name)
				return itemstack
			end

			local botdef = minetest.registered_nodes[minetest.get_node(botpos).name]
			if not botdef or not botdef.buildable_to then
				return itemstack
			end

			minetest.set_node(pos, { name = name .. "_bottom", param2 = dir })
			minetest.set_node(botpos, { name = name .. "_top", param2 = dir })
			beds.spawn[player_name] = { x = pos.x, y = pos.y + 1, z = pos.z }
			local inv = placer:get_inventory()
			local slot = 0
			for i = 1, 24 do
				local bed = inv:get_stack("beds", i)
				if bed:is_empty() then
					slot = i
					break
				end
			end
			if slot > 0 then
				local bed = ItemStack(name .. "_bottom", 1)
				local meta = bed:get_meta()
				meta:set_string("description", S("bed") .. slot)
				meta:set_string("pos", minetest.serialize(pos))
				inv:set_stack("beds", slot, bed)
				beds.player_bed[minetest.serialize(pos)] = player_name
				beds.bed_cooldown[minetest.serialize(pos)] = false
				minetest.after(0, function()
					unified_inventory.set_inventory_formspec(placer, unified_inventory.current_page[player_name])
				end)
				local node_meta = minetest.get_meta(pos)
				node_meta:set_string("infotext", S("Owner: ") .. player_name)
			end
			if not minetest.is_creative_enabled(player_name) then
				itemstack:take_item()
			end
			return itemstack
		end,
		on_destruct = function(pos)
			destruct_bed(pos, 1)
		end,
		on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
			beds.on_rightclick(pos, clicker)
			return itemstack
		end,
		on_rotate = function(pos, node, user, _, new_param2)
			local dir = minetest.facedir_to_dir(node.param2)
			local p = vector.add(pos, dir)
			local node2 = minetest.get_node_or_nil(p)
			if not node2 or not minetest.get_item_group(node2.name, "bed") == 2 or
				not node.param2 == node2.param2 then
				return false
			end
			if minetest.is_protected(p, user:get_player_name()) then
				minetest.record_protection_violation(p, user:get_player_name())
				return false
			end
			if new_param2 % 32 > 3 then
				return false
			end
			local newp = vector.add(pos, minetest.facedir_to_dir(new_param2))
			local node3 = minetest.get_node_or_nil(newp)
			local node_def = node3 and minetest.registered_nodes[node3.name]
			if not node_def or not node_def.buildable_to then
				return false
			end
			if minetest.is_protected(newp, user:get_player_name()) then
				minetest.record_protection_violation(newp, user:get_player_name())
				return false
			end
			node.param2 = new_param2
			-- do not remove_node here - it will trigger destroy_bed()
			minetest.set_node(p, { name = "air" })
			minetest.set_node(pos, node)
			minetest.set_node(newp, { name = name .. "_top", param2 = new_param2 })
			return true
		end,
		can_dig = function(pos, player)
			return beds.can_dig(pos)
		end,
	})

	minetest.register_node(name .. "_top", {
		drawtype = "nodebox",
		tiles = def.tiles.top,
		use_texture_alpha = "clip",
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		pointable = false,
		groups = {
			choppy = 2,
			oddly_breakable_by_hand = 2,
			flammable = 3,
			bed = 2,
			not_in_creative_inventory = 1
		},
		sounds = def.sounds or default.node_sound_wood_defaults(),
		drop = name .. "_bottom",
		node_box = {
			type = "fixed",
			fixed = def.nodebox.top,
		},
		on_destruct = function(pos)
			destruct_bed(pos, 2)
		end,
		can_dig = function(pos, player)
			local node = minetest.get_node(pos)
			local dir = minetest.facedir_to_dir(node.param2)
			local p = vector.add(pos, dir)
			return beds.can_dig(p)
		end,
	})

	minetest.register_alias(name, name .. "_bottom")

	minetest.register_craft({
		output = name,
		recipe = def.recipe
	})
end
