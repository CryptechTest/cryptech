local S = minetest.get_translator(minetest.get_current_modname())

minetest.register_node("ctg_world:corestone", {
    description = S("Corestone"),
    tiles = {"corestone.png"},
    groups = {
        cracky = 1,
        level = 4
    },
    sounds = default.node_sound_stone_defaults()
})

minetest.register_node("ctg_world:corestone_glow", {
    description = S("Corestone Glow"),
    tiles = {"corestone_glow.png"},
    groups = {
        cracky = 2,
        level = 4
    },
    paramtype = "light",
    light_source = 7,
    sounds = default.node_sound_stone_defaults()
})

minetest.register_node("ctg_world:corestone_glow2", {
    description = S("Corestone Glowing"),
    tiles = {"corestone_glow.png"},
    groups = {
        cracky = 2,
        level = 4
    },
    paramtype = "light",
    light_source = 12,
    sounds = default.node_sound_stone_defaults()
})

minetest.register_alias("mapgen_corestone", "ctg_world:corestone")

minetest.register_biome({
    name = "crust_under_stone",
    node_stone = "ctg_world:corestone",
    node_cave_liquid = {"default:water_source", "default:lava_source", "vacuum:atmos_thin"},
    node_dungeon = "ctg_world:corestone",
    node_dungeon_alt = "ctg_world:corestone",
    node_dungeon_stair = "stairs:stair_cobble",
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
