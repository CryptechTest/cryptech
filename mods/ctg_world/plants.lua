-- Papyrus
minetest.register_decoration({
    name = "default:papyrus",
    deco_type = "simple",
    place_on = {"group:sand"},
    sidelen = 16,
    noise_params = {
        offset = -0.3,
        scale = 0.7,
        spread = {
            x = 100,
            y = 100,
            z = 100
        },
        seed = 354,
        octaves = 3,
        persist = 0.7
    },
    y_max = 1,
    y_min = 1,
    decoration = "default:papyrus",
    height = 2,
    height_max = 4,
    spawn_by = "default:water_source",
    num_spawn_by = 1
})

minetest.register_decoration({
    name = "default:papyrus_on_dirt",
    deco_type = "schematic",
    place_on = {"default:dirt"},
    sidelen = 16,
    noise_params = {
        offset = -0.3,
        scale = 0.7,
        spread = {
            x = 200,
            y = 200,
            z = 200
        },
        seed = 354,
        octaves = 3,
        persist = 0.7
    },
    biomes = {"rainforest_swamp"},
    y_max = 0,
    y_min = 0,
    schematic = minetest.get_modpath("default") .. "/schematics/papyrus_on_dirt.mts"
})

minetest.register_decoration({
    name = 'x_farming:salt_7',
    deco_type = 'schematic',
    place_on = {'default:dirt', 'default:dry_dirt', 'group:sand'},
    sidelen = 16,
    noise_params = {
        offset = -0.3,
        scale = 0.7,
        spread = {
            x = 200,
            y = 200,
            z = 200
        },
        seed = 354,
        octaves = 3,
        persist = 0.7
    },
    biomes = {'rainforest_swamp', 'savanna_shore'},
    y_max = 0,
    y_min = 0,
    schematic = minetest.get_modpath('x_farming') .. '/schematics/x_farming_salt_decor.mts'
})
