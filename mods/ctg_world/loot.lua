--[[
local default_loot = {
    -- various items
    { name = "default:stick", chance = 0.6, count = { 3, 6 } },
    { name = "default:flint", chance = 0.4, count = { 1, 3 } },

    -- farming / consumable
    { name = "default:apple", chance = 0.4, count = { 1, 4 } },
    {
        name = "default:cactus",
        chance = 0.4,
        count = { 1, 4 },
        types = { "sandstone", "desert" }
    },

    -- minerals
    { name = "default:coal_lump",    chance = 0.9, count = { 1, 12 } },
    { name = "default:gold_ingot",   chance = 0.5 },
    { name = "default:steel_ingot",  chance = 0.4, count = { 1, 6 } },
    { name = "default:mese_crystal", chance = 0.1, count = { 2, 3 } },

    -- tools
    { name = "default:sword_wood",   chance = 0.6 },
    { name = "default:pick_stone",   chance = 0.3 },
    { name = "default:axe_diamond",  chance = 0.05 },

    -- natural materials
    {
        name = "default:sand",
        chance = 0.8,
        count = { 4, 32 },
        y = { -64, 32768 },
        types = { "normal" }
    },
    {
        name = "default:desert_sand",
        chance = 0.8,
        count = { 4, 32 },
        y = { -64, 32768 },
        types = { "sandstone" }
    },
    {
        name = "default:desert_cobble",
        chance = 0.8,
        count = { 4, 32 },
        types = { "desert" }
    },
    {
        name = "default:snow",
        chance = 0.8,
        count = { 8, 64 },
        y = { -64, 32768 },
        types = { "ice" }
    },
    {
        name = "default:dirt",
        chance = 0.6,
        count = { 2, 16 },
        y = { -64, 32768 },
        types = { "normal", "sandstone", "desert" }
    },
    { name = "default:obsidian",    chance = 0.25, count = { 1, 3 },    y = { -32768, -512 } },
    { name = "default:mese",        chance = 0.15, y = { -32768, -512 } },

    -- bucket mod
    { name = "bucket:bucket_empty", chance = 0.55 },
    -- water in deserts/ice or above ground, lava otherwise
    {
        name = "bucket:bucket_water",
        chance = 0.45,
        types = { "sandstone", "desert", "ice" }
    },
    {
        name = "bucket:bucket_water",
        chance = 0.45,
        y = { 0, 32768 },
        types = { "normal" }
    },
    {
        name = "bucket:bucket_lava",
        chance = 0.45,
        y = { -32768, -1 },
        types = { "normal" }
    },
    { name = "carts:rail",     chance = 0.35, count = { 1, 6 } },
    { name = "farming:string", chance = 0.5,  count = { 1, 8 } },
    { name = "farming:wheat",  chance = 0.5,  count = { 2, 5 } },
    {
        name = "farming:seed_cotton",
        chance = 0.4,
        count = { 1, 4 },
        types = { "normal" }
    },
    {
		name = "vessels:glass_fragments", chance = 0.35, count = {1, 4}
	},
    { name = 'x_farming:seed_obsidian_wart', chance = 0.3, count = { 1, 2 } },
    { name = 'x_farming:seed_pumpkin', chance = 0.4, count = { 1, 4 } },
    { name = 'x_farming:seed_beetroot', chance = 0.4, count = { 1, 4 } },
    { name = 'x_farming:seed_carrot', chance = 0.4, count = { 1, 4 } },
    { name = 'x_farming:seed_potato', chance = 0.4, count = { 1, 4 } },
    { name = 'x_farming:seed_coffee', chance = 0.4, count = { 1, 4 } },
    { name = 'x_farming:seed_corn', chance = 0.4, count = { 1, 4 } },
    { name = 'x_farming:seed_melon', chance = 0.4, count = { 1, 4 } },
    { name = 'x_farming:cocoa_bean', chance = 0.4, count = { 1, 4 } },
    { name = 'x_farming:large_cactus_with_fruit_seedling', chance = 0.4, count = { 1, 1 } },
    { name = 'x_farming:kiwi_sapling', chance = 0.4, count = { 1, 1 } },
    { name = 'x_farming:seed_strawberry', chance = 0.4, count = { 1, 4 } },

}
--]]
--local ctg_loot = {}

--dungeon_loot.register(ctg_loot)
