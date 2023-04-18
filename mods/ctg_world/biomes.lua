local S = minetest.get_translator(minetest.get_current_modname())

---------------------------------------------------------------
-- node setup
---------------------------------------------------------------
minetest.register_node("ctg_world:lavastone", {
    description = S("Lava Cave Stone"),
    tiles = {"lavastone.png"},
    groups = {
        cracky = 3,
        stone = 1
    },
    drop = "ctg_world:lavastone",
    legacy_mineral = true,
    paramtype = "light",
    light_source = 3,
    sounds = default.node_sound_stone_defaults()
})

minetest.register_node("ctg_world:plantstone", {
    description = S("Planty Cave Stone"),
    tiles = {"plantstone.png"},
    groups = {
        cracky = 3,
        stone = 1,
        soil = 1
    },
    drop = "ctg_world:plantstone",
    legacy_mineral = true,
    sounds = default.node_sound_stone_defaults()
})

---------------------------------------------------------------

minetest.register_node("ctg_world:glow_plant", {
    description = S("Glowing Cave Plant"),
    drawtype = "plantlike",
    waving = 1,
    visual_scale = 2,
    tiles = {"cave_plant_3.png"},
    inventory_image = "cave_plant_3.png",
    wield_image = "cave_plant_3.png",
    -- use_texture_alpha = "blend",
    paramtype = "light",
    light_source = 6,
    sunlight_propagates = true,
    walkable = false,
    buildable_to = true,
    groups = {
        snappy = 3,
        flammable = 3,
        flora = 1,
        grass = 1,
        attached_node = 1
    },
    sounds = default.node_sound_leaves_defaults(),
    selection_box = {
        type = "fixed",
        fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 0.25, 4 / 16}
    }
})

minetest.register_node("ctg_world:glow_fern", {
    description = S("Glowing Fern Plant"),
    drawtype = "plantlike",
    waving = 1,
    visual_scale = 2,
    tiles = {"cave_plant_2.png"},
    inventory_image = "cave_plant_2.png",
    wield_image = "cave_plant_2.png",
    paramtype = "light",
    light_source = 4,
    sunlight_propagates = true,
    walkable = false,
    buildable_to = true,
    groups = {
        snappy = 3,
        flammable = 3,
        flora = 1,
        grass = 1,
        attached_node = 1
    },
    sounds = default.node_sound_leaves_defaults(),
    selection_box = {
        type = "fixed",
        fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 0.0, 4 / 16}
    }
})

---------------------------------------------------------------
---------------------------------------------------------------
-- biomes setup
---------------------------------------------------------------

-- stone
minetest.register_biome({
    name = "caves_stone",
    node_stone = "default:stone",
    y_max = -1000,
    y_min = -10000,
    heat_point = 5,
    humidity_point = 5
})

minetest.register_biome({
    name = "caves_stone2",
    node_stone = "default:stone",
    y_max = -1000,
    y_min = -10000,
    heat_point = 20,
    humidity_point = 8
})

minetest.register_biome({
    name = "caves_stone3",
    node_stone = "default:stone",
    y_max = -1000,
    y_min = -10000,
    heat_point = 50,
    humidity_point = 10
})

-- mossy
minetest.register_biome({
    name = "caves_mossy",
    node_stone = "default:stone",
    y_max = -90,
    y_min = -5000,
    heat_point = 64,
    humidity_point = 40
})

minetest.register_biome({
    name = "caves_mossy2",
    node_stone = "default:stone",
    y_max = -90,
    y_min = -5000,
    heat_point = 67,
    humidity_point = 60
})

minetest.register_biome({
    name = "caves_mossy3",
    node_stone = "default:stone",
    y_max = -100,
    y_min = -5000,
    heat_point = 77,
    humidity_point = 77
})

-- mossy2
minetest.register_biome({
    name = "caves_fungi",
    node_stone = "default:stone",
    y_max = -90,
    y_min = -6000,
    heat_point = 70,
    humidity_point = 93
})

-- planty
minetest.register_biome({
    name = "caves_planty",
    node_stone = "default:stone",
    y_max = -90,
    y_min = -5000,
    heat_point = 98,
    humidity_point = 52
})

-- drippy
minetest.register_biome({
    name = "caves_drippy",
    node_stone = "default:stone",
    y_max = -100,
    y_min = -11000,
    heat_point = 25,
    humidity_point = 40
})

minetest.register_biome({
    name = "caves_drippy2",
    node_stone = "default:stone",
    y_max = -100,
    y_min = -11000,
    heat_point = 20,
    humidity_point = 60
})

minetest.register_biome({
    name = "caves_drippy3",
    node_stone = "default:stone",
    y_max = -100,
    y_min = -11000,
    heat_point = 28,
    humidity_point = 90
})

-- drippy dry
minetest.register_biome({
    name = "caves_dripped",
    node_stone = "default:stone",
    y_max = -100,
    y_min = -11000,
    heat_point = 67,
    humidity_point = 1
})

minetest.register_biome({
    name = "caves_dripped2",
    node_stone = "default:stone",
    y_max = -100,
    y_min = -11000,
    heat_point = 80,
    humidity_point = 2
})

minetest.register_biome({
    name = "caves_dripped3",
    node_stone = "default:stone",
    y_max = -100,
    y_min = -11000,
    heat_point = 97,
    humidity_point = 3
})

-- bacterial
minetest.register_biome({
    name = "caves_bacterial",
    node_stone = "default:stone",
    y_max = -1000,
    y_min = -11000,
    heat_point = 88,
    humidity_point = 95
})

minetest.register_biome({
    name = "caves_bacterial2",
    node_stone = "default:stone",
    y_max = -1000,
    y_min = -11000,
    heat_point = 90,
    humidity_point = 90
})

minetest.register_biome({
    name = "caves_bacterial3",
    node_stone = "default:stone",
    y_max = -1000,
    y_min = -11000,
    heat_point = 97,
    humidity_point = 100
})

---------------------------------------------------------------
---------------------------------------------------------------
-- decorations setup
---------------------------------------------------------------

-- planty
minetest.register_decoration({
    deco_type = "simple",
    place_on = {"default:stone"},
    is_ground_content = true,
    sidelen = 4,
    place_offset_y = -1,
    fill_ratio = 8,
    biomes = {"caves_planty"},
    flags = "force_placement,all_floors",
    y_max = -90,
    y_min = -6000,
    decoration = "ctg_world:plantstone"

})

minetest.register_decoration({
    deco_type = "simple",
    place_on = {"default:stone"},
    is_ground_content = true,
    sidelen = 4,
    place_offset_y = -1,
    fill_ratio = 8,
    biomes = {"caves_planty"},
    flags = "force_placement,all_ceilings",
    y_max = -90,
    y_min = -6000,
    decoration = "livingcaves:mushcave2_ceiling"

})

---------------------------------------------------------------

minetest.register_decoration({
    deco_type = "schematic",
    place_on = {"ctg_world:plantstone"},
    sidelen = 8,
    place_offset_y = 1,
    noise_params = {
        offset = 0.0,
        scale = -0.01,
        spread = {
            x = 320,
            y = 325,
            z = 320
        },
        seed = 2,
        octaves = 3,
        persist = 0.66
    },
    -- biomes = { "caves_planty"},
    flags = "place_center_x,place_center_z,all_floors",
    y_max = -90,
    y_min = -6000,
    schematic = minetest.get_modpath("ctg_world") .. "/schematics/cave_bush_1.mts",
    rotation = "random"
})

minetest.register_decoration({
    deco_type = "schematic",
    place_on = {"ctg_world:plantstone"},
    sidelen = 8,
    place_offset_y = 1,
    noise_params = {
        offset = 0.0,
        scale = -0.005,
        spread = {
            x = 250,
            y = 300,
            z = 250
        },
        seed = 3,
        octaves = 3,
        persist = 0.66
    },
    -- biomes = { "caves_planty"},
    flags = "place_center_x,place_center_z,all_floors",
    y_max = -90,
    y_min = -6000,
    schematic = minetest.get_modpath("ctg_world") .. "/schematics/cave_bush_2.mts",
    rotation = "random"
})

minetest.register_decoration({
    deco_type = "schematic",
    place_on = {"ctg_world:plantstone"},
    sidelen = 8,
    place_offset_y = 1,
    noise_params = {
        offset = 0.0,
        scale = -0.002,
        spread = {
            x = 400,
            y = 400,
            z = 400
        },
        seed = 3,
        octaves = 3,
        persist = 0.66
    },
    -- biomes = { "caves_planty"},
    flags = "place_center_x,place_center_z,all_floors",
    y_max = -90,
    y_min = -6000,
    schematic = minetest.get_modpath("ctg_world") .. "/schematics/cave_bush_3.mts",
    rotation = "random"
})

local function register_grass2_decoration(offset, scale, length)
    minetest.register_decoration({
        name = "ctg_world:grass_" .. length,
        deco_type = "simple",
        place_on = {"ctg_world:plantstone", "livingcaves:mushcave2_bottom"},
        sidelen = 16,
        -- place_offset_y = 1,
        noise_params = {
            offset = offset,
            scale = scale,
            spread = {
                x = 150,
                y = 150,
                z = 150
            },
            seed = 329,
            octaves = 3,
            persist = 0.6
        },
        -- biomes = {"caves_planty"},
        flags = "all_floors",
        y_max = -90,
        y_min = -6000,
        decoration = "default:grass_" .. length
    })
end

local function register_fern2_decoration(seed, length)
    minetest.register_decoration({
        name = "ctg_world:fern_" .. length,
        deco_type = "simple",
        place_on = {"ctg_world:plantstone", "livingcaves:mushcave_bottom", "livingcaves:mushcave2_bottom"},
        sidelen = 16,
        -- place_offset_y = 1,
        noise_params = {
            offset = 0,
            scale = 0.2,
            spread = {
                x = 125,
                y = 125,
                z = 125
            },
            seed = seed,
            octaves = 3,
            persist = 0.7
        },
        -- biomes = {"caves_planty"},
        flags = "all_floors",
        y_max = -90,
        y_min = -6000,
        decoration = "default:fern_" .. length
    })
end

register_grass2_decoration(-0.03, 0.09, 5)
register_grass2_decoration(-0.015, 0.075, 4)
register_grass2_decoration(0, 0.06, 3)
register_grass2_decoration(0.015, 0.045, 2)
register_grass2_decoration(0.03, 0.03, 1)

register_fern2_decoration(14934, 3)
register_fern2_decoration(802, 2)
register_fern2_decoration(6, 1)

minetest.register_decoration({
    name = "ctg_world:moss",
    deco_type = "simple",
    place_on = {"ctg_world:plantstone"},
    sidelen = 16,
    fill_ratio = 0.085,
    flags = "all_floors",
    y_max = -30,
    y_min = -6000,
    decoration = "livingcaves:moss"
})

minetest.register_decoration({
    name = "ctg_world:glow_fern",
    deco_type = "simple",
    place_on = {"ctg_world:plantstone"},
    sidelen = 16,
    fill_ratio = 0.045,
    flags = "all_floors",
    y_max = -30,
    y_min = -6000,
    decoration = "ctg_world:glow_fern"
})

minetest.register_decoration({
    name = "ctg_world:glow_plant",
    deco_type = "simple",
    place_on = {"ctg_world:plantstone"},
    sidelen = 16,
    -- place_offset_y = 1,
    fill_ratio = 0.012,
    biomes = {"caves_planty"},
    flags = "all_floors",
    y_max = -90,
    y_min = -6000,
    decoration = "ctg_world:glow_plant"
})

if minetest.get_modpath("fireflies") then
    minetest.register_decoration({
        name = "fireflies:cave_firefly_low",
        deco_type = "simple",
        place_on = "ctg_world:plantstone",
        place_offset_y = 2,
        sidelen = 80,
        fill_ratio = 0.0003,
        biomes = {"caves_planty"},
        flags = "all_floors",
        y_max = -90,
        y_min = -6000,
        decoration = "fireflies:hidden_firefly"
    })

    minetest.register_decoration({
        name = "fireflies:cave_firefly_high",
        deco_type = "simple",
        place_on = "ctg_world:plantstone",
        place_offset_y = 3,
        sidelen = 80,
        fill_ratio = 0.0003,
        biomes = {"caves_planty"},
        flags = "all_floors",
        y_max = -90,
        y_min = -6000,
        decoration = "fireflies:hidden_firefly"
    })

    -- get decoration IDs
    local firefly_low = minetest.get_decoration_id("fireflies:cave_firefly_low")
    local firefly_high = minetest.get_decoration_id("fireflies:cave_firefly_high")

    minetest.set_gen_notify({
        decoration = true
    }, {firefly_low, firefly_high})

    -- start nodetimers
    minetest.register_on_generated(function(minp, maxp, blockseed)
        local gennotify = minetest.get_mapgen_object("gennotify")
        local poslist = {}

        for _, pos in ipairs(gennotify["decoration#" .. firefly_low] or {}) do
            local firefly_low_pos = {
                x = pos.x,
                y = pos.y + 3,
                z = pos.z
            }
            table.insert(poslist, firefly_low_pos)
        end
        for _, pos in ipairs(gennotify["decoration#" .. firefly_high] or {}) do
            local firefly_high_pos = {
                x = pos.x,
                y = pos.y + 4,
                z = pos.z
            }
            table.insert(poslist, firefly_high_pos)
        end

        if #poslist ~= 0 then
            for i = 1, #poslist do
                local pos = poslist[i]
                minetest.get_node_timer(pos):start(1)
            end
        end
    end)

end
