-- dough
core.register_craftitem('ctg_foods:dough_bread', {
    description = ('Bread Dough') .. '\n' .. ('Compost chance') .. ': 50%',
    short_description = ('Bread Dough'),
    inventory_image = 'ctg_foods_dough.png',
    groups = {
        dough = 1,
        -- X Farming
        compost = 50,
        -- MCL
        compostability = 50
    },
    _mcl_blast_resistance = 0
})

core.register_craft({
    type = 'shapeless',
    output = 'ctg_foods:dough_bread',
    recipe = {'group:food_flour', 'group:food_flour', 'group:food_flour', 'group:food_sugar', 'group:food_water'},
    replacements = {{'group:food_water', 'vessels:glass_bottle'}}
})

core.register_craft({
    type = 'cooking',
    cooktime = 20,
    output = 'farming:bread 4',
    recipe = 'ctg_foods:dough_bread'
})

-- preztel bread
core.register_craftitem('ctg_foods:dough_pretzel', {
    description = ('Pretzel Dough') .. '\n' .. ('Compost chance') .. ': 50%',
    short_description = ('Pretzel Dough'),
    inventory_image = 'ctg_foods_dough_pretzel.png',
    groups = {
        dough = 1,
        -- X Farming
        compost = 50,
        -- MCL
        compostability = 50
    },
    _mcl_blast_resistance = 0
})

local pretzel_bread_def = {
    description = ('Pretzel Bread') .. '\n' .. ('Compost chance') .. ': 85%\n' ..
        core.colorize(x_farming.colors.brown, ('Hunger') .. ': 6'),
    inventory_image = 'ctg_foods_bread_pretzel.png',
    wield_scale = 0.95,
    groups = {
        -- MTG
        food_bread = 1,
        food_pretzel = 1,
        flammable = 2,
        -- X Farming
        compost = 85,
        -- MCL
        food = 2,
        eatable = 5,
        compostability = 85
    },
    _mcl_saturation = 6.0
}

if core.get_modpath('farming') then
    pretzel_bread_def.on_use = core.item_eat(6)
end

core.register_craftitem('ctg_foods:pretzel_bread', pretzel_bread_def)

core.register_craft({
    type = 'cooking',
    cooktime = 20,
    output = 'ctg_foods:pretzel_bread 4',
    recipe = 'ctg_foods:dough_pretzel'
})

-- pretzel
local pretzel_def = {
    description = ('Pretzel') .. '\n' .. ('Compost chance') .. ': 85%\n' ..
        core.colorize(x_farming.colors.brown, ('Hunger') .. ': 5'),
    inventory_image = 'ctg_foods_pretzel.png',
    wield_scale = 0.7,
    groups = {
        -- MTG
        food_bread = 1,
        food_pretzel = 1,
        flammable = 2,
        -- X Farming
        compost = 85,
        -- MCL
        food = 2,
        eatable = 5,
        compostability = 85
    },
    _mcl_saturation = 6.0
}

if core.get_modpath('farming') then
    pretzel_def.on_use = core.item_eat(5)
end

core.register_craftitem('ctg_foods:pretzel', pretzel_def)

core.register_craftitem('ctg_foods:pretzel_raw', {
    description = ('Pretzel Raw') .. '\n' .. ('Compost chance') .. ': 50%',
    short_description = ('Pretzel Raw'),
    inventory_image = 'ctg_foods_raw_pretzel.png',
    groups = {
        dough = 1,
        -- X Farming
        compost = 50,
        -- MCL
        compostability = 50
    },
    _mcl_blast_resistance = 0
})

core.register_craft({
    type = 'shapeless',
    output = 'ctg_foods:dough_pretzel',
    recipe = {'group:food_flour', 'group:food_flour', 'group:food_flour', 'group:food_sugar', 'group:food_water',
              "group:food_salt"},
    replacements = {{'group:food_water', 'vessels:glass_bottle'}}
})

core.register_craft({
    type = 'shapeless',
    output = 'ctg_foods:pretzel_raw 10',
    recipe = {'ctg_foods:dough_pretzel', 'ctg_foods:dough_pretzel', 'ctg_foods:dough_pretzel'}
})

core.register_craft({
    type = 'cooking',
    cooktime = 16,
    output = 'ctg_foods:pretzel',
    recipe = 'ctg_foods:pretzel_raw'
})

-- potato
local potato_bread = {
    description = ('Potato Bread') .. '\n' .. ('Compost chance') .. ': 85%\n' ..
        core.colorize(x_farming.colors.brown, ('Hunger') .. ': 7'),
    inventory_image = 'ctg_foods_bread_potato.png',
    -- wield_scale = 0.7,
    groups = {
        -- MTG
        food_bread = 1,
        flammable = 2,
        -- X Farming
        compost = 85,
        -- MCL
        food = 2,
        eatable = 5,
        compostability = 85
    },
    _mcl_saturation = 6.0
}

if core.get_modpath('farming') then
    potato_bread.on_use = core.item_eat(7)
end

core.register_craftitem('ctg_foods:bread_potato', potato_bread)

core.register_craftitem('ctg_foods:dough_bread_potato', {
    description = ('Potato Bread Dough') .. '\n' .. ('Compost chance') .. ': 50%',
    short_description = ('Potato Bread Dough'),
    inventory_image = 'ctg_foods_dough_potato.png',
    groups = {
        dough = 1,
        -- X Farming
        compost = 50,
        -- MCL
        compostability = 50
    },
    _mcl_blast_resistance = 0
})

core.register_craft({
    type = 'shapeless',
    output = 'ctg_foods:dough_bread_potato',
    recipe = {'group:food_flour', 'group:food_flour', 'x_farming:potato', 'group:food_sugar', 'group:food_water',
              "group:food_salt"},
    replacements = {{'group:food_water', 'vessels:glass_bottle'}}
})

core.register_craft({
    type = 'cooking',
    cooktime = 16,
    output = 'ctg_foods:bread_potato 4',
    recipe = 'ctg_foods:dough_bread_potato'
})

-- corn
local corn_bread = {
    description = ('Corn Bread') .. '\n' .. ('Compost chance') .. ': 80%\n' ..
        core.colorize(x_farming.colors.brown, ('Hunger') .. ': 5'),
    short_description = ('Corn Bread Dough'),
    inventory_image = 'ctg_foods_bread_corn.png',
    wield_scale = 0.7,
    groups = {
        -- MTG
        food_bread = 1,
        flammable = 2,
        -- X Farming
        compost = 80,
        -- MCL
        food = 2,
        eatable = 5,
        compostability = 80
    },
    _mcl_saturation = 6.0
}

if core.get_modpath('farming') then
    corn_bread.on_use = core.item_eat(5)
end

core.register_craftitem('ctg_foods:bread_corn', corn_bread)

core.register_craftitem('ctg_foods:dough_bread_corn', {
    description = ('Corn Bread Dough') .. '\n' .. ('Compost chance') .. ': 50%',
    short_description = ('Corn Bread Dough'),
    inventory_image = 'ctg_foods_dough_corn.png',
    groups = {
        dough = 1,
        -- X Farming
        compost = 50,
        -- MCL
        compostability = 50
    },
    _mcl_blast_resistance = 0
})

core.register_craft({
    type = 'shapeless',
    output = 'ctg_foods:dough_bread_corn',
    recipe = {'group:food_flour', 'group:food_sugar', 'group:food_flour', 'x_farming:corn', 'group:food_water',
              'x_farming:corn'},
    replacements = {{'group:food_water', 'vessels:glass_bottle'}}
})

core.register_craft({
    type = 'cooking',
    cooktime = 15,
    output = 'ctg_foods:bread_corn 5',
    recipe = 'ctg_foods:dough_bread_corn'
})

if core.get_modpath('mobs') then
    -- brownies
    local brownie_mix = {
        description = ('Brownie') .. '\n' .. ('Compost chance') .. ': 80%\n' ..
            core.colorize(x_farming.colors.brown, ('Hunger') .. ': 4'),
        short_description = ('Brownie'),
        inventory_image = 'ctg_foods_brownie.png',
        wield_scale = 0.8,
        groups = {
            -- MTG
            flammable = 2,
            -- X Farming
            compost = 80,
            -- MCL
            food = 2,
            eatable = 5,
            compostability = 80
        },
        _mcl_saturation = 6.0
    }

    if core.get_modpath('farming') then
        brownie_mix.on_use = core.item_eat(4)
    end

    core.register_craftitem('ctg_foods:brownie', brownie_mix)

    core.register_craftitem('ctg_foods:brownie_mix', {
        description = ('Brownie Mix') .. '\n' .. ('Compost chance') .. ': 60%',
        short_description = ('Brownie Mix'),
        inventory_image = 'ctg_foods_brownie_mix.png',
        groups = {
            dough = 1,
            -- X Farming
            compost = 60,
            -- MCL
            compostability = 60
        },
        _mcl_blast_resistance = 0
    })

    core.register_craft({
        type = 'shapeless',
        output = 'ctg_foods:brownie_mix',
        recipe = {'group:food_flour', 'x_farming:cocoa_bean', 'group:food_sugar', 'group:food_flour',
                  'x_farming:cocoa_bean', 'group:food_milk_glass', 'group:food_flour', 'group:food_water', 'mobs:egg'},
        replacements = {{'group:food_water', 'vessels:glass_bottle'}, {'mobs:glass_milk', 'vessels:drinking_glass'},
                        {'x_farming:bottle_soymilk', 'vessels:glass_bottle'}}
    })

    core.register_craft({
        type = 'cooking',
        cooktime = 21,
        output = 'ctg_foods:brownie 9',
        recipe = 'ctg_foods:brownie_mix'
    })
end

-- rice bowl
local rice_bowl = {
    description = ('Rice Bowl') .. '\n' .. ('Compost chance') .. ': 80%\n' ..
        core.colorize(x_farming.colors.brown, ('Hunger') .. ': 7'),
    short_description = ('Rice Bowl'),
    inventory_image = 'ctg_foods_rice_bowl.png',
    -- wield_scale = 0.7,
    groups = {
        -- MTG
        flammable = 2,
        -- X Farming
        compost = 80,
        -- MCL
        food = 2,
        eatable = 5,
        compostability = 80
    },
    _mcl_saturation = 6.0
}

if core.get_modpath('farming') then
    rice_bowl.on_use = core.item_eat(6, 'x_farming:bowl')
end

core.register_craftitem('ctg_foods:rice_bowl', rice_bowl)

core.register_craft({
    type = 'shapeless',
    output = 'ctg_foods:rice_bowl',
    recipe = {'x_farming:rice_grains', 'x_farming:rice_grains', 'x_farming:rice_grains', 'x_farming:bowl'}
})

if core.get_modpath("mobs") then
    -- fried rice
    local rice_bowl = {
        description = ('Fried Rice Bowl') .. '\n' .. ('Compost chance') .. ': 90%\n' ..
            core.colorize(x_farming.colors.brown, ('Hunger') .. ': 12'),
        short_description = ('Fried Bowl'),
        inventory_image = 'ctg_foods_fried_rice_bowl.png',
        -- wield_scale = 0.7,
        groups = {
            -- MTG
            flammable = 2,
            -- X Farming
            compost = 90,
            -- MCL
            food = 2,
            eatable = 5,
            compostability = 90
        },
        _mcl_saturation = 6.0
    }

    if core.get_modpath('farming') then
        rice_bowl.on_use = core.item_eat(11, 'x_farming:bowl')
    end

    core.register_craftitem('ctg_foods:fried_rice_bowl', rice_bowl)

    core.register_craftitem('ctg_foods:fried_rice_bowl_raw', {
        description = ('Fried Rice Bowl - Raw') .. '\n' .. ('Compost chance') .. ': 90%',
        short_description = ('Fried Rice Bowl (Raw)'),
        inventory_image = 'ctg_foods_fried_rice_raw_bowl.png',
        groups = {
            -- X Farming
            compost = 90,
            -- MCL
            compostability = 90
        },
        _mcl_blast_resistance = 0
    })

    core.register_craft({
        type = 'shapeless',
        output = 'ctg_foods:fried_rice_bowl_raw',
        recipe = {'x_farming:rice_grains', 'x_farming:rice_grains', 'x_farming:rice_grains', 'x_farming:carrot',
                  'mobs:egg', 'x_farming:soybean', 'x_farming:bowl'}
    })

    core.register_craft({
        type = 'cooking',
        cooktime = 23,
        output = 'ctg_foods:fried_rice_bowl',
        recipe = 'ctg_foods:fried_rice_bowl_raw'
    })
end

-- fruit bowl
local fruit_bowl_1 = {
    description = ('Mixed Fruit Bowl') .. '\n' .. ('Compost chance') .. ': 90%\n' ..
        core.colorize(x_farming.colors.brown, ('Hunger') .. ': 8'),
    short_description = ('Mixed Fruit Bowl'),
    inventory_image = 'ctg_foods_mixed_fruit_1.png',
    -- wield_scale = 0.7,
    groups = {
        -- MTG
        flammable = 2,
        -- X Farming
        compost = 90,
        -- MCL
        food = 2,
        eatable = 5,
        compostability = 90
    },
    _mcl_saturation = 8.0
}
local fruit_bowl_2 = {
    description = ('Mixed Fruit Bowl') .. '\n' .. ('Compost chance') .. ': 90%\n' ..
        core.colorize(x_farming.colors.brown, ('Hunger') .. ': 10'),
    short_description = ('Mixed Fruit Bowl'),
    inventory_image = 'ctg_foods_mixed_fruit_2.png',
    -- wield_scale = 0.7,
    groups = {
        -- MTG
        flammable = 2,
        -- X Farming
        compost = 90,
        -- MCL
        food = 2,
        eatable = 5,
        compostability = 90
    },
    _mcl_saturation = 10.0
}
local fruit_bowl_3 = {
    description = ('Mixed Fruit Bowl') .. '\n' .. ('Compost chance') .. ': 90%\n' ..
        core.colorize(x_farming.colors.brown, ('Hunger') .. ': 13'),
    short_description = ('Mixed Fruit Bowl'),
    inventory_image = 'ctg_foods_mixed_fruit_3.png',
    -- wield_scale = 0.7,
    groups = {
        -- MTG
        flammable = 2,
        -- X Farming
        compost = 90,
        -- MCL
        food = 2,
        eatable = 5,
        compostability = 90
    },
    _mcl_saturation = 13.0
}

if core.get_modpath('farming') then
    fruit_bowl_1.on_use = core.item_eat(8, 'x_farming:bowl')
    fruit_bowl_2.on_use = core.item_eat(10, 'x_farming:bowl')
    fruit_bowl_3.on_use = core.item_eat(13, 'x_farming:bowl')
end

core.register_craftitem('ctg_foods:fruit_bowl_1', fruit_bowl_1)
core.register_craftitem('ctg_foods:fruit_bowl_2', fruit_bowl_2)
core.register_craftitem('ctg_foods:fruit_bowl_3', fruit_bowl_3)

core.register_craft({
    type = 'shapeless',
    output = 'ctg_foods:fruit_bowl_1',
    recipe = {'x_farming:kiwi_fruit', 'x_farming:strawberry', 'default:blueberries', 'x_farming:bowl'}
})

core.register_craft({
    type = 'shapeless',
    output = 'ctg_foods:fruit_bowl_2',
    recipe = {'default:apple', 'group:food_sugar', 'ctg_foods:fruit_bowl_1'}
})

core.register_craft({
    type = 'shapeless',
    output = 'ctg_foods:fruit_bowl_2',
    recipe = {'x_farming:melon', 'group:food_sugar', 'ctg_foods:fruit_bowl_1'}
})

core.register_craft({
    type = 'shapeless',
    output = 'ctg_foods:fruit_bowl_2',
    recipe = {'x_farming:kiwi_fruit', 'default:apple', 'x_farming:strawberry', 'default:blueberries',
              'group:food_sugar', 'x_farming:bowl'}
})

core.register_craft({
    type = 'shapeless',
    output = 'ctg_foods:fruit_bowl_2',
    recipe = {'x_farming:kiwi_fruit', 'x_farming:melon', 'x_farming:strawberry', 'default:blueberries',
              'group:food_sugar', 'x_farming:bowl'}
})

core.register_craft({
    type = 'shapeless',
    output = 'ctg_foods:fruit_bowl_3',
    recipe = {'x_farming:kiwi_fruit', 'x_farming:cactus_fruit_item', 'default:apple', 'x_farming:strawberry',
              'default:blueberries', 'group:food_sugar', 'x_farming:bowl'}
})

core.register_craft({
    type = 'shapeless',
    output = 'ctg_foods:fruit_bowl_3',
    recipe = {'x_farming:kiwi_fruit', 'x_farming:cactus_fruit_item', 'x_farming:melon', 'x_farming:strawberry',
              'default:blueberries', 'group:food_sugar', 'x_farming:bowl'}
})

core.register_craft({
    type = 'shapeless',
    output = 'ctg_foods:fruit_bowl_3',
    recipe = {'x_farming:cactus_fruit_item', 'default:apple', 'group:food_sugar', 'ctg_foods:fruit_bowl_1'}
})

core.register_craft({
    type = 'shapeless',
    output = 'ctg_foods:fruit_bowl_3',
    recipe = {'x_farming:cactus_fruit_item', 'x_farming:melon', 'group:food_sugar', 'ctg_foods:fruit_bowl_1'}
})

core.register_craft({
    type = 'shapeless',
    output = 'ctg_foods:fruit_bowl_3',
    recipe = {'x_farming:cactus_fruit_item', 'ctg_foods:fruit_bowl_2'}
})

-------------------------------------------------------------------------------------

-- RYE
x_farming.register_plant('ctg_foods:rye', {
    description = ('Rye Seed') .. '\n' .. ('Compost chance') .. ': 30%',
    short_description = ('Rye Seed'),
    paramtype2 = 'meshoptions',
    inventory_image = 'ctg_foods_rye_seed.png',
    steps = 11,
    minlight = 13,
    maxlight = 14,
    fertility = {'grassland'},
    groups = {
        flammable = 4,
        plant = 1
    },
    place_param2 = 11
})

-- needed
local override_def = {
    description = ('Rye') .. '\n' .. ('Compost chance') .. ': 50%',
    short_description = ('Rye'),
    groups = {
        -- X Farming
        compost = 50,
        -- MCL
        compostability = 50
    },
    _mcl_blast_resistance = 0
}

core.override_item('ctg_foods:rye', override_def)

core.register_craft({
    type = 'shapeless',
    output = 'farming:flour',
    recipe = {'ctg_foods:rye', 'ctg_foods:rye', 'ctg_foods:rye'}
})

core.register_on_mods_loaded(function()
    local deco_place_on = {}
    local deco_biomes = {}

    -- MTG
    if core.get_modpath('default') then
        table.insert(deco_place_on, 'default:dry_dirt_with_dry_grass')
        table.insert(deco_place_on, 'default:dry_dirt')
        table.insert(deco_biomes, 'savanna')
        table.insert(deco_place_on, 'default:silver_sand')
        table.insert(deco_biomes, 'cold_desert')
    end

    -- Everness
    if core.get_modpath('everness') then
        table.insert(deco_place_on, 'everness:dry_dirt_with_dry_grass')
        table.insert(deco_biomes, 'everness_baobab_savanna')
    end

    -- MCL
    if core.get_modpath('mcl_core') then
        table.insert(deco_place_on, 'mcl_core:dirt_with_grass')
        table.insert(deco_biomes, 'Savanna')
        table.insert(deco_biomes, 'SavannaM')
    end

    if next(deco_place_on) and next(deco_biomes) then
        core.register_decoration({
            name = 'ctg_foods:rye',
            deco_type = 'simple',
            place_on = deco_place_on,
            sidelen = 16,
            noise_params = {
                offset = -0.1,
                scale = 0.105,
                spread = {
                    x = 60,
                    y = 60,
                    z = 60
                },
                seed = 4201,
                octaves = 3,
                persist = 0.7
            },
            biomes = deco_biomes,
            y_max = 31000,
            y_min = 1,
            decoration = {'ctg_foods:rye_3', 'ctg_foods:rye_5', 'ctg_foods:rye_6', 'ctg_foods:rye_7', 'ctg_foods:rye_8',
                          'ctg_foods:rye_9', 'ctg_foods:rye_11'},
            param2 = 11
        })
    end
end)

-- rye bread
local rye_bread = {
    description = ('Rye Bread') .. '\n' .. ('Compost chance') .. ': 85%\n' ..
        core.colorize(x_farming.colors.brown, ('Hunger') .. ': 7'),
    inventory_image = 'ctg_foods_bread_rye.png',
    -- wield_scale = 0.7,
    groups = {
        -- MTG
        food_bread = 1,
        flammable = 2,
        -- X Farming
        compost = 85,
        -- MCL
        food = 2,
        eatable = 5,
        compostability = 85
    },
    _mcl_saturation = 6.0
}

if core.get_modpath('farming') then
    rye_bread.on_use = core.item_eat(7)
end

core.register_craftitem('ctg_foods:bread_rye', rye_bread)

core.register_craftitem('ctg_foods:dough_bread_rye', {
    description = ('Rye Bread Dough') .. '\n' .. ('Compost chance') .. ': 50%',
    short_description = ('Rye Bread Dough'),
    inventory_image = 'ctg_foods_dough_rye.png',
    groups = {
        dough = 1,
        -- X Farming
        compost = 50,
        -- MCL
        compostability = 50
    },
    _mcl_blast_resistance = 0
})

core.register_craft({
    type = 'shapeless',
    output = 'ctg_foods:dough_bread_rye',
    recipe = {'group:food_flour', 'group:food_flour', 'group:food_flour', 'ctg_foods:rye', 'ctg_foods:rye',
              'group:food_sugar', 'group:food_water', "group:food_salt"},
    replacements = {{'group:food_water', 'vessels:glass_bottle'}}
})

core.register_craft({
    type = 'cooking',
    cooktime = 16,
    output = 'ctg_foods:bread_rye 5',
    recipe = 'ctg_foods:dough_bread_rye'
})

if core.get_modpath("technic") then
    -- flour from rye seed
    technic.register_grinder_recipe({input = {"ctg_foods:seed_rye 2"}, output = "farming:flour"})
    -- flour from barley seed
    technic.register_grinder_recipe({input = {"x_farming:seed_barley 2"}, output = "x_farming:flour"})
end