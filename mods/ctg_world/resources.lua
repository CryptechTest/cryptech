
local S = minetest.get_translator(minetest.get_current_modname())

minetest.register_node("ctg_world:stone_with_titanium", {
	description = S("Titanium Ore"),
	tiles = {"default_stone.png^ctg_mineral_titanium.png"},
	groups = {cracky = 2},
	drop = "ctg_world:titanium_lump",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("ctg_world:desert_stone_with_titanium", {
	description = S("Titanium Ore"),
	tiles = {"default_desert_stone.png^ctg_mineral_titanium.png"},
	groups = {cracky = 2},
	drop = "ctg_world:titanium_lump",
	sounds = default.node_sound_stone_defaults(),
})

if minetest.get_modpath("other_worlds") then
	minetest.register_node("ctg_world:stone_space_with_titanium", {
		description = S("Titanium Ore"),
		tiles = {"default_stone.png^ctg_mineral_titanium.png"},
		groups = {cracky = 2},
		drop = "ctg_world:titanium_lump",
		sounds = default.node_sound_stone_defaults(),
	})
	
	minetest.register_node("ctg_world:stone_red_with_titanium", {
		description = S("Titanium Ore"),
		tiles = {"asteroid_redstone.png^ctg_mineral_titanium.png"},
		groups = {cracky = 2},
		drop = "ctg_world:titanium_lump",
		sounds = default.node_sound_stone_defaults(),
	})
end

minetest.register_craft({
	type = "cooking",
	output = "default:titanium_ingot",
	recipe = "default:titanium_lump",
})

minetest.register_craftitem("ctg_world:titanium_ingot", {
	description = S("Titanium Ingot"),
	inventory_image = "ctg_titanium_ingot.png"
})

minetest.register_craftitem("ctg_world:titanium_lump", {
	description = S("Titanium Lump"),
	inventory_image = "ctg_titanium_lump.png"
})