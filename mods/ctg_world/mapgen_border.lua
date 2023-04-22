local S = minetest.get_translator("ctg_world")

local border = {}
local gap = {}

border.layer = 30912 -- default
border.width = 50 -- default
gap.min = 2000 -- default
gap.max = 4000 -- default

local deep_y = tonumber(minetest.settings:get("ctg_world.space_border.height"))
if deep_y ~= nil then
    border.layer = deep_y
end
local width = tonumber(minetest.settings:get("ctg_world.space_border.width"))
if width ~= nil then
    border.width = width
end

local gap_min = tonumber(minetest.settings:get("ctg_world.space_gap.min"))
if gap_min ~= nil then
    gap.min = gap_min
end
local gap_max = tonumber(minetest.settings:get("ctg_world.space_gap.max"))
if gap_max ~= nil then
    gap.max = gap_max
end

-- solid radioactive border
minetest.register_node("ctg_world:skyrock", {
    description = S("Sky Wall"),
    -- tiles = {"atmos_thin.png^[colorize:#a8753208"},
    tiles = {"blank.png^[colorize:#a8753208"},
    inventory_image = "vacuum_inv.png",
    wield_image = "vacuum_inv.png",
    drawtype = "liquid",
    use_texture_alpha = "blend",
    paramtype = "light",
    light_source = 13,
    sunlight_propagates = true,
    is_ground_content = false,
    buildable_to = false,
    diggable = false,
    pointable = false,
    post_effect_color = {
        a = 100,
        r = 200,
        g = 50,
        b = 30
    },
    groups = {
        immortal = 1,
        unbreakable = 1,
        not_in_creative_inventory = 1,
        radioactive = 2
    },
    on_blast = function()
    end,
    on_destruct = function()
    end,
    can_dig = function()
        return false
    end,
    sounds = {},
    drop = {}
})

-- non-solid less radioactive border
minetest.register_node("ctg_world:skyshock", {
    description = S("Sky Bounds"),
    tiles = {"atmos_thin.png^[colorize:#32a87f15"},
    --tiles = {"blank.png^[colorize:#32a87f15"},
    inventory_image = "vacuum_inv.png",
    wield_image = "vacuum_inv.png",
    drawtype = "liquid",
    use_texture_alpha = "blend",
    paramtype = "light",
    sunlight_propagates = true,
    is_ground_content = false,
    buildable_to = false,
    walkable = false,
    diggable = false,
    pointable = false,
    post_effect_color = {
        a = 80,
        r = 200,
        g = 60,
        b = 30
    },
    groups = {
        immortal = 1,
        unbreakable = 1,
        not_in_creative_inventory = 1,
        radioactive = 1
    },
    on_blast = function()
    end,
    on_destruct = function()
    end,
    can_dig = function()
        return false
    end,
    sounds = {},
    drop = {}
})

-- non-solid border
minetest.register_node("ctg_world:skygap", {
    description = S("Lower Sky Gap"),
    --tiles = {"atmos_thin.png^[colorize:#32a87f25"},
    tiles = {"blank.png^[colorize:#32a87f15"},
    inventory_image = "vacuum_inv.png",
    wield_image = "vacuum_inv.png",
    drawtype = "airlike",
    use_texture_alpha = "blend",
    paramtype = "light",
    sunlight_propagates = true,
    is_ground_content = false,
    buildable_to = false,
    walkable = false,
    diggable = false,
    pointable = false,
    post_effect_color = {
        a = 10,
        r = 20,
        g = 60,
        b = 150
    },
    groups = {
        immortal = 1,
        unbreakable = 1,
        not_in_creative_inventory = 1
    },
    on_blast = function()
    end,
    on_destruct = function()
    end,
    can_dig = function()
        return false
    end,
    sounds = {},
    drop = {}
})

minetest.register_on_generated(function(minp, maxp)
    -- space/deepspace border
    if maxp.y <= border.layer + border.width and minp.y >= border.layer - border.width then
        local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
        local data = vm:get_data()
        local area = VoxelArea:new({
            MinEdge = emin,
            MaxEdge = emax
        })
        local c_skyrock = minetest.get_content_id("ctg_world:skyrock")
        local c_skyshock = minetest.get_content_id("ctg_world:skyshock")

        for y = minp.y, maxp.y do
            if y <= border.layer + 1 and y >= border.layer - 1 then
                for x = minp.x, maxp.x do
                    for z = minp.z, maxp.z do
                        local p_pos = area:index(x, y, z)
                        data[p_pos] = c_skyrock
                    end
                end
            else
                for x = minp.x, maxp.x do
                    for z = minp.z, maxp.z do
                        local p_pos = area:index(x, y, z)
                        data[p_pos] = c_skyshock
                    end
                end
            end
        end

        vm:set_data(data)
        vm:calc_lighting()
        vm:update_liquids()
        vm:write_to_map()
    end

    -- ground/atmos border
    if maxp.y <= gap.max + 1 and minp.y >= gap.min then
        local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
        local data = vm:get_data()
        local area = VoxelArea:new({
            MinEdge = emin,
            MaxEdge = emax
        })
        local c_skygap = minetest.get_content_id("ctg_world:skygap")
        local c_skyshock = minetest.get_content_id("ctg_world:skyshock")

        for y = minp.y, maxp.y do
            if y <= gap.max - 100 and y >= gap.max - 100 then
                for x = minp.x, maxp.x do
                    for z = minp.z, maxp.z do
                        local p_pos = area:index(x, y, z)
                        data[p_pos] = c_skygap --c_skyshock
                    end
                end
            else
                for x = minp.x, maxp.x do
                    for z = minp.z, maxp.z do
                        local p_pos = area:index(x, y, z)
                        data[p_pos] = c_skygap
                    end
                end
            end
        end

        vm:set_data(data)
        vm:calc_lighting()
        vm:update_liquids()
        vm:write_to_map()
    end
end)
