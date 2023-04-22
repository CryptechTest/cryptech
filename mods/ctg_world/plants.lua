-- Papyrus
minetest.register_decoration({
    name = "default:papyrus",
    deco_type = "simple",
    place_on = { "group:sand" },
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
    place_on = { "default:dirt" },
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
    biomes = { "rainforest_swamp" },
    y_max = 0,
    y_min = 0,
    schematic = minetest.get_modpath("default") .. "/schematics/papyrus_on_dirt.mts"
})

minetest.register_decoration({
    name = 'x_farming:salt_7',
    deco_type = 'schematic',
    place_on = { 'default:dirt', 'default:dry_dirt', 'group:sand' },
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
    biomes = { 'rainforest_swamp', 'savanna_shore' },
    y_max = 0,
    y_min = 0,
    schematic = minetest.get_modpath('x_farming') .. '/schematics/x_farming_salt_decor.mts'
})


local drop_nodes = {
    "livingcaves:rootcave_bigroot",
    "livingcaves:rootcave_bigroot2",
    "livingcaves:rootcave_hangingroot",
    "livingcaves:rootcave_hangingroot2",
    "livingcaves:rootcave_smallroot",
    "livingcaves:rootcave_smallroot2",
    "livingcaves:hangingmold",
    "livingcaves:hangingmoldend",
    "livingcaves:hangingmoss",
    "livingcaves:hangingmossend",
    "livingcaves:lichen",
    "livingcaves:glowshroom",
    "livingcaves:glowshroom_top",
    "livingcaves:moss"
}

local function get_node_drops(node)
    if node.name == "default:papyrus" then
        if math.random(10) == 1 then
            return nil
        end
        return {}
    end
    return minetest.get_node_drops(node)
end

-- weird nodes near water
minetest.register_abm({
    label = "cave plants water interact",
    nodenames = drop_nodes,
    neighbors = { "default:water_flowing", "default:water_source" },
    interval = 3,
    chance = 2,
    max_y = 1000,
    min_y = -11000,
    action = function(pos)
        local node = minetest.get_node(pos)
        minetest.set_node(pos, { name = "air" })

        for _, drop in pairs(get_node_drops(node)) do
            minetest.add_item(pos, ItemStack(drop))
        end
    end
})

minetest.register_abm({
    label = "cave plants lava interact",
    nodenames = drop_nodes,
    neighbors = { "default:lava_flowing", "default:lava_source" },
    interval = 2,
    chance = 1,
    max_y = 1000,
    min_y = -11000,
    action = function(pos)
        local node = minetest.get_node(pos)
        minetest.set_node(pos, { name = "air" })

        for _, drop in pairs(get_node_drops(node)) do
            minetest.add_item(pos, ItemStack(drop))
        end
    end
})

local function add_thorns(name)
    for itemstring, def in pairs(minetest.registered_nodes) do
        if name == itemstring then
            local node = minetest.registered_nodes[name]
            local marked_groups = node.groups
            marked_groups.thorns = 1
            minetest.override_item(name, { groups = marked_groups })
        end
    end
end

local function init_plants()
    add_thorns("saltd:thorny_bush")
end

minetest.after(0, init_plants)

minetest.register_craftitem('ctg_world:sugar', {
    description = S('Sugar'),
    short_description = S('Sugar'),
    inventory_image = 'x_farming_sugar.png',
    groups = { flammable = 1, food_sugar = 1 },
})

minetest.register_craft({
    type = 'shapeless',
    output = 'ctg_world:sugar',
    recipe = { 'default:papyrus' }
})

minetest.clear_craft({ output = "scifi_nodes:plant1" })
minetest.clear_craft({ output = "scifi_nodes:plant2" })
minetest.clear_craft({ output = "scifi_nodes:plant3" })
minetest.clear_craft({ output = "scifi_nodes:plant4" })
minetest.clear_craft({ output = "scifi_nodes:plant5" })
minetest.clear_craft({ output = "scifi_nodes:plant6" })
minetest.clear_craft({ output = "scifi_nodes:plant7" })
minetest.clear_craft({ output = "scifi_nodes:plant8" })
minetest.clear_craft({ output = "scifi_nodes:plant9" })
minetest.clear_craft({ output = "scifi_nodes:plant10" })
minetest.clear_craft({ output = "scifi_nodes:plant_trap" })

for i = 1, #aquaz.coral_deco do
    local def = minetest.registered_nodes[aquaz.coral_deco[i].name]
    local marked_groups = def.groups
    marked_groups.hunger_amount = 4
    -- Let's hack the node!
    minetest.override_item(aquaz.coral_deco[i].name, {
        description = S(aquaz.coral_deco[i].description) .. '\n' ..
            minetest.colorize(x_farming.colors.brown, S('Hunger') .. ': 4'),
        groups = marked_groups,
        on_use = function(itemstack, user, pointed_thing)
            local hunger_amount = minetest.get_item_group(itemstack:get_name(), "hunger_amount") or 0
            if hunger_amount == 0 then
                return itemstack
            end
            return minetest.item_eat(hunger_amount)(itemstack, user, pointed_thing)
        end
    })
end
