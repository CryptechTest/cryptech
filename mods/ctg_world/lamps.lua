minetest.register_node("ctg_world:lightbar", {
	description = "Ceiling Lightbar",
	tiles = {
		"scifi_nodes_white2.png",
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	light_source = minetest.LIGHT_MAX - 1,
    connects_to = { "group:wall", "group:stone", "group:metal", "group:lightbar" },
	node_box = {
		type = "connected",
		fixed = {
            {-0.125, 0.375, -0.125, 0.125, 0.5, 0.125}, -- fixed
        },
        connect_back = {-0.125, 0.375, 0.125, 0.125, 0.5, 0.5}, -- north
        connect_front = {-0.125, 0.375, -0.5, 0.125, 0.5, -0.125}, -- south
        connect_right = {0.125, 0.375, -0.125, 0.5, 0.5, 0.125}, -- east
        connect_left = {-0.5, 0.375, -0.125, -0.125, 0.5, 0.125}, -- west
	},
	selection_box = {
		type = "connected",
		fixed = {
            {-0.125, 0.375, -0.125, 0.125, 0.5, 0.125}, -- fixed
        },
        connect_back = {-0.125, 0.375, 0.125, 0.125, 0.5, 0.5}, -- north
        connect_front = {-0.125, 0.375, -0.5, 0.125, 0.5, -0.125}, -- south
        connect_right = {0.125, 0.375, -0.125, 0.5, 0.5, 0.125}, -- east
        connect_left = {-0.5, 0.375, -0.125, -0.125, 0.5, 0.125}, -- west
	},

	groups = {attached_node = 1, cracky=1, dig_generic = 3, lightbar = 1},
	is_ground_content = false,
	sounds = scifi_nodes.node_sound_glass_defaults()
})

minetest.register_craft({
    output = "ctg_world:lightbar 10",
    recipe = {
        {"scifi_nodes:white2", "default:glass", "scifi_nodes:white2"},
        {"", "default:meselamp", ""},
        {"", "", ""}
    }
})