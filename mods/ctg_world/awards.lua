local S = minetest.get_translator("ctg_world")


awards.register_award("award_conqueror_of_the_skies1", {
    title = S("Conqueror of the Skies I"),
    description = S("Upgrade to a Bronze Jetpack."),
    difficulty = 0.0,
    icon = "award_conqueror_of_the_skies.png^awards_level1.png",
    trigger = {
        type = "craft",
        item = "ctg_jetpack:jetpack_bronze",
        target = 1
    }
})

awards.register_award("award_conqueror_of_the_skies2", {
    title = S("Conqueror of the Skies II"),
    description = S("Upgrade to a Iron Jetpack."),
    difficulty = 0.5,
    icon = "award_conqueror_of_the_skies.png^awards_level2.png",
    requires = { "award_conqueror_of_the_skies1" },
    trigger = {
        type = "craft",
        item = "ctg_jetpack:jetpack_iron",
        target = 1
    }
})

awards.register_award("award_conqueror_of_the_skies3", {
    title = S("Conqueror of the Skies III"),
    description = S("Upgrade to a Titanium Jetpack."),
    difficulty = 1.0,
    icon = "award_conqueror_of_the_skies.png^awards_level3.png",
    requires = { "award_conqueror_of_the_skies1", "award_conqueror_of_the_skies2" },
    trigger = {
        type = "craft",
        item = "ctg_jetpack:jetpack_titanium",
        target = 1
    }
})

awards.register_award("award_crystal_conqueror", {
    title = S("Crystal Conqueror"),
    description = S("Break 10 glowing crystals."),
    icon = "award_crystal_conqueror.png",
    trigger = {
        type = "dig",
        node = "group:crystal",
        target = 10
    }
})

awards.register_award("award_metal_miner_extraordinaire", {
    title = S("Metal Miner Extraordinaire"),
    description = S("Break 50 Aluminum Ore."),
    icon = "award_metal_miner_extraordinaire.png",
    trigger = {
        type = "dig",
        node = "group:aluminum_ore",
        target = 50
    }
})

awards.register_award("award_glow_bush_harvester", {
    title = S("Glow Bush Harvester"),
    description = S("Break 50 glow bush leaves."),
    icon = "award_glow_bush_harvester.png",
    trigger = {
        type = "dig",
        node = "ctg_world:glowberry_bush_leaves",
        target = 50
    }
})

awards.register_award("award_needed_a_little_effort", {
    title = S("Just needed a little effort"),
    description = S("Break a Corestone Diamond Ore node."),
    icon = "award_needed_a_little_effort.png",
    trigger = {
        type = "dig",
        node = "ctg_world:corestone_with_diamond",
        target = 1
    }
})

awards.register_award("award_glowing_and_juicy", {
    title = S("Glowing and Juicy"),
    description = S("Eat 10 Bowls of Glowberries."),
    icon = "award_glowing_and_juicy.png",
    trigger = {
        type = "eat",
        item = "farming:bread",
        target = 10
    }
})

awards.register_award("award_red_sky_martyr", {
    title = S("Red Sky Martyr"),
    description = S("Die in Red Sky Space."),
    icon = "award_red_sky_martyr.png",
    secret = true,
})

awards.register_award("award_radiant_peril", {
    title = S("Radiant Peril"),
    description = S("Die in the radiatin barrier."),
    icon = "award_radiant_peril.png",
    secret = true,
})

awards.register_award("award_deep_space_demise", {
    title = S("Deep Space Demise"),
    description = S("Die in Deep Space."),
    icon = "award_deep_space_demise.png",
    secret = true,
})

awards.register_award("award_life_support_engineer", {
    title = S("Life Support Engineer"),
    description = S("Place an Air Pump in space."),
    icon = "award_life_support_engineer.png",
    secret = true,
})



awards.register_on_death(function(player, data)
    local pos = player:get_pos()
    if pos and pos.y >= 16000 and pos.y <= 22000 then
        return "award_red_sky_martyr"
    elseif pos and pos.y >= 19800 and pos.y <= 22200 then
        return "award_radiant_peril"
    elseif pos and pos.y >= 22200 then
        return "award_deep_space_demise"
    end
    return nil
end)

awards.register_on_place(function(player, data)
    local pos = player:get_pos()
    if pos and pos.y >= 4000 and data.name == "vacuum:airpump" then
        return "award_life_support_engineer"
    end
    return nil
end)
