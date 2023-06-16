local S = minetest.get_translator(minetest.get_current_modname())

-- glowberry_bush_leaves_with_berries
minetest.register_node("ctg_world:glowberry_bush_leaves_with_berries", {
    description = S("Glow Bush Leaves with Berries"),
    drawtype = "allfaces_optional",
    tiles = { "cave_leaves_glow.png" },
    paramtype = "light",
    light_source = 7,
    groups = {
        snappy = 3,
        flammable = 2,
        leaves = 1,
        dig_immediate = 3,
        leafdecay = 3
    },
    drop = "ctg_world:glowberries",
    sounds = default.node_sound_leaves_defaults(),
    node_dig_prediction = "ctg_world:glowberry_bush_leaves",
    after_dig_node = function(pos, oldnode, oldmetadata, digger)
        local ticks = tonumber(oldmetadata.fields.ticks or "0")
        minetest.set_node(pos, {
            name = "ctg_world:glowberry_bush_leaves"
        })
        if (ticks < 3) then
            minetest.get_node_timer(pos):start(math.random(900, 4500))
            local meta = minetest.get_meta(pos)
            meta:set_int("ticks", ticks)
        end
    end
})

-- glowberry_bush_leaves
minetest.register_node("ctg_world:glowberry_bush_leaves", {
    description = S("Glow Bush Leaves"),
    drawtype = "allfaces_optional",
    tiles = { "cave_leaves.png" },
    paramtype = "light",
    light_source = 2,
    groups = {
        snappy = 3,
        flammable = 2,
        leaves = 1,
        leafdecay = 3
    },
    drop = {
        max_items = 1,
        items = { {
            items = { "ctg_world:glowberry_bush_sapling" },
            rarity = 20
        }, {
            items = { "ctg_world:glowberry_bush_leaves" }
        } }
    },
    sounds = default.node_sound_leaves_defaults(),
    on_timer = function(pos, elapsed)
        if minetest.get_node_light(pos) > 11 or minetest.get_node_light(pos) < 1 then
            minetest.get_node_timer(pos):start(300)
        else
            local meta_old = minetest.get_meta(pos)
            local ticks = meta_old:get_int("ticks") or 0
            minetest.set_node(pos, {
                name = "ctg_world:glowberry_bush_leaves_with_berries"
            })
            local meta = minetest.get_meta(pos)
            meta:set_int("ticks", ticks + 1)
        end
    end,
    after_place_node = default.after_place_leaves
})

---------------------------------------------------------

local function can_grow(pos)
    local node_under = minetest.get_node_or_nil({
        x = pos.x,
        y = pos.y - 1,
        z = pos.z
    })
    if not node_under then
        return false
    end
    if (node_under.name ~= "ctg_world:plantstone") then
        if minetest.get_item_group(node_under.name, "soil") == 0 then
            return false
        end
    end
    local light_level = minetest.get_node_light(pos)
    if not light_level or light_level > 12 then
        return false
    end
    return true
end

local function grow_berry_bush(pos)
    if not can_grow(pos) then
        -- try again 5 min later
        minetest.get_node_timer(pos):start(300)
        return
    end
    local path = minetest.get_modpath("ctg_world") .. "/schematics/cave_bush_2.mts"
    minetest.place_schematic({
        x = pos.x - 1,
        y = pos.y - 0,
        z = pos.z - 1
    }, path, "random", nil, false)
end

local function x_grow_berry_bush(pos)
    if not can_grow(pos) then
        return false
    end
    local path = minetest.get_modpath("ctg_world") .. "/schematics/cave_bush_2.mts"
    minetest.place_schematic({
        x = pos.x - 1,
        y = pos.y - 0,
        z = pos.z - 1
    }, path, "random", nil, false)
    return true
end

-- bush sapling
minetest.register_node("ctg_world:glowberry_bush_sapling", {
    description = S("Glowberry Bush Sapling"),
    drawtype = "plantlike",
    tiles = { "ctg_glowberry_sapling.png" },
    inventory_image = "ctg_glowberry_sapling.png",
    wield_image = "ctg_glowberry_sapling.png",
    paramtype = "light",
    light_source = 2,
    sunlight_propagates = true,
    walkable = false,
    on_timer = grow_berry_bush,
    selection_box = {
        type = "fixed",
        fixed = { -4 / 16, -0.5, -4 / 16, 4 / 16, 2 / 16, 4 / 16 }
    },
    groups = {
        snappy = 2,
        dig_immediate = 3,
        flammable = 2,
        attached_node = 1,
        sapling = 1
    },
    sounds = default.node_sound_leaves_defaults(),
    on_construct = function(pos)
        minetest.get_node_timer(pos):start(math.random(900, 2500))
    end,
    on_place = function(itemstack, placer, pointed_thing)
        itemstack = default.sapling_on_place(itemstack, placer, pointed_thing, "ctg_world:glowberry_bush_sapling",
            -- minp, maxp to be checked, relative to sapling pos
            {
                x = -1,
                y = 0,
                z = -1
            }, {
                x = 1,
                y = 1,
                z = 1
            }, -- maximum interval of interior volume check
            2)

        return itemstack
    end
})

-- leaf decay
default.register_leafdecay({
    trunks = { 'default:bush_stem' },
    leaves = { 'ctg_world:glowberry_bush_leaves', 'ctg_world:glowberry_bush_leaves_with_berries' },
    radius = 3
})

-- bonemeal register
if (minetest.get_modpath("x_farming")) then
    x_farming.x_bonemeal:register_tree_defs({ {
        name = 'ctg_world:glowberry_bush_sapling',
        chance = 3,
        grow_tree = x_grow_berry_bush
    } })
end

---------------------------------------------------------

-- food
minetest.register_craftitem("ctg_world:glowberries", {
    description = S('Glowberries') .. '\n' ..
        minetest.colorize(x_farming.colors.brown, S('Hunger') .. ': 2'),
    inventory_image = "ctg_glowberries.png",
    groups = {
        food_berry = 1,
        food_glowberry = 1,
        hunger_amount = 2
    },
    light_source = 6,
    on_use = function(itemstack, user, pointed_thing)
        local hunger_amount = minetest.get_item_group(itemstack:get_name(), "hunger_amount") or 0
        if hunger_amount == 0 then
            return itemstack
        end
        return minetest.item_eat(hunger_amount)(itemstack, user, pointed_thing)
    end
})

-- food: glowberry
minetest.register_node('ctg_world:glowberry_bowl', {
    description = S('Bowl of Glowberries') .. '\n' .. S('Compost chance') .. ': 100%\n' ..
        minetest.colorize(x_farming.colors.brown, S('Hunger') .. ': 14'),
    short_description = S('Bowl of Blue-Glowberries'),
    drawtype = 'mesh',
    mesh = 'x_farming_beetroot_soup.obj',
    tiles = { 'ctg_bowl_glowberries_mesh.png' },
    inventory_image = 'ctg_bowl_glowberries.png',
    wield_image = 'ctg_bowl_glowberries.png',
    paramtype = 'light',
    paramtype2 = 'facedir',
    is_ground_content = false,
    walkable = true,
    selection_box = {
        type = 'fixed',
        fixed = { -0.5, -0.5, -0.5, 0.5, 0.1, 0.5 }
    },
    collision_box = {
        type = 'fixed',
        fixed = { -0.5, -0.5, -0.5, 0.5, -0.1, 0.5 }
    },
    groups = {
        vessel = 1,
        dig_immediate = 3,
        attached_node = 1,
        compost = 100,
        hunger_amount = 14
    },
    light_source = 7,
    on_use = function(itemstack, user, pointed_thing)
        local hunger_amount = minetest.get_item_group(itemstack:get_name(), "hunger_amount") or 0
        if hunger_amount == 0 then
            return itemstack
        end
        return minetest.item_eat(hunger_amount, 'x_farming:bowl')(itemstack, user, pointed_thing)
    end,
    sounds = default.node_sound_wood_defaults(),
    sunlight_propagates = true
})

-- food craft recipe
minetest.register_craft({
    output = 'ctg_world:glowberry_bowl',
    type = 'shapeless',
    recipe = { 'ctg_world:glowberries', 'ctg_world:blueberry_mix_bowl' }
})

-- food: glowberry mix
minetest.register_node('ctg_world:glowberry_bowl_mix', {
    description = S('Bowl of Mixed Glowberries') .. '\n' .. S('Compost chance') .. ': 100%\n' ..
        minetest.colorize(x_farming.colors.brown, S('Hunger') .. ': 16'),
    short_description = S('Bowl of Mixed Glowberries'),
    drawtype = 'mesh',
    mesh = 'x_farming_beetroot_soup.obj',
    tiles = { 'ctg_bowl_glowberries2_mesh.png' },
    inventory_image = 'ctg_bowl_glowberries2.png',
    wield_image = 'ctg_bowl_glowberries2.png',
    paramtype = 'light',
    paramtype2 = 'facedir',
    is_ground_content = false,
    walkable = true,
    selection_box = {
        type = 'fixed',
        fixed = { -0.5, -0.5, -0.5, 0.5, 0.1, 0.5 }
    },
    collision_box = {
        type = 'fixed',
        fixed = { -0.5, -0.5, -0.5, 0.5, -0.1, 0.5 }
    },
    groups = {
        vessel = 1,
        dig_immediate = 3,
        attached_node = 1,
        compost = 100,
        hunger_amount = 16
    },
    light_source = 6,
    on_use = function(itemstack, user, pointed_thing)
        local hunger_amount = minetest.get_item_group(itemstack:get_name(), "hunger_amount") or 0
        if hunger_amount == 0 then
            return itemstack
        end
        return minetest.item_eat(hunger_amount, 'x_farming:bowl')(itemstack, user, pointed_thing)
    end,
    sounds = default.node_sound_wood_defaults(),
    sunlight_propagates = true
})

-- food craft recipe
minetest.register_craft({
    output = 'ctg_world:glowberry_bowl_mix',
    type = 'shapeless',
    recipe = { 'ctg_world:glowberries', 'ctg_world:glowberry_bowl', 'livingcaves:hangingmossend2' }
})

-- food: blueberry mix
minetest.register_node('ctg_world:blueberry_mix_bowl', {
    description = S('Bowl of Mixed Blueberries') .. '\n' .. S('Compost chance') .. ': 100%\n' ..
        minetest.colorize(x_farming.colors.brown, S('Hunger') .. ': 12'),
    short_description = S('Bowl of Mixed Blueberries'),
    drawtype = 'mesh',
    mesh = 'x_farming_beetroot_soup.obj',
    tiles = { 'ctg_bowl_berry_mix_mesh.png' },
    inventory_image = 'ctg_bowl_berry_mix.png',
    wield_image = 'ctg_bowl_berry_mix.png',
    paramtype = 'light',
    paramtype2 = 'facedir',
    is_ground_content = false,
    walkable = true,
    selection_box = {
        type = 'fixed',
        fixed = { -0.5, -0.5, -0.5, 0.5, 0.1, 0.5 }
    },
    collision_box = {
        type = 'fixed',
        fixed = { -0.5, -0.5, -0.5, 0.5, -0.1, 0.5 }
    },
    groups = {
        vessel = 1,
        dig_immediate = 3,
        attached_node = 1,
        compost = 100,
        hunger_amount = 12
    },
    light_source = 5,
    on_use = function(itemstack, user, pointed_thing)
        local hunger_amount = minetest.get_item_group(itemstack:get_name(), "hunger_amount") or 0
        if hunger_amount == 0 then
            return itemstack
        end
        return minetest.item_eat(hunger_amount, 'x_farming:bowl')(itemstack, user, pointed_thing)
    end,
    sounds = default.node_sound_wood_defaults(),
    sunlight_propagates = true
})

-- food craft recipe
minetest.register_craft({
    output = 'ctg_world:blueberry_mix_bowl',
    type = 'shapeless',
    recipe = { 'ctg_world:glowberries', 'ctg_world:blueberry_bowl' }
})

-- food: blueberry
minetest.register_node('ctg_world:blueberry_bowl', {
    description = S('Bowl of Blueberries') .. '\n' .. S('Compost chance') .. ': 100%\n' ..
        minetest.colorize(x_farming.colors.brown, S('Hunger') .. ': 11'),
    short_description = S('Bowl of Blueberries'),
    drawtype = 'mesh',
    mesh = 'x_farming_beetroot_soup.obj',
    tiles = { 'ctg_bowl_blueberries_mesh.png' },
    inventory_image = 'ctg_bowl_blueberries.png',
    wield_image = 'ctg_bowl_blueberries.png',
    paramtype = 'light',
    paramtype2 = 'facedir',
    is_ground_content = false,
    walkable = true,
    selection_box = {
        type = 'fixed',
        fixed = { -0.5, -0.5, -0.5, 0.5, 0.1, 0.5 }
    },
    collision_box = {
        type = 'fixed',
        fixed = { -0.5, -0.5, -0.5, 0.5, -0.1, 0.5 }
    },
    groups = {
        vessel = 1,
        dig_immediate = 3,
        attached_node = 1,
        compost = 100,
        hunger_amount = 11
    },
    on_use = function(itemstack, user, pointed_thing)
        local hunger_amount = minetest.get_item_group(itemstack:get_name(), "hunger_amount") or 0
        if hunger_amount == 0 then
            return itemstack
        end
        return minetest.item_eat(hunger_amount, 'x_farming:bowl')(itemstack, user, pointed_thing)
    end,
    sounds = default.node_sound_wood_defaults(),
    sunlight_propagates = true
})

-- food craft recipe
minetest.register_craft({
    output = 'ctg_world:blueberry_bowl',
    recipe = { { 'default:blueberries', 'group:food_sugar', 'default:blueberries' },
        { 'default:blueberries', 'default:blueberries', 'default:blueberries' }, { '', 'x_farming:bowl', '' } }
})

-- food: strawberry
minetest.register_node('ctg_world:strawberry_bowl', {
    description = S('Bowl of Strawberries') .. '\n' .. S('Compost chance') .. ': 100%\n' ..
        minetest.colorize(x_farming.colors.brown, S('Hunger') .. ': 11'),
    short_description = S('Bowl of Strawberries'),
    drawtype = 'mesh',
    mesh = 'x_farming_beetroot_soup.obj',
    tiles = { 'ctg_bowl_strawberries_mesh.png' },
    inventory_image = 'ctg_bowl_strawberries.png',
    wield_image = 'ctg_bowl_strawberries.png',
    paramtype = 'light',
    paramtype2 = 'facedir',
    is_ground_content = false,
    walkable = true,
    selection_box = {
        type = 'fixed',
        fixed = { -0.5, -0.5, -0.5, 0.5, 0.1, 0.5 }
    },
    collision_box = {
        type = 'fixed',
        fixed = { -0.5, -0.5, -0.5, 0.5, -0.1, 0.5 }
    },
    groups = {
        vessel = 1,
        dig_immediate = 3,
        attached_node = 1,
        compost = 100,
        hunger_amount = 11
    },
    on_use = function(itemstack, user, pointed_thing)
        local hunger_amount = minetest.get_item_group(itemstack:get_name(), "hunger_amount") or 0
        if hunger_amount == 0 then
            return itemstack
        end
        return minetest.item_eat(hunger_amount, 'x_farming:bowl')(itemstack, user, pointed_thing)
    end,
    sounds = default.node_sound_wood_defaults(),
    sunlight_propagates = true
})

-- food craft recipe
minetest.register_craft({
    output = 'ctg_world:strawberry_bowl',
    recipe = { { 'x_farming:strawberry', 'group:food_sugar', 'x_farming:strawberry' },
        { 'x_farming:strawberry', 'x_farming:strawberry', 'x_farming:strawberry' }, { '', 'x_farming:bowl', '' } }
})

-- food: mixed strawberry blueberry
minetest.register_node('ctg_world:strawberry_bowl_mix', {
    description = S('Bowl of Strawberries and Blueberries') .. '\n' .. S('Compost chance') .. ': 100%\n' ..
        minetest.colorize(x_farming.colors.brown, S('Hunger') .. ': 13'),
    short_description = S('Bowl of mixed sweet berries'),
    drawtype = 'mesh',
    mesh = 'x_farming_beetroot_soup.obj',
    tiles = { 'ctg_bowl_strawberries_mix_mesh.png' },
    inventory_image = 'ctg_bowl_strawberries_mix.png',
    wield_image = 'ctg_bowl_strawberries_mix.png',
    paramtype = 'light',
    paramtype2 = 'facedir',
    is_ground_content = false,
    walkable = true,
    selection_box = {
        type = 'fixed',
        fixed = { -0.5, -0.5, -0.5, 0.5, 0.1, 0.5 }
    },
    collision_box = {
        type = 'fixed',
        fixed = { -0.5, -0.5, -0.5, 0.5, -0.1, 0.5 }
    },
    groups = {
        vessel = 1,
        dig_immediate = 3,
        attached_node = 1,
        compost = 100,
        hunger_amount = 13
    },
    on_use = function(itemstack, user, pointed_thing)
        local hunger_amount = minetest.get_item_group(itemstack:get_name(), "hunger_amount") or 0
        if hunger_amount == 0 then
            return itemstack
        end
        return minetest.item_eat(hunger_amount, 'x_farming:bowl')(itemstack, user, pointed_thing)
    end,
    sounds = default.node_sound_wood_defaults(),
    sunlight_propagates = true
})

-- food craft recipe
minetest.register_craft({
    output = 'ctg_world:strawberry_bowl_mix 2',
    type = "shapeless",
    recipe = { 'ctg_world:strawberry_bowl', 'ctg_world:blueberry_bowl' }
})

if minetest.get_modpath("bottles") then
    local function make_bottle(spec)
        local on_drink = function(itemstack, placer)
            return minetest.item_eat(spec.feed_amount, 'vessels:glass_bottle')
        end

        local contents_node = minetest.registered_items[spec.contents[1]]
        if not contents_node then
            return false
        end

        if spec.image then
            -- do nothing
        elseif contents_node.inventory_image and type(contents_node.inventory_image) == "string" then
            spec.image = contents_node.inventory_image
        elseif contents_node.tiles and type(contents_node.tiles[1]) == "string" then
            spec.image = contents_node.tiles[1]
        elseif contents_node.tiles and type(contents_node.tiles[1]) == "table" then
            spec.image = contents_node.tiles[1].name
        else
            return false
        end

        local contents_node2 = minetest.registered_items[spec.contents[2]]
        local liquid_image = ""
        if contents_node2 and contents_node2.inventory_image and type(contents_node2.inventory_image) == "string" then
            liquid_image = contents_node2.inventory_image
        end

        spec.image = "[combine:16x16:0,0=" .. liquid_image .. "^" .. spec.image .. "^[opacity:128" ..
            "^vessels_glass_bottle_mask.png^[makealpha:0,254,0"
        spec.name = "ctg_world:" .. spec.name

        -- Ensure that name is not already in use, fail registration if so
        if bottles.registered_filled_bottles[spec.name] then
            return false
        end

        -- Normalize target type
        if spec.target_type == "string" then
            spec.target = { spec.target }
        end

        -- Ensure that target nodes are not already in use, fail registration if so
        for _, target in ipairs(spec.target) do
            if bottles.target_node_map[target] then
                return false
            end
        end

        -- Map target nodes to spec
        for _, target in ipairs(spec.target) do
            bottles.target_node_map[target] = spec
        end

        -- Put bottle into map of registered filled bottles
        bottles.registered_filled_bottles[spec.name] = spec

        -- Register new bottle node
        minetest.register_node(spec.name, {
            description = spec.description .. '\n' ..
                minetest.colorize(x_farming.colors.brown, S('Hunger') .. ': ' .. spec.feed_amount),
            short_description = spec.description,
            drawtype = "plantlike",
            tiles = { spec.image },
            inventory_image = spec.image,
            wield_image = spec.image,
            paramtype = "light",
            is_ground_content = false,
            walkable = false,
            selection_box = {
                type = "fixed",
                fixed = { -0.25, -0.5, -0.25, 0.25, 0.3, 0.25 }
            },
            groups = spec.groups,
            sounds = default.node_sound_glass_defaults(),
            on_use = on_drink()
        })

        minetest.register_craft({
            output = spec.name .. " " .. spec.craft_recieve_count,
            type = 'shapeless',
            recipe = spec.contents
        })
    end

    -- drinks
    make_bottle({
        target = { "x_farming:strawberry" },
        sound = "default_water_footstep",
        contents = { "x_farming:strawberry", "x_farming:bottle_soymilk" },
        name = "bottle_of_strawberry_milk",
        description = "Bottle of Strawberry Milk",
        craft_recieve_count = 1,
        groups = {
            vessel = 1,
            dig_immediate = 3,
            attached_node = 1,
            food_milk = 1
        },
        feed_amount = 4
    })

    make_bottle({
        target = { "default:blueberries" },
        sound = "default_water_footstep",
        contents = { "default:blueberries", "x_farming:bottle_soymilk" },
        name = "bottle_of_blueberry_milk",
        description = "Bottle of Blueberry Milk",
        craft_recieve_count = 1,
        groups = {
            vessel = 1,
            dig_immediate = 3,
            attached_node = 1,
            food_milk = 1
        },
        feed_amount = 4
    })

    make_bottle({
        target = { "x_farming:bottle_coffee" },
        sound = "default_water_footstep",
        contents = { "x_farming:bottle_coffee", "x_farming:bottle_soymilk" },
        name = "bottle_of_coffe_with_milk",
        description = "Bottle of Coffee with Milk",
        craft_recieve_count = 2,
        groups = {
            vessel = 1,
            dig_immediate = 3,
            attached_node = 1,
            food_milk = 1
        },
        feed_amount = 4
    })

    make_bottle({
        target = { "x_farming:chocolate" },
        sound = "default_water_footstep",
        contents = { "x_farming:chocolate", "x_farming:bottle_soymilk" },
        name = "bottle_of_chocolate_milk",
        image = "x_farming_cocoa_bean.png",
        description = "Bottle of Chocolate Milk",
        craft_recieve_count = 1,
        groups = {
            vessel = 1,
            dig_immediate = 3,
            attached_node = 1,
            food_milk = 1
        },
        feed_amount = 4
    })

    -- hot cup of coffee
    local coffee_cup_hot_desc = S('Hot Cup of Coffee with Milk') .. '\n' ..
        minetest.colorize(x_farming.colors.brown, S('Hunger') .. ': 7')

    minetest.register_node('ctg_world:coffee_cup_hot_2', {
        description = coffee_cup_hot_desc,
        short_description = coffee_cup_hot_desc,
        drawtype = 'mesh',
        mesh = 'x_farming_coffee_cup_hot.obj',
        tiles = { 'x_farming_coffee_cup_hot_mesh.png' },
        inventory_image = 'x_farming_coffee_cup_hot.png',
        wield_image = 'x_farming_coffee_cup_hot.png',
        paramtype = 'light',
        paramtype2 = 'facedir',
        is_ground_content = false,
        walkable = true,
        selection_box = {
            type = 'fixed',
            fixed = { -0.25, -0.5, -0.4, 0.25, 0.5, 0.25 }
        },
        collision_box = {
            type = 'fixed',
            fixed = { -0.25, -0.5, -0.4, 0.25, 0, 0.25 }
        },
        groups = {
            vessel = 1,
            dig_immediate = 3,
            attached_node = 1,
            hunger_amount = 7
        },
        on_use = function(itemstack, user, pointed_thing)
            local hunger_amount = minetest.get_item_group(itemstack:get_name(), "hunger_amount") or 0
            if hunger_amount == 0 then
                return itemstack
            end
            return minetest.item_eat(hunger_amount)(itemstack, user, pointed_thing)
        end,
        sounds = default.node_sound_glass_defaults(),
        sunlight_propagates = true
    })

    minetest.register_craft({
        output = "ctg_world:coffee_cup_hot_2",
        type = 'cooking',
        recipe = "ctg_world:bottle_of_coffe_with_milk"
    })

    -- hot cup of coffee
    local coffee_cup_hot_desc = S('Hotish Cup of Coffee with Cream') .. '\n' ..
        minetest.colorize(x_farming.colors.brown, S('Hunger') .. ': 7')

    minetest.register_node('ctg_world:coffee_cup_hot_3', {
        description = coffee_cup_hot_desc,
        short_description = coffee_cup_hot_desc,
        drawtype = 'mesh',
        mesh = 'x_farming_coffee_cup_hot.obj',
        tiles = { 'ctg_coffee_cup_hot_mesh.png' },
        inventory_image = 'ctg_coffee_cup_hot.png',
        wield_image = 'ctg_coffee_cup_hot.png',
        paramtype = 'light',
        paramtype2 = 'facedir',
        is_ground_content = false,
        walkable = true,
        selection_box = {
            type = 'fixed',
            fixed = { -0.25, -0.5, -0.4, 0.25, 0.5, 0.25 }
        },
        collision_box = {
            type = 'fixed',
            fixed = { -0.25, -0.5, -0.4, 0.25, 0, 0.25 }
        },
        groups = {
            vessel = 1,
            dig_immediate = 3,
            attached_node = 1,
            hunger_amount = 7
        },
        on_use = function(itemstack, user, pointed_thing)
            local hunger_amount = minetest.get_item_group(itemstack:get_name(), "hunger_amount") or 0
            if hunger_amount == 0 then
                return itemstack
            end
            return minetest.item_eat(hunger_amount)(itemstack, user, pointed_thing)
        end,
        sounds = default.node_sound_glass_defaults(),
        sunlight_propagates = true
    })

    minetest.register_craft({
        output = "ctg_world:coffee_cup_hot_3",
        type = "shapeless",
        recipe = {"ctg_world:coffee_cup_hot_2"}
    })
end

-- grub
minetest.register_craft({
	output = "livingcavesmobs:grub",
	type = "shapeless",
	recipe =
	{ "livingcavesmobs:mothegg", "ctg_world:glowberry_bush_leaves", "ctg_world:glowberry_bush_leaves", "ctg_world:glowberry_bush_leaves" }
})
