-- beds/beds.lua

-- support for MT game translation.
local S = beds.get_translator

-- colors per wool
local colors = { "black", --[["blue", "brown", "cyan", "dark_green", --]]"dark_grey", --[["green",--]] "grey",--[[ "magenta", "orange", "pink", --]]"red",--[[ "violet", "white", "yellow"--]]}

-- Fancy shaped bed

beds.register_bed("beds:fancy_bed_red", {
	description = S("Fancy Red Bed"),
	inventory_image = "beds_bed_red_fancy.png",
	wield_image = "beds_bed_red_fancy.png",
	tiles = {
		bottom = {
			"beds_bed_red_top1.png",
			"beds_bed_under.png",
			"beds_bed_red_side1.png",
			"beds_bed_red_side1.png^[transformFX",
			"beds_bed_red_foot.png",
			"beds_bed_red_foot.png",
		},
		top = {
			"beds_bed_red_top2.png",
			"beds_bed_under.png",
			"beds_bed_red_side2.png",
			"beds_bed_red_side2.png^[transformFX",
			"beds_bed_head.png",
			"beds_bed_head.png",
		}
	},
	nodebox = {
		bottom = {
			{-0.5, -0.5, -0.5, -0.375, -0.065, -0.4375},
			{0.375, -0.5, -0.5, 0.5, -0.065, -0.4375},
			{-0.5, -0.375, -0.5, 0.5, -0.125, -0.4375},
			{-0.5, -0.375, -0.5, -0.4375, -0.125, 0.5},
			{0.4375, -0.375, -0.5, 0.5, -0.125, 0.5},
			{-0.4375, -0.3125, -0.4375, 0.4375, -0.0625, 0.5},
		},
		top = {
			{-0.5, -0.5, 0.4375, -0.375, 0.1875, 0.5},
			{0.375, -0.5, 0.4375, 0.5, 0.1875, 0.5},
			{-0.5, 0, 0.4375, 0.5, 0.125, 0.5},
			{-0.5, -0.375, 0.4375, 0.5, -0.125, 0.5},
			{-0.5, -0.375, -0.5, -0.4375, -0.125, 0.5},
			{0.4375, -0.375, -0.5, 0.5, -0.125, 0.5},
			{-0.4375, -0.3125, -0.5, 0.4375, -0.0625, 0.4375},
		}
	},
	selectionbox = {-0.5, -0.5, -0.5, 0.5, 0.06, 1.5},
	recipe = {
		{"", "", "group:stick"},
		{"wool:red", "wool:red", "wool:white"},
		{"group:wood", "group:wood", "group:wood"},
	},
})

-- Simple shaped bed

local function registerSimpleBed(color)
	local c = ""
	for w in color:gmatch("[^_]+") do
		c = c.." "..w:gsub("^%l", string.upper)
	end
	beds.register_bed("beds:bed_"..color, {		
		description = S("Simple"..c.." Bed"),
		inventory_image = "beds_bed_"..color..".png",
		wield_image = "beds_bed_"..color..".png",
		tiles = {
			bottom = {
				"beds_bed_"..color.."_top_bottom.png^[transformR90",
				"beds_bed_under.png",
				"beds_bed_"..color.."_side_bottom_r.png",
				"beds_bed_"..color.."_side_bottom_r.png^[transformfx",
				"beds_transparent.png",
				"beds_bed_"..color.."_side_bottom.png"
			},
			top = {
				"beds_bed_"..color.."_top_top.png^[transformR90",
				"beds_bed_under.png",
				"beds_bed_"..color.."_side_top_r.png",
				"beds_bed_"..color.."_side_top_r.png^[transformfx",
				"beds_bed_side_top.png",
				"beds_transparent.png",
			}
		},
		nodebox = {
			bottom = {-0.5, -0.5, -0.5, 0.5, 0.0625, 0.5},
			top = {-0.5, -0.5, -0.5, 0.5, 0.0625, 0.5},
		},
		selectionbox = {-0.5, -0.5, -0.5, 0.5, 0.0625, 1.5},
		recipe = {
			{"wool:"..color, "wool:"..color, "wool:white"},
			{"group:wood", "group:wood", "group:wood"}
		},
	})
	minetest.register_craft({
		type = "fuel",
		recipe = "beds:bed_"..color.."_bottom",
		burntime = 12,
	})
	-- Aliases for PilzAdam's beds mod
	
	--minetest.register_alias("beds:bed_bottom_red", "beds:bed_bottom")
	--minetest.register_alias("beds:bed_top_red", "beds:bed_top")
end


for i = 1, 4 do
	registerSimpleBed(colors[i])
end


-- Fuel

minetest.register_craft({
	type = "fuel",
	recipe = "beds:fancy_bed_bottom",
	burntime = 13,
})

--minetest.register_craft({
--	type = "fuel",
--	recipe = "beds:bed_bottom",
--	burntime = 12,
--})
