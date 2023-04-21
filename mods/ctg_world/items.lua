local S = minetest.get_translator(minetest.get_current_modname())

-- disable old recipes

minetest.clear_craft({output = "unified_inventory:bag_small"})
minetest.clear_craft({output = "unified_inventory:bag_medium"})
minetest.clear_craft({output = "unified_inventory:bag_large"})

-- new recipes

minetest.register_craft({
    output = "unified_inventory:bag_small",
    recipe = {
        {"","farming:string",""},
        {"mobs:leather", "mobs:leather", "mobs:leather"},
        {"mobs:leather", "mobs:leather", "mobs:leather"},
    },
})

minetest.register_craft({
    output = "unified_inventory:bag_medium",
    recipe = {
        {"","",""},
        {"mobs:leather", "unified_inventory:bag_small", "mobs:leather"},
        {"mobs:leather", "unified_inventory:bag_small", "mobs:leather"},
    },
})

minetest.register_craft({
    output = "unified_inventory:bag_large",
    recipe = {
        {"","",""},
        {"mobs:leather", "unified_inventory:bag_medium", "mobs:leather"},
        {"mobs:leather", "unified_inventory:bag_medium", "mobs:leather"},
    },
})