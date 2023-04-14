local S = minetest.get_translator(minetest.get_current_modname())

--- resources
minetest.register_node("ctg_world:corestone_with_coal", {
    description = S("Coal Ore"),
    tiles = {"corestone.png^default_mineral_coal.png"},
    groups = {
        cracky = 1,
        level = 4
    },
    drop = "default:coal_lump",
    sounds = default.node_sound_stone_defaults()
})

minetest.register_node("ctg_world:corestone_with_copper", {
    description = S("Copper Ore"),
    tiles = {"corestone.png^default_mineral_copper.png"},
    groups = {
        cracky = 1,
        level = 4
    },
    drop = "default:copper_lump",
    sounds = default.node_sound_stone_defaults()
})

minetest.register_node("ctg_world:corestone_with_diamond", {
    description = S("Diamond Ore"),
    tiles = {"corestone.png^default_mineral_diamond.png"},
    groups = {
        cracky = 1,
        level = 4
    },
    drop = "default:diamond",
    sounds = default.node_sound_stone_defaults()
})

minetest.register_node("ctg_world:corestone_with_gold", {
    description = S("Gold Ore"),
    tiles = {"corestone.png^default_mineral_gold.png"},
    groups = {
        cracky = 1,
        level = 4
    },
    drop = "default:gold_lump",
    sounds = default.node_sound_stone_defaults()
})

minetest.register_node("ctg_world:corestone_with_iron", {
    description = S("Iron Ore"),
    tiles = {"corestone.png^default_mineral_iron.png"},
    groups = {
        cracky = 1,
        level = 4
    },
    drop = "default:iron_lump",
    sounds = default.node_sound_stone_defaults()
})

minetest.register_node("ctg_world:corestone_with_tin", {
    description = S("Tin Ore"),
    tiles = {"corestone.png^default_mineral_tin.png"},
    groups = {
        cracky = 1,
        level = 4
    },
    drop = "default:tin_lump",
    sounds = default.node_sound_stone_defaults()
})

minetest.register_node("ctg_world:corestone_with_mese", {
    description = S("Mese Ore"),
    tiles = {"corestone.png^default_mineral_mese.png"},
    groups = {
        cracky = 1,
        level = 4,
        radioactive = 1
    },
    drop = "default:mese_crystal",
    sounds = default.node_sound_stone_defaults()
})

minetest.register_node("ctg_world:corestone_with_aluminum", {
    description = S("Aluminum Ore"),
    tiles = {"corestone.png^ctg_mineral_aluminum.png"},
    groups = {
        cracky = 1,
        level = 4
    },
    drop = "ctg_world:aluminum_lump",
    sounds = default.node_sound_stone_defaults()
})

minetest.register_node("ctg_world:corestone_with_nickel", {
    description = S("Nickel Ore"),
    tiles = {"corestone.png^ctg_mineral_nickel.png"},
    groups = {
        cracky = 1,
        level = 4
    },
    drop = "ctg_world:nickel_lump",
    sounds = default.node_sound_stone_defaults()
})

minetest.register_node("ctg_world:corestone_with_titanium", {
    description = S("Titanium Ore"),
    tiles = {"corestone.png^ctg_mineral_titanium.png"},
    groups = {
        cracky = 1,
        level = 4
    },
    drop = "ctg_world:titanium_lump",
    sounds = default.node_sound_stone_defaults()
})

----

minetest.register_node("ctg_world:corestone_with_silver", {
    description = S("Silver Ore"),
    tiles = {"corestone.png^moreores_mineral_silver.png"},
    groups = {
        cracky = 1,
        level = 4
    },
    drop = "moreores:silver_lump",
    sounds = default.node_sound_stone_defaults()
})

minetest.register_node("ctg_world:corestone_with_lead", {
    description = S("Lead Ore"),
    tiles = {"corestone.png^technic_mineral_lead.png"},
    groups = {
        cracky = 1,
        level = 4
    },
    drop = "technic:lead_lump",
    sounds = default.node_sound_stone_defaults()
})

minetest.register_node("ctg_world:corestone_with_uranium", {
    description = S("Uranium Ore"),
    tiles = {"corestone.png^technic_mineral_uranium.png"},
    groups = {
        cracky = 1,
        level = 4,
        radioactive = 1
    },
    drop = "technic:uranium_lump",
    sounds = default.node_sound_stone_defaults()
})

minetest.register_node("ctg_world:corestone_with_chromium", {
    description = S("Chromium Ore"),
    tiles = {"corestone.png^technic_mineral_chromium.png"},
    groups = {
        cracky = 1,
        level = 4
    },
    drop = "technic:chromium_lump",
    sounds = default.node_sound_stone_defaults()
})

minetest.register_node("ctg_world:corestone_with_mithril", {
    description = S("Mithril Ore"),
    tiles = {"corestone.png^moreores_mineral_mithril.png"},
    groups = {
        cracky = 1,
        level = 4
    },
    drop = "moreores:mithril_lump",
    sounds = default.node_sound_stone_defaults()
})
