core.register_node("ctg_world:lightbar", {
	description = "Ceiling Lightbar",
	tiles = {
		"scifi_nodes_white2.png",
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	light_source = core.LIGHT_MAX - 1,
    connects_to = { "group:wall", "group:stone", "group:metal", "group:lightbar", "group:lightcol", "scifi_nodes:lightbar" },
    connect_sides = {"front", "left", "back", "right", "bottom"}, -- "top"
	node_box = {
		type = "connected",
		fixed = {
            {-0.125, 0.375, -0.125, 0.125, 0.5, 0.125}, -- fixed
        },
        connect_back = {-0.125, 0.375, 0.125, 0.125, 0.5, 0.5}, -- north
        connect_front = {-0.125, 0.375, -0.5, 0.125, 0.5, -0.125}, -- south
        connect_right = {0.125, 0.375, -0.125, 0.5, 0.5, 0.125}, -- east
        connect_left = {-0.5, 0.375, -0.125, -0.125, 0.5, 0.125}, -- west
        connect_bottom = {-0.125, -0.5, -0.125, 0.125, 0.375, 0.125}, -- bottom2
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
        connect_bottom = {-0.125, -0.5, -0.125, 0.125, 0.375, 0.125}, -- bottom2
	},

	groups = {attached_node = 1, cracky=1, dig_generic = 3, lightbar = 1},
	is_ground_content = false,
	sounds = scifi_nodes.node_sound_glass_defaults()
})

core.register_node("ctg_world:lightbar_vert", {
	description = "Vertical Lightbar",
	tiles = {
		"scifi_nodes_white2.png",
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	light_source = core.LIGHT_MAX - 1,
    connects_to = { "group:lightbar" },
    connect_sides = {"front", "left", "back", "right"}, -- "top", "bottom", 
	node_box = {    
		type = "connected",
		fixed = {
            {-0.125, 0.375, -0.125, 0.125, 0.5, 0.125}, -- fixed
            {-0.125, -0.5, -0.125, 0.125, 0.375, 0.125},
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
            {-0.125, -0.5, -0.125, 0.125, 0.375, 0.125},
        },
        connect_back = {-0.125, 0.375, 0.125, 0.125, 0.5, 0.5}, -- north
        connect_front = {-0.125, 0.375, -0.5, 0.125, 0.5, -0.125}, -- south
        connect_right = {0.125, 0.375, -0.125, 0.5, 0.5, 0.125}, -- east
        connect_left = {-0.5, 0.375, -0.125, -0.125, 0.5, 0.125}, -- west
	},

	groups = {attached_node = 1, cracky=1, dig_generic = 3, lightcol = 1},
	is_ground_content = false,
	sounds = scifi_nodes.node_sound_glass_defaults()
})

core.register_craft({
    output = "ctg_world:lightbar_vert 3",
    recipe = {
        {"", "", "ctg_world:lightbar"},
        {"", "", "ctg_world:lightbar"},
        {"", "", "ctg_world:lightbar"}
    }
})

core.register_craft({
    output = "ctg_world:lightbar 3",
    recipe = {
        {"ctg_world:lightbar_vert", "ctg_world:lightbar_vert", "ctg_world:lightbar_vert"},
        {"", "", ""},
        {"", "", ""}
    }
})

core.register_craft({
    output = "ctg_world:lightbar 1",
    type = "shapeless",
    recipe = {
        "scifi_nodes:lightbar"
    }
})

core.register_craft({
    output = "scifi_nodes:lightbar 1",
    type = "shapeless",
    recipe = {
        "ctg_world:lightbar"
    }
})

core.register_craft({
    output = "ctg_world:lightbar 8",
    recipe = {
        {"scifi_nodes:white2", "default:glass", "scifi_nodes:white2"},
        {"", "default:meselamp", ""},
        {"", "", ""}
    }
})