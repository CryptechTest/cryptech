local function flowery_particle(pos, params)
    local move_up = true
    local time = 0.1
    local amount = 15
    local minsize = 0.5
    local maxsize = 1
    local minexptime = 1.25
    local maxexptime = 1.5
    local glow = 8
    local color = '#371fde'
    if params then
        if params.move_up ~= nil then
            move_up = params.move_up
        end
        if params.time then
            time = params.time
        end
        if params.amount then
            amount = params.amount
        end
        if params.minsize then
            minsize = params.minsize
        end
        if params.maxsize then
            maxsize = params.maxsize
        end
        if params.minexptime then
            minexptime = params.minexptime
        end
        if params.minexptime then
            minexptime = params.minexptime
        end
        if params.glow ~= nil then
            glow = params.glow
        end
        if params.color ~= nil then
            color = params.color
        end
    end
    local y_vel = 1
    if not move_up then
        y_vel = -1
    end
    if (params and params.y_velocity) then
        y_vel = params.y_velocity
        if not move_up then
            y_vel = -params.y_velocity
        end
    end
    minetest.add_particlespawner({
        amount = amount,
        time = time,
        minpos = {
            x = pos.x - 0.1,
            y = pos.y - 0.20,
            z = pos.z - 0.1
        },
        maxpos = {
            x = pos.x + 0.1,
            y = pos.y - 0.25,
            z = pos.z + 0.1
        },
        minvel = {
            x = -0.25,
            y = -0,
            z = -0.25
        },
        maxvel = {
            x = 0.25,
            y = -0,
            z = 0.25
        },
        minacc = {
            x = -0.45,
            y = y_vel,
            z = -0.45
        },
        maxacc = {
            x = 0.45,
            y = y_vel * 2,
            z = 0.45
        },
        minsize = minsize,
        maxsize = maxsize,
        minexptime = minexptime,
        maxexptime = maxexptime,
        texture = 'x_farming_default_particle.png^[colorize:' .. color .. ':200',
        collisiondetection = true,
        glow = glow
    })
end

-- Plants

minetest.register_node("ctg_world:jungle_foliage_small", {
    description = "Jungle Foliage",
    short_description = "Jungle Foliage",

    paramtype = 'light',
    drawtype = "plantlike",
    waving = 1,
    visual_scale = 1.88,
    tiles = {"jungle_bush1.png"},
    inventory_image = "jungle_bush1.png",
    wield_image = "jungle_bush1.png",
    sunlight_propagates = true,
    buildable_to = true,
    groups = {
        snappy = 3,
        flora = 1,
        attached_node = 1,
        flammable = 1,
        compost = 20
    },

    move_resistance = 2,

    selection_box = {
        type = "fixed",
        fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16}
    },

    drop = {
        max_items = 1,
        items = {{
            --  1/20 chance
            items = {'ctg_world:jungle_foliage_small'},
            rarity = 10
        }}
    },

    is_ground_content = false,
    walkable = false,

    sounds = default.node_sound_leaves_defaults()
})

-- glowy jungle bush
minetest.register_node("ctg_world:jungle_foliage_bush", {
    description = "Glow Jungle Foliage",
    short_description = "Jungle Foliage",
    paramtype = 'light',
    drawtype = "plantlike",
    light_source = 4,
    waving = 1,
    visual_scale = 1.56,
    tiles = {"jungle_bush2.png"},
    inventory_image = "jungle_bush2.png",
    wield_image = "jungle_bush2.png",
    sunlight_propagates = true,
    buildable_to = true,
    groups = {
        snappy = 3,
        flora = 1,
        attached_node = 1,
        flammable = 1,
        compost = 60,
        enchanted_flora = 1
    },

    move_resistance = 5,

    selection_box = {
        type = "fixed",
        fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16}
    },

    is_ground_content = false,
    walkable = false,

    sounds = default.node_sound_leaves_defaults(),

    drop = {
        max_items = 1,
        items = {{
            --  1/20 chance
            items = {'ctg_world:jungle_foliage_bush'},
            rarity = 10
        }}
    },

    on_punch = function(pos, node, puncher, pointed_thing)
        if not puncher then
            return
        end

        local plnt_pos = {
            x = pos.x,
            y = pos.y + 0.7,
            z = pos.z
        }
        flowery_particle(plnt_pos, {
            time = math.random(1, 2),
            amount = math.random(3, 7),
            minsize = 0.2,
            maxsize = 0.5,
            move_up = true,
            glow = 8,
            maxexptime = 2,
            y_velocity = 0.6,
            color = '#f5bd2f'
        })
    end
})

minetest.register_node("ctg_world:jungle_foliage_fern", {
    description = "Jungle Fern",
    short_description = "Jungle Fern",
    paramtype = 'light',
    drawtype = "plantlike",
    waving = 1,
    visual_scale = 1.472,
    tiles = {"jungle_bush3.png"},
    inventory_image = "jungle_bush3.png",
    wield_image = "jungle_bush3.png",
    sunlight_propagates = true,
    buildable_to = true,
    groups = {
        snappy = 3,
        flora = 1,
        attached_node = 1,
        flammable = 1,
        compost = 40
    },

    selection_box = {
        type = "fixed",
        fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16}
    },

    drop = {
        max_items = 1,
        items = {{
            --  1/20 chance
            items = {'ctg_world:jungle_foliage_fern'},
            rarity = 10
        }}
    },

    is_ground_content = false,
    walkable = false,

    sounds = default.node_sound_leaves_defaults()
})

-- Jungle tree small
minetest.register_decoration({
    name = "ctg_world:jungle_tree_small",
    deco_type = "schematic",
    place_on = {"default:dirt_with_rainforest_litter", "default:dirt_with_grass", "default:dirt"},
    sidelen = 50,
    fill_ratio = 0.024,
    biomes = {"rainforest"},
    y_max = 1000,
    y_min = -10,
    schematic = minetest.get_modpath("ctg_world") .. "/schematics/jungle_tree_small.mts",
    flags = "place_center_x, place_center_z",
    rotation = "random"
})

-- Jungle Plants

minetest.register_decoration({
    name = "ctg_world:jungle_plant1",
    deco_type = "simple",
    place_on = {"default:dirt_with_rainforest_litter"},
    sidelen = 80,
    fill_ratio = 0.04,
    biomes = {"rainforest"},
    y_max = 1000,
    y_min = 2,
    decoration = "ctg_world:jungle_foliage_small"
})

minetest.register_decoration({
    name = "ctg_world:jungle_plant2",
    deco_type = "simple",
    place_on = {"default:dirt_with_rainforest_litter"},
    sidelen = 80,
    fill_ratio = 0.02,
    biomes = {"rainforest"},
    y_max = 1000,
    y_min = 5,
    decoration = "ctg_world:jungle_foliage_bush"
})

minetest.register_decoration({
    name = "ctg_world:jungle_plant3",
    deco_type = "simple",
    place_on = {"default:dirt_with_rainforest_litter"},
    sidelen = 80,
    fill_ratio = 0.042,
    biomes = {"rainforest"},
    y_max = 1000,
    y_min = -4,
    decoration = "ctg_world:jungle_foliage_fern"
})

-- jungle ferns

local function register_fern_decoration(seed, length)
    minetest.register_decoration({
        name = "ctg_world:jungle_fern_" .. length,
        deco_type = "simple",
        place_on = {"default:dirt_with_rainforest_litter"},
        sidelen = 32,
        noise_params = {
            offset = 0,
            scale = 0.46,
            spread = {
                x = 100,
                y = 100,
                z = 100
            },
            seed = seed,
            octaves = 3,
            persist = 0.7
        },
        biomes = {"rainforest"},
        y_max = 1000,
        y_min = -13,
        decoration = "default:fern_" .. length
    })
end

register_fern_decoration(13736, 3)
register_fern_decoration(956, 2)
register_fern_decoration(25, 1)

-- jungle grasses

local function register_grass_decoration(offset, scale, length)
    minetest.register_decoration({
        name = "ctg_world:jungle_grass_" .. length,
        deco_type = "simple",
        place_on = {"default:dirt_with_rainforest_litter"},
        sidelen = 16,
        noise_params = {
            offset = offset,
            scale = scale - 0.02,
            spread = {
                x = 500,
                y = 500,
                z = 500
            },
            seed = 329,
            octaves = 3,
            persist = 0.6
        },
        biomes = {"rainforest"},
        y_max = 1000,
        y_min = -15,
        decoration = "default:grass_" .. length
    })
end

register_grass_decoration(-0.03, 0.09, 5)
register_grass_decoration(-0.015, 0.075, 4)
register_grass_decoration(0, 0.06, 3)
register_grass_decoration(0.015, 0.045, 2)
register_grass_decoration(0.03, 0.03, 1)

-- jungle moss

minetest.register_decoration({
    deco_type = "simple",
    place_on = {"x_farming:jungle_leaves", "default:jungleleaves"},
    biomes = {"rainforest"},
    sidelen = 16,
    fill_ratio = 0.01,
    flags = "place_center_x,place_center_z,all_ceilings",
    y_max = 1000,
    y_min = 10,
    -- schematic = minetest.get_modpath("livingcaves") .. "/schematics/livingcaves_hangingmoss.mts",
    decoration = "livingcaves:hangingmossend",
    rotation = "random"
})

minetest.register_decoration({
    deco_type = "simple",
    place_on = {"x_farming:jungle_leaves", "default:jungleleaves"},
    biomes = {"rainforest"},
    sidelen = 16,
    fill_ratio = 0.007,
    flags = "place_center_x,place_center_z,all_ceilings",
    y_max = 1000,
    y_min = 10,
    -- schematic = minetest.get_modpath("livingcaves") .. "/schematics/livingcaves_hangingmoss2.mts",
    decoration = "livingcaves:hangingmoldend",
    rotation = "random"
})

-- flowery abm

minetest.register_abm({
    label = "jungle plant particle effects",
    nodenames = {"ctg_world:jungle_foliage_bush"},
    neighbors = {"default:dirt_with_rainforest_litter"},
    interval = 6,
    chance = 3,
    min_y = -11000,
    max_y = 1000,
    action = function(pos, node)
        local tod = minetest.get_timeofday()
        local is_day = false
        if tod > 0.2 and tod < 0.760 then
            is_day = true
        end
        local amount = math.random(4, 8)
        if is_day then
            amount = amount * 0.3
        end
        if amount <= 0 then
            return
        end
        local time = math.random(2.0, 4.0)
        local plnt_pos = {
            x = pos.x,
            y = pos.y + 0.7,
            z = pos.z
        }
        flowery_particle(plnt_pos, {
            time = time,
            amount = amount + 1,
            minsize = 0.125,
            maxsize = 0.3,
            move_up = true,
            glow = 7,
            maxexptime = 3,
            y_velocity = 0.57
        })
        flowery_particle(plnt_pos, {
            time = time,
            amount = amount,
            minsize = 0.125,
            maxsize = 0.3,
            move_up = true,
            glow = 7,
            maxexptime = 3,
            y_velocity = 0.54,
            color = '#f5bd2f'
        })
    end
})
