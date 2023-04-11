local S = minetest.get_translator("beds")
local esc = minetest.formspec_escape
local ui = unified_inventory
local beds_cooldown = minetest.settings:get("beds_cooldown") or 300

local function get_texture(stack)
    local texture = stack:get_name()
    texture = string.gsub(texture, ":", "_")      -- replace colon with underscore
    texture = string.gsub(texture, "_bottom", "") -- remove _bottom suffix
    texture = texture .. ".png"                   -- add .png extension
    return texture
end

ui.register_button("beds", {
    type = "image",
    image = "ui_beds_icon.png",
    tooltip = "Beds"
})

ui.register_page("beds", {
    get_formspec = function(player, perplayer_formspec)
        --local player_name = player:get_player_name()
        local std_inv_x = perplayer_formspec.std_inv_x
        local bed_inv_y = 1.25
        local formspec = {
            perplayer_formspec.standard_inv_bg,
            "label[", perplayer_formspec.form_header_x, ",",
            perplayer_formspec.form_header_y, ";", esc(S("Beds")), "]"
        }

        local n = #formspec + 1
        local inv = player:get_inventory()
        for i = 1, 3 do
            for j = 1, 8 do
                local k = ((i - 1) * 8) + j
                local stack = inv:get_stack("beds", k)
                if stack ~= nil then
                    if not stack:is_empty() then
                        local name = stack:get_description() or ("bed_" .. k)
                        local meta = stack:get_meta()
                        local pos = minetest.deserialize(meta:get_string("pos"))
                        local radius = 1                          -- radius of the area to load
                        local minp = vector.subtract(pos, radius) -- minimum corner of the area to load
                        local maxp = vector.add(pos, radius)      -- maximum corner of the area to load

                        -- get a voxel manipulator for the area
                        local vm = VoxelManip(minp, maxp)

                        -- load the area into memory using read_from_map
                        vm:read_from_map(minp, maxp)

                        local node = minetest.get_node(pos)
                        if node.name ~= stack:get_name() then
                            inv:remove_item("beds", stack)
                        else
                            formspec[n] = "image_button[" ..
                                (std_inv_x + ui.list_img_offset) + ((j - 1) * 1.2) ..
                                "," ..
                                (bed_inv_y + ui.list_img_offset) * i ..
                                ";1,1;" ..
                                get_texture(stack) ..
                                ";bed" .. k ..
                                ";;false;false;]"
                            n = n + 1
                            formspec[n] = "tooltip[bed" .. k .. ";" .. esc(name) .. ";]"
                            n = n + 1
                        end
                    else
                        inv:remove_item("beds", stack)
                    end
                end
            end
        end

        return { formspec = table.concat(formspec) }
    end,
})

for i = 1, 24 do
    ui.register_page("bed" .. i, {
        get_formspec = function(player, perplayer_formspec)
            --local player_name = player:get_player_name()
            local std_inv_x = perplayer_formspec.std_inv_x
            local bed_inv_y = 1.2
            local inv = player:get_inventory()
            local stack = inv:get_stack("beds", i)
            local name = ""
            local n = "beds:bed_red"
            local formspec = {
                perplayer_formspec.standard_inv_bg,
                "label[", perplayer_formspec.form_header_x, ",",
                perplayer_formspec.form_header_y, ";", S("No Bed!"),
                "]",

            }
            if stack ~= nil then
                if stack:get_name() ~= "" then
                    name = stack:get_description() or ("bed_" .. i)
                    n = get_texture(stack)
                    local meta = stack:get_meta()
                    local pos = minetest.deserialize(meta:get_string("pos"))
                    local radius = 1                          -- radius of the area to load
                    local minp = vector.subtract(pos, radius) -- minimum corner of the area to load
                    local maxp = vector.add(pos, radius)      -- maximum corner of the area to load

                    -- get a voxel manipulator for the area
                    local vm = VoxelManip(minp, maxp)

                    -- load the area into memory using read_from_map
                    vm:read_from_map(minp, maxp)
                    local node = minetest.get_node(pos)
                    if node.name ~= stack:get_name() then
                        inv:remove_item("beds", stack)
                    else
                        formspec = {
                            perplayer_formspec.standard_inv_bg,
                            "label[", perplayer_formspec.form_header_x, ",",
                            perplayer_formspec.form_header_y, ";", esc(name),
                            "]",
                            "image_button[" ..
                            perplayer_formspec.form_header_x .. "," .. bed_inv_y .. ";1,1;" .. n .. ";icon;;false;false]",
                            "tooltip[icon;x:" .. pos.x .. " y:" .. pos.y .. " z:" .. pos.z .. ";]",
                            "label[", perplayer_formspec.form_header_x, ",",
                            perplayer_formspec.form_header_y + 2.2, ";x: ", pos.x,
                            "]",
                            "label[", perplayer_formspec.form_header_x, ",",
                            perplayer_formspec.form_header_y + 2.7, ";y: ", pos.y,
                            "]",
                            "label[", perplayer_formspec.form_header_x, ",",
                            perplayer_formspec.form_header_y + 3.2, ";z: ", pos.z,
                            "]",
                            "listcolors[#00000000;#00000000]",
                            "button[" .. std_inv_x + 2 + ui.list_img_offset .. "," ..
                            bed_inv_y .. ";6,0.8;teleport_bed" .. i .. ";" .. S("Teleport to Bed") .. "]",
                            "button[" .. std_inv_x + 2 + ui.list_img_offset .. "," ..
                            bed_inv_y * 2 .. ";6,0.8;remove;Remove Bed]",
                            "tooltip[remove;" .. S("Enter the exact bed name to remove") .. ";]",
                            "field[" ..
                            std_inv_x + 2 + ui.list_img_offset ..
                            "," .. bed_inv_y * 3 .. ";6,0.8;bedname_" .. i .. ";" .. S("Bed Name") .. ";]",
                            "button[" .. std_inv_x + 2 + ui.list_img_offset .. "," ..
                            bed_inv_y * 4 .. ";6,0.8;save_bed;" .. S("Save Name") .. "]",
                        }
                    end
                else
                    inv:remove_item("beds", stack)
                end
            end
            return { formspec = table.concat(formspec) }
        end,
    })
end

minetest.register_allow_player_inventory_action(function(player, action, inventory, info)
    -- From detached inventory -> player inventory: put & take callbacks
    if action == "put" and info.listname:find("beds") then
        return 0
    end
    if action == "take" and info.listname:find("beds") then
        return 0
    end
    if action == "move" and (info.from_list:find("beds") or info.to_list:find("beds")) then
        return 0
    end
end)

minetest.register_on_player_receive_fields(function(player, formname, fields)
    if formname ~= "" then
        return
    end

    for i = 1, 24 do
        if fields.save_bed then
            if fields["bedname_" .. i] then
                local inv = player:get_inventory()
                local stack = inv:get_stack("beds", i)
                local meta = stack:get_meta()
                meta:set_string("description", esc(fields["bedname_" .. i]))
                inv:set_stack("beds", i, stack)
                ui.set_inventory_formspec(player, "bed" .. i)
                return
            end
        elseif fields.remove then
            if fields["bedname_" .. i] then
                local inv = player:get_inventory()
                local stack = inv:get_stack("beds", i)
                local name = stack:get_description() or ("bed_" .. i)
                local hasname = false
                if fields["bedname_" .. i] == name then
                    hasname = true
                    local meta = stack:get_meta()
                    local pos = minetest.deserialize(meta:get_string("pos"))
                    inv:remove_item("beds", stack)
                    ui.set_inventory_formspec(player, ui.default)
                    if beds.spawn[player:get_player_name()] == pos then
                        beds.spawn[player:get_player_name()] = nil
                        beds.player_bed[minetest.serialize(pos)] = nil
                    end
                end
                if not hasname then
                    minetest.chat_send_player(player:get_player_name(),
                        S("You must enter the exact name of the bed into the name field to remove a bed!"))
                end
            end
        elseif fields["teleport_bed" .. i] then
            local inv = player:get_inventory()
            local stack = inv:get_stack("beds", i)
            if stack ~= nil then
                local meta = stack:get_meta()
                local pos = minetest.deserialize(meta:get_string("pos"))
                if pos ~= nil then
                    local on_cooldown = beds.bed_cooldown[minetest.serialize(pos)] or false
                    if not on_cooldown then
                        ui.set_inventory_formspec(player, ui.default)
                        player:set_pos({ x = pos.x, y = pos.y + 1, z = pos.z })
                        beds.bed_cooldown[minetest.serialize(pos)] = true
                        beds.spawn[player:get_player_name()] = pos
                        minetest.after(beds_cooldown, function()
                            beds.bed_cooldown[minetest.serialize(pos)] = false
                        end, pos)
                    else
                        minetest.chat_send_player(player:get_player_name(), S("This bed is on cooldown!"))
                    end
                else
                    inv:remove_item("beds", stack)
                    ui.set_inventory_formspec(player, ui.default)
                end
            end
            return
        end
        if fields["bed" .. i] then
            local inv = player:get_inventory()
            local stack = inv:get_stack("beds", i)
            if stack ~= nil then
                local meta = stack:get_meta()
                local pos = minetest.deserialize(meta:get_string("pos"))
                local radius = 1                          -- radius of the area to load
                local minp = vector.subtract(pos, radius) -- minimum corner of the area to load
                local maxp = vector.add(pos, radius)      -- maximum corner of the area to load

                -- get a voxel manipulator for the area
                local vm = VoxelManip(minp, maxp)

                -- load the area into memory using read_from_map
                vm:read_from_map(minp, maxp)
                local node = minetest.get_node(pos)
                if node.name ~= stack:get_name() then
                    inv:remove_item("beds", stack)
                    ui.set_inventory_formspec(player, ui.default)
                else
                    ui.set_inventory_formspec(player, "bed" .. i)
                end
            else
                ui.set_inventory_formspec(player, ui.default)
            end
            return
        end
    end
end)

minetest.register_on_joinplayer(function(player, last_login)
    local inv = player:get_inventory()
    inv:set_size("beds", 24)
    --[[
    local count = 1
    local bt = { "bed", "bag" }

    for h = 1, #bt do
        for i = 1, #beds.colors do
            if count <= 24 then
                local tmp = ItemStack("beds:" .. bt[h] .. "_" .. beds.colors[i] .. "_bottom", 1)
                local meta = tmp:get_meta()
                meta:set_string("description", beds.colors[i] .. bt[h])
                local pos = { x = count, y = count * 10, z = count }
                meta:set_string("pos", minetest.serialize(pos))
                inv:set_stack("beds", count, tmp)
            end
            count = count + 1
        end
    end
    --]]
end)
