local function on_rightclick(pos, dir, check_name, replace, replace_dir, sound)
    pos.y = pos.y + dir
    if core.get_node(pos).name ~= check_name then
        return
    end
    local p2 = core.get_node(pos).param2

    core.swap_node(pos, {
        name = replace,
        param2 = p2
    })

    pos.y = pos.y - dir
    core.swap_node(pos, {
        name = replace_dir,
        param2 = p2
    })

    core.sound_play(sound, {
        pos = pos,
        gain = 0.4,
        max_hear_distance = 10
    }, true)
end

local function meseconify_door(closed_top, closed_bottom, open_top, open_bottom, sound)
    if core.registered_items[closed_bottom] then

        local function toggle_state1(pos)
            if core.get_node(pos).name == closed_bottom then
                on_rightclick(pos, 1, closed_top, open_top, open_bottom, sound)
            end
        end

        local function toggle_state2(pos)
            if core.get_node(pos).name == open_bottom then
                on_rightclick(pos, 1, closed_top, open_top, open_bottom, sound)
            end
        end

        local function toggle_state3(pos)
            if core.get_node(pos).name == closed_bottom then
                on_rightclick(pos, 1, open_top, closed_top, closed_bottom, sound)
            end
        end

        local function toggle_state4(pos)
            if core.get_node(pos).name == open_bottom then
                on_rightclick(pos, 1, open_top, closed_top, closed_bottom, sound)
            end
        end

        core.override_item(closed_bottom, {
            mesecons = {
                effector = {
                    action_on = toggle_state1,
                    action_off = toggle_state3,
                    rules = mesecon.rules.pplate
                }
            }
        })

        core.override_item(open_bottom, {
            mesecons = {
                effector = {
                    action_on = toggle_state2,
                    action_off = toggle_state4,
                    rules = mesecon.rules.pplate
                }
            }
        })
    end
end

if minetest.get_modpath("scifi_nodes") then
    local doors = {{
        base_name = "Doom",
        base_ingredient = "doors:door_obsidian_glass",
        sound = "scifi_nodes_door_normal"
    }, {
        base_name = "black",
        base_ingredient = "doors:door_steel",
        sound = "scifi_nodes_door_normal"
    }, {
        base_name = "white",
        base_ingredient = "doors:door_glass",
        sound = "scifi_nodes_door_normal"
    }, {
        base_name = "green",
        base_ingredient = "doors:door_wood",
        sound = "scifi_nodes_door_normal"
    }, {
        base_name = "blue",
        base_ingredient = "default:steelblock",
        sound = "scifi_nodes_door_normal"
    }}

    minetest.register_on_mods_loaded(function()
        for _, current_door in ipairs(doors) do
            local closed = "scifi_nodes:" .. current_door.base_name .. "_door_closed"
            local closed_top = "scifi_nodes:" .. current_door.base_name .. "_door_closed_top"
            local opened = "scifi_nodes:" .. current_door.base_name .. "_door_opened"
            local opened_top = "scifi_nodes:" .. current_door.base_name .. "_door_opened_top"
            local base_name = current_door.base_name
            local base_ingredient = current_door.base_ingredient
            local sound = current_door.sound

            meseconify_door(closed_top, closed, opened_top, opened, sound)

        end
    end)
end
