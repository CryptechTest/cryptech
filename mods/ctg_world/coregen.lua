local S = minetest.get_translator(minetest.get_current_modname())

-- corestone world

minetest.register_node("ctg_world:corestone", {
    description = S("Corestone"),
    tiles = {"ctg_corestone.png"},
    groups = {
        cracky = 1,
        level = 4,
        corestone = 1
    },
    drop = "ctg_world:corestone_cobble",
    on_blast = function()
    end,
    sounds = default.node_sound_stone_defaults()
})

minetest.register_node("ctg_world:corestone_glow", {
    description = S("Corestone Glow"),
    tiles = {"ctg_corestone_glow.png"},
    groups = {
        cracky = 2,
        level = 4,
        corestone = 3
    },
    paramtype = "light",
    drop = "ctg_world:corestone_glow_cobble",
    light_source = 7,
    on_blast = function()
    end,
    sounds = default.node_sound_stone_defaults()
})

minetest.register_node("ctg_world:corestone_glow2", {
    description = S("Corestone Glowing"),
    tiles = {"ctg_corestone_glow2.png"},
    groups = {
        cracky = 2,
        level = 4,
        corestone = 3
    },
    paramtype = "light",
    drop = "ctg_world:corestone_glow_cobble",
    light_source = 12,
    on_blast = function()
    end,
    sounds = default.node_sound_stone_defaults()
})

-- corestone features

minetest.register_node("ctg_world:corestone_cobble", {
    description = S("Corestone Cobble"),
    tiles = {"ctg_corestone_cobble.png"},
    is_ground_content = false,
    groups = {
        cracky = 3,
        level = 4,
        corestone = 2
    },
    on_blast = function()
    end,
    sounds = default.node_sound_stone_defaults()
})

minetest.register_node("ctg_world:corestone_brick", {
    description = S("Corestone Brick"),
    paramtype2 = "facedir",
    place_param2 = 0,
    tiles = {"ctg_corestone_brick.png"},
    is_ground_content = false,
    groups = {
        cracky = 2,
        level = 4,
        corestone = 5
    },
    on_blast = function()
    end,
    sounds = default.node_sound_stone_defaults()
})

minetest.register_node("ctg_world:corestone_block", {
    description = S("Corestone Block"),
    tiles = {"ctg_corestone_block.png"},
    is_ground_content = false,
    groups = {
        cracky = 2,
        level = 4,
        corestone = 5
    },
    on_blast = function()
    end,
    sounds = default.node_sound_stone_defaults()
})

minetest.register_node("ctg_world:corestone_mossycobble", {
    description = S("Mossy Corestone Cobble"),
    tiles = {"ctg_corestone_mossycobble.png"},
    is_ground_content = false,
    groups = {
        cracky = 3,
        level = 4,
        corestone = 2
    },
    on_blast = function()
    end,
    sounds = default.node_sound_stone_defaults()
})

local moss_correspondences = {
    ["ctg_world:corestone_cobble"] = "ctg_world:corestone_mossycobble",
    ["ctg_world:corestone_glow_cobble"] = "ctg_world:corestone_glow_mossycobble"
}

minetest.register_abm({
    label = "Corestone Cobble Moss growth",
    nodenames = {"ctg_world:corestone_cobble", "ctg_world:corestone_glow_cobble"},
    neighbors = {"group:water"},
    interval = 16,
    chance = 200,
    catch_up = false,
    action = function(pos, node)
        node.name = moss_correspondences[node.name]
        if node.name then
            minetest.set_node(pos, node)
        end
    end
})

-- corestone extras

--[[walls.register(":ctg_world:corestone_brick_wall", S("Corestone Brick Wall"), "ctg_corestone_brick.png",
    "ctg_world:corestone_brick", default.node_sound_stone_defaults())]]--

stairs.register_stair_and_slab("ctg_world:corestone_bricks", "ctg_world:corestone_brick", {
    cracky = 1,
    oddly_breakable_by_hand = 0,
    flammable = 0,
    level = 4,
    corestone = 5
}, {"ctg_corestone_brick.png"}, S("Corestone Brick Stair"), S("Corestone Brick Slab"),
    default.node_sound_stone_defaults())

stairs.register_stair_and_slab("ctg_world:corestone_blocks", "ctg_world:corestone_block", {
    cracky = 1,
    oddly_breakable_by_hand = 0,
    flammable = 0,
    level = 4,
    corestone = 5
}, {"ctg_corestone_block.png"}, S("Corestone Block Stair"), S("Corestone Block Slab"),
    default.node_sound_stone_defaults())

minetest.register_craft({
    output = "ctg_world:corestone_block 4",
    type = "shapeless",
    recipe = {"ctg_world:corestone", "ctg_world:corestone", "ctg_world:corestone", "ctg_world:corestone",
              "ctg_world:corestone", "ctg_world:corestone"}
})

minetest.register_craft({
    output = "ctg_world:corestone_brick",
    type = "shapeless",
    recipe = {"ctg_world:corestone", "ctg_world:corestone"}
})

minetest.register_craft({
    output = "ctg_world:corestone_brick_wall",
    type = "shapeless",
    recipe = {"ctg_world:corestone_brick"}
})

-- corestone cobble recipe

if minetest.get_modpath("technic") then
    technic.register_compressor_recipe({
        input = {"ctg_world:corestone_cobble" .. " 1"},
        output = "ctg_world:corestone"
    })
    technic.register_compressor_recipe({
        input = {"ctg_world:corestone_mossycobble" .. " 1"},
        output = "ctg_world:corestone"
    })
end

-- glow corestone features

minetest.register_node("ctg_world:corestone_glow_cobble", {
    description = S("Corestone Glow Cobble"),
    tiles = {"ctg_corestone_glow_cobble.png"},
    is_ground_content = false,
    groups = {
        cracky = 3,
        level = 4,
        corestone = 3
    },
    on_blast = function()
    end,
    paramtype = "light",
    light_source = 9,
    sounds = default.node_sound_stone_defaults()
})

minetest.register_node("ctg_world:corestone_glow_brick", {
    description = S("Corestone Glow Brick"),
    paramtype2 = "facedir",
    place_param2 = 0,
    tiles = {"ctg_corestone_glow_brick.png"},
    is_ground_content = false,
    groups = {
        cracky = 2,
        level = 4,
        corestone = 6
    },
    on_blast = function()
    end,
    paramtype = "light",
    light_source = 10,
    sounds = default.node_sound_stone_defaults()
})

minetest.register_node("ctg_world:corestone_glow_block", {
    description = S("Corestone Glow Block"),
    tiles = {"ctg_corestone_glow_block.png"},
    is_ground_content = false,
    groups = {
        cracky = 2,
        level = 4,
        corestone = 6
    },
    on_blast = function()
    end,
    paramtype = "light",
    light_source = 11,
    sounds = default.node_sound_stone_defaults()
})

minetest.register_node("ctg_world:corestone_glow_mossycobble", {
    description = S("Mossy Glow Corestone Cobble"),
    tiles = {"ctg_corestone_glow_mossycobble.png"},
    is_ground_content = false,
    groups = {
        cracky = 3,
        level = 4,
        corestone = 2
    },
    on_blast = function()
    end,
    paramtype = "light",
    light_source = 7,
    sounds = default.node_sound_stone_defaults()
})

minetest.register_node("ctg_world:corestone_glow_octa", {
    description = S("Corestone Glow Octagon"),
    tiles = {"ctg_corestone_glow_panel.png"},
    is_ground_content = false,
    groups = {
        cracky = 2,
        level = 4,
        corestone = 6
    },
    on_blast = function()
    end,
    paramtype = "light",
    light_source = 12,
    sounds = default.node_sound_stone_defaults()
})

minetest.register_node("ctg_world:corestone_glow_panel", {
    description = S("Corestone Glow Bar"),
    tiles = {"ctg_corestone_glow_panel2.png"},
    is_ground_content = false,
    paramtype2 = "facedir",
    place_param2 = 0,
    groups = {
        cracky = 2,
        level = 4,
        corestone = 6
    },
    on_blast = function()
    end,
    paramtype = "light",
    light_source = 12,
    sounds = default.node_sound_stone_defaults()
})

-- glow corestone extras

minetest.register_craft({
    output = "ctg_world:corestone_glow_block 5",
    type = "shapeless",
    recipe = {"ctg_world:corestone_glow", "ctg_world:corestone_glow", "ctg_world:corestone_glow",
              "ctg_world:corestone_glow", "ctg_world:corestone_glow", "ctg_world:corestone_glow"}
})

minetest.register_craft({
    output = "ctg_world:corestone_glow_block 3",
    type = "shapeless",
    recipe = {"ctg_world:corestone_glow2", "ctg_world:corestone_glow2", "ctg_world:corestone_glow2"}
})

minetest.register_craft({
    output = "ctg_world:corestone_glow_octa 3",
    recipe = {{'', 'ctg_world:corestone_block', ''},
              {'ctg_world:corestone_block', 'ctg_world:corestone_glow_block', 'ctg_world:corestone_block'},
              {'', 'ctg_world:corestone_block', ''}}
})

minetest.register_craft({
    output = "ctg_world:corestone_glow_panel 2",
    type = "shapeless",
    recipe = {"ctg_world:corestone_block", "ctg_world:corestone_glow_block", "ctg_world:corestone_block"}
})

minetest.register_craft({
    output = "ctg_world:corestone_glow_brick",
    type = "shapeless",
    recipe = {"ctg_world:corestone_glow", "ctg_world:corestone_glow"}
})

minetest.register_craft({
    output = "ctg_world:corestone_glow_brick 2",
    type = "shapeless",
    recipe = {"ctg_world:corestone_glow2", "ctg_world:corestone_glow2"}
})

stairs.register_slab("ctg_world:corestone_glow_blocks", "ctg_world:corestone_glow_block", {
    cracky = 1,
    oddly_breakable_by_hand = 0,
    flammable = 0,
    level = 4,
    corestone = 5
}, {"ctg_corestone_glow_block.png"}, S("Corestone Glow Brick Slab"), default.node_sound_stone_defaults())

-- glow cobble recipe

if minetest.get_modpath("technic") then
    technic.register_compressor_recipe({
        input = {"ctg_world:corestone_glow_cobble" .. " 1"},
        output = "ctg_world:corestone_glow"
    })
    technic.register_compressor_recipe({
        input = {"ctg_world:corestone_glow_mossycobble" .. " 1"},
        output = "ctg_world:corestone_glow"
    })
end

-- mapgen registers

minetest.register_alias("mapgen_corestone", "ctg_world:corestone")

minetest.register_biome({
    name = "crust_under_stone",
    node_stone = "ctg_world:corestone",
    node_cave_liquid = {"default:water_source", "default:lava_source", "vacuum:atmos_thin", "vacuum:vacuum"},
    node_dungeon = "ctg_world:corestone_cobble",
    node_dungeon_alt = "ctg_world:corestone_mossycobble",
    node_dungeon_stair = "stairs:stair_ctg_world:corestone_bricks",
    vertical_blend = 1,
    y_max = -10050,
    y_min = -11000,
    heat_point = 60,
    humidity_point = 20
})

minetest.register_ore({
    ore_type = "blob",
    ore = "ctg_world:corestone",
    wherein = {"default:stone"},
    clust_scarcity = 8 * 8 * 8,
    clust_size = 10,
    y_max = -10000,
    y_min = -11000,
    noise_threshold = 0.0,
    noise_params = {
        offset = 0.5,
        scale = 0.2,
        spread = {
            x = 8,
            y = 8,
            z = 8
        },
        seed = -317,
        octaves = 1,
        persist = 0.0
    }
})

minetest.register_ore({
    ore_type = "blob",
    ore = "bedrock2:bedrock",
    wherein = {"ctg_world:corestone"},
    clust_scarcity = 16 * 16 * 16,
    clust_size = 4,
    y_max = -10980,
    y_min = -11001,
    noise_threshold = 0.0,
    noise_params = {
        offset = 0.5,
        scale = 0.2,
        spread = {
            x = 5,
            y = 5,
            z = 5
        },
        seed = -317,
        octaves = 1,
        persist = 0.0
    }
})

minetest.register_ore({
    ore_type = "blob",
    ore = "ctg_world:corestone_glow2",
    wherein = {"ctg_world:corestone"},
    clust_scarcity = 24 * 32 * 24,
    clust_size = 2,
    y_max = -10100,
    y_min = -11001,
    noise_threshold = 0.0,
    noise_params = {
        offset = 0.5,
        scale = 0.6,
        spread = {
            x = 1,
            y = 7,
            z = 1
        },
        seed = -173,
        octaves = 1,
        persist = 0.0
    }
})

minetest.register_ore({
    ore_type = "blob",
    ore = "ctg_world:corestone_glow",
    wherein = {"ctg_world:corestone"},
    clust_scarcity = 25 * 25 * 25,
    clust_size = 5,
    y_max = -10050,
    y_min = -11001,
    noise_threshold = 0.0,
    noise_params = {
        offset = 0.5,
        scale = 0.5,
        spread = {
            x = 1,
            y = 7,
            z = 1
        },
        seed = -173,
        octaves = 1,
        persist = 0.0
    }
})

minetest.register_biome({
    name = "vacuum_buffer",
    node_stone = "vacuum:vacuum",
    node_cave_liquid = {"vacuum:vacuum"},
    node_dungeon = "vacuum:vacuum",
    node_dungeon_alt = "vacuum:vacuum",
    node_dungeon_stair = "vacuum:vacuum",
    y_max = -11000,
    y_min = -21000,
    heat_point = 0,
    humidity_point = 0
})

minetest.register_biome({
    name = "void_space",
    node_stone = "vacuum:vacuum",
    y_max = -21000,
    y_min = -31000,
    heat_point = 0,
    humidity_point = 0
})

minetest.register_on_generated(function(minp, maxp, seed)
    -- Check if the area being generated is below -11000
    if maxp.y < -11000 then
        -- Iterate over all the nodes in the area
        for x = minp.x, maxp.x do
            for y = minp.y, maxp.y do
                for z = minp.z, maxp.z do
                    -- Set any non-vacuum nodes to vacuum
                    local pos = {
                        x = x,
                        y = y,
                        z = z
                    }
                    local node = minetest.get_node(pos)
                    if node.name ~= "vacuum:vacuum" then
                        minetest.set_node(pos, {
                            name = "vacuum:vacuum"
                        })
                    end
                end
            end
        end
    end
end)
