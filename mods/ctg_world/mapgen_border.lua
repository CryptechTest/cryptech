local S = minetest.get_translator("ctg_world")

local border = {}

border.layer = 30912 -- default
border.node = {
    name = "ctg_world:skyrock"
}

local y = tonumber(minetest.settings:get("ctg_world.deepsace_y"))
if y ~= nil then
    border.layer = y
end

minetest.register_node("ctg_world:skyrock", {
    description = S("Sky Wall"),
    --tiles = {"atmos_thin.png^[colorize:#a8753208"},
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
	post_effect_color = {a = 100, r = 200, g = 50, b = 30},
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

minetest.register_node("ctg_world:skyshock", {
    description = S("Sky Bounds"),
    --tiles = {"atmos_thin.png^[colorize:#32a87f15"},
    tiles = {"blank.png^[colorize:#32a87f15"},
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
	post_effect_color = {a = 80, r = 200, g = 60, b = 30},
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

minetest.register_on_generated(function(minp, maxp)
    if maxp.y <= border.layer + 50 and minp.y >= border.layer - 50 then
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
end)
