local S = minetest.get_translator(minetest.get_current_modname())

-- disable old recipes

minetest.clear_craft({ output = "vehicle_mash:battery" })
minetest.clear_craft({ output = "vehicle_mash:tire" })
minetest.clear_craft({ output = "vehicle_mash:car_black" })
minetest.clear_craft({ output = "vehicle_mash:car_blue" })
minetest.clear_craft({ output = "vehicle_mash:car_brown" })
minetest.clear_craft({ output = "vehicle_mash:car_cyan" })
minetest.clear_craft({ output = "vehicle_mash:car_dark_green" })
minetest.clear_craft({ output = "vehicle_mash:car_dark_grey" })
minetest.clear_craft({ output = "vehicle_mash:car_green" })
minetest.clear_craft({ output = "vehicle_mash:car_grey" })
-- minetest.clear_craft({ output = "vehicle_mash:car_hot_rod" })
minetest.clear_craft({ output = "vehicle_mash:car_magenta" })
--minetest.clear_craft({ output = "vehicle_mash:car_nyan_ride" })
--minetest.clear_craft({ output = "vehicle_mash:car_oerkki_bliss" })
minetest.clear_craft({ output = "vehicle_mash:car_orange" })
minetest.clear_craft({ output = "vehicle_mash:car_pink" })
minetest.clear_craft({ output = "vehicle_mash:car_red" })
--minetest.clear_craft({ output = "vehicle_mash:car_road_master" })
minetest.clear_craft({ output = "vehicle_mash:car_violet" })
minetest.clear_craft({ output = "vehicle_mash:car_white" })
minetest.clear_craft({ output = "vehicle_mash:car_yellow" })
minetest.clear_craft({ output = "vehicle_mash:hover_blue" })
minetest.clear_craft({ output = "vehicle_mash:hover_green" })
minetest.clear_craft({ output = "vehicle_mash:hover_red" })
minetest.clear_craft({ output = "vehicle_mash:hover_yellow" })

-- new recipes

minetest.register_craft({
    output = "vehicle_mash:battery",
    recipe = {
        { "dye:blue","technic:lead_ingot", "dye:red" },
        { "default:steel_ingot","technic:sulfur_lump","default:steel_ingot" },
        { "default:steel_ingot", "bucket:bucket_water","default:steel_ingot" },
    },
})

minetest.register_craft({
    output = "vehicle_mash:tire",
    recipe = {
        { "technic:rubber","technic:rubber", "technic:rubber" },
        { "technic:rubber","moreblocks:slab_steelblock","technic:rubber"},
        { "technic:rubber", "technic:rubber","technic:rubber" },
    },
})

minetest.register_craft({
	output = "vehicle_mash:car_black",
	recipe = {
		{"vehicle_mash:tire", "vehicle_mash:windshield", "vehicle_mash:tire"},
		{"default:steelblock", "vehicle_mash:motor", "dye:black"},
		{"vehicle_mash:tire", "vehicle_mash:battery", "vehicle_mash:tire"},
	}
})

minetest.register_craft({
	output = "vehicle_mash:car_blue",
	recipe = {
		{"vehicle_mash:tire", "vehicle_mash:windshield", "vehicle_mash:tire"},
		{"default:steelblock", "vehicle_mash:motor", "dye:blue"},
		{"vehicle_mash:tire", "vehicle_mash:battery", "vehicle_mash:tire"},
	}
})

minetest.register_craft({
	output = "vehicle_mash:car_brown",
	recipe = {
		{"vehicle_mash:tire", "vehicle_mash:windshield", "vehicle_mash:tire"},
		{"default:steelblock", "vehicle_mash:motor", "dye:brown"},
		{"vehicle_mash:tire", "vehicle_mash:battery", "vehicle_mash:tire"},
	}
})

minetest.register_craft({
	output = "vehicle_mash:car_cyan",
	recipe = {
		{"vehicle_mash:tire", "vehicle_mash:windshield", "vehicle_mash:tire"},
		{"default:steelblock", "vehicle_mash:motor", "dye:cyan"},
		{"vehicle_mash:tire", "vehicle_mash:battery", "vehicle_mash:tire"},
	}
})

minetest.register_craft({
	output = "vehicle_mash:car_dark_green",
	recipe = {
		{"vehicle_mash:tire", "vehicle_mash:windshield", "vehicle_mash:tire"},
		{"default:steelblock", "vehicle_mash:motor", "dye:dark_green"},
		{"vehicle_mash:tire", "vehicle_mash:battery", "vehicle_mash:tire"},
	}
})

minetest.register_craft({
	output = "vehicle_mash:car_dark_grey",
	recipe = {
		{"vehicle_mash:tire", "vehicle_mash:windshield", "vehicle_mash:tire"},
		{"default:steelblock", "vehicle_mash:motor", "dye:dark_grey"},
		{"vehicle_mash:tire", "vehicle_mash:battery", "vehicle_mash:tire"},
	}
})

minetest.register_craft({
	output = "vehicle_mash:car_green",
	recipe = {
		{"vehicle_mash:tire", "vehicle_mash:windshield", "vehicle_mash:tire"},
		{"default:steelblock", "vehicle_mash:motor", "dye:green"},
		{"vehicle_mash:tire", "vehicle_mash:battery", "vehicle_mash:tire"},
	}
})

minetest.register_craft({
	output = "vehicle_mash:car_grey",
	recipe = {
		{"vehicle_mash:tire", "vehicle_mash:windshield", "vehicle_mash:tire"},
		{"default:steelblock", "vehicle_mash:motor", "dye:grey"},
		{"vehicle_mash:tire", "vehicle_mash:battery", "vehicle_mash:tire"},
	}
})
--[[
    minetest.register_craft({
	output = "vehicle_mash:car_hot_rod",
	recipe = {
		{"vehicle_mash:tire", "vehicle_mash:windshield", "vehicle_mash:tire"},
		{"default:steelblock", "vehicle_mash:motor", ""},
		{"vehicle_mash:tire", "vehicle_mash:battery", "vehicle_mash:tire"},
	}
})
]]


minetest.register_craft({
	output = "vehicle_mash:car_magenta",
	recipe = {
		{"vehicle_mash:tire", "vehicle_mash:windshield", "vehicle_mash:tire"},
		{"default:steelblock", "vehicle_mash:motor", "dye:magenta"},
		{"vehicle_mash:tire", "vehicle_mash:battery", "vehicle_mash:tire"},
	}
})
--[[
minetest.register_craft({
	output = "vehicle_mash:car_nyan_ride",
	recipe = {
		{"vehicle_mash:tire", "vehicle_mash:windshield", "vehicle_mash:tire"},
		{"default:steelblock", "vehicle_mash:motor", ""},
		{"vehicle_mash:tire", "vehicle_mash:battery", "vehicle_mash:tire"},
	}
})
]]
--[[
minetest.register_craft({
	output = "vehicle_mash:car_oerkki_bliss",
	recipe = {
		{"vehicle_mash:tire", "vehicle_mash:windshield", "vehicle_mash:tire"},
		{"default:steelblock", "vehicle_mash:motor", ""},
		{"vehicle_mash:tire", "vehicle_mash:battery", "vehicle_mash:tire"},
	}
})
]]

minetest.register_craft({
	output = "vehicle_mash:car_orange",
	recipe = {
		{"vehicle_mash:tire", "vehicle_mash:windshield", "vehicle_mash:tire"},
		{"default:steelblock", "vehicle_mash:motor", "dye:orange"},
		{"vehicle_mash:tire", "vehicle_mash:battery", "vehicle_mash:tire"},
	}
})

minetest.register_craft({
	output = "vehicle_mash:car_pink",
	recipe = {
		{"vehicle_mash:tire", "vehicle_mash:windshield", "vehicle_mash:tire"},
		{"default:steelblock", "vehicle_mash:motor", "dye:pink"},
		{"vehicle_mash:tire", "vehicle_mash:battery", "vehicle_mash:tire"},
	}
})

minetest.register_craft({
	output = "vehicle_mash:car_red",
	recipe = {
		{"vehicle_mash:tire", "vehicle_mash:windshield", "vehicle_mash:tire"},
		{"default:steelblock", "vehicle_mash:motor", "dye:red"},
		{"vehicle_mash:tire", "vehicle_mash:battery", "vehicle_mash:tire"},
	}
})
--[[
minetest.register_craft({
	output = "vehicle_mash:car_road_master",
	recipe = {
		{"vehicle_mash:tire", "vehicle_mash:windshield", "vehicle_mash:tire"},
		{"default:steelblock", "vehicle_mash:motor", ""},
		{"vehicle_mash:tire", "vehicle_mash:battery", "vehicle_mash:tire"},
	}
})
]]

minetest.register_craft({
	output = "vehicle_mash:car_violet",
	recipe = {
		{"vehicle_mash:tire", "vehicle_mash:windshield", "vehicle_mash:tire"},
		{"default:steelblock", "vehicle_mash:motor", "dye:violet"},
		{"vehicle_mash:tire", "vehicle_mash:battery", "vehicle_mash:tire"},
	}
})

minetest.register_craft({
	output = "vehicle_mash:car_white",
	recipe = {
		{"vehicle_mash:tire", "vehicle_mash:windshield", "vehicle_mash:tire"},
		{"default:steelblock", "vehicle_mash:motor", "dye:white"},
		{"vehicle_mash:tire", "vehicle_mash:battery", "vehicle_mash:tire"},
	}
})

minetest.register_craft({
	output = "vehicle_mash:car_yellow",
	recipe = {
		{"vehicle_mash:tire", "vehicle_mash:windshield", "vehicle_mash:tire"},
		{"default:steelblock", "vehicle_mash:motor", "dye:yellow"},
		{"vehicle_mash:tire", "vehicle_mash:battery", "vehicle_mash:tire"},
	}
})

minetest.register_craft({
	output = "vehicle_mash:hover_blue",
	recipe = {
		{"", "dye:blue", "scifi_nodes:white2"},
		{"scifi_nodes:white2", "scifi_nodes:white2", "vehicle_mash:motor"},
		{"technic:rubber", "technic:rubber", "technic:rubber"},
	}
})

minetest.register_craft({
	output = "vehicle_mash:hover_green",
	recipe = {
		{"", "dye:green", "scifi_nodes:white2"},
		{"scifi_nodes:white2", "scifi_nodes:white2", "vehicle_mash:motor"},
		{"technic:rubber", "technic:rubber", "technic:rubber"},
	}
})

minetest.register_craft({
	output = "vehicle_mash:hover_red",
	recipe = {
		{"", "dye:red", "scifi_nodes:white2"},
		{"scifi_nodes:white2", "scifi_nodes:white2", "vehicle_mash:motor"},
		{"technic:rubber", "technic:rubber", "technic:rubber"},
	}
})

minetest.register_craft({
	output = "vehicle_mash:hover_yellow",
	recipe = {
		{"", "dye:yellow", "scifi_nodes:white2"},
		{"scifi_nodes:white2", "scifi_nodes:white2", "vehicle_mash:motor"},
		{"technic:rubber", "technic:rubber", "technic:rubber"},
	}
})