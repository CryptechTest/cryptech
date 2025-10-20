local S = minetest.get_translator("ctg_world")

if minetest.get_modpath("moreblocks") then

    local pillow_colors = {{
        name = 'white',
        description = S('White'),
        mcl_group = {'unicolor_white'}
    }, {
        name = 'grey',
        description = S('Grey'),
        mcl_group = {'unicolor_grey'}
    }, {
        name = 'dark_grey',
        description = S('Dark Grey'),
        mcl_group = {'unicolor_darkgrey'}
    }, {
        name = 'black',
        description = S('Black'),
        mcl_group = {'unicolor_black'}
    }, {
        name = 'violet',
        description = S('Violet'),
        mcl_group = {'unicolor_red_violet'}
    }, {
        name = 'blue',
        description = S('Blue'),
        mcl_group = {'unicolor_blue'}
    }, {
        name = 'light_blue',
        description = S('Light Blue'),
        mcl_group = {'unicolor_light_blue'}
    }, {
        name = 'cyan',
        description = S('Cyan'),
        mcl_group = {'unicolor_cyan'}
    }, {
        name = 'dark_green',
        description = S('Dark Green'),
        mcl_group = {'unicolor_dark_green'}
    }, {
        name = 'green',
        description = S('Green'),
        mcl_group = {'unicolor_green'}
    }, {
        name = 'yellow',
        description = S('Yellow'),
        mcl_group = {'unicolor_yellow'}
    }, {
        name = 'brown',
        description = S('Brown'),
        mcl_group = {'unicolor_dark_orange'}
    }, {
        name = 'orange',
        description = S('Orange'),
        mcl_group = {'unicolor_orange'}
    }, {
        name = 'red',
        description = S('Red'),
        mcl_group = {'unicolor_red'}
    }, {
        name = 'magenta',
        description = S('Magenta'),
        mcl_group = {'unicolor_red_violet'}
    }, {
        name = 'pink',
        description = S('Pink'),
        mcl_group = {'unicolor_light_red'}
    }}

    for _, def in ipairs(pillow_colors) do
        local color_group = 'color_' .. def.name

        local recipe = "x_farming:pillow_" .. def.name
        local groups = {
            snappy = 3,
            flammable = 4,
            [color_group] = 1
        }
        local images = {'x_farming_pillow_' .. def.name .. '.png'}
        local sounds = default.node_sound_leaves_defaults()

        stairs.register_slab("pillow_" .. def.name, recipe, groups, images, def.description .. " " .. S("Pillow Slab"),
            sounds, true)
    end
end

if minetest.get_modpath("x_farming") then
    awards.register_award("awards_pillow", {
        title = S("Something Soft and Fluffy"),
        description = S("Craft 250 white pillow."),
        icon = "awards_soft_and_fluffy.png",
        trigger = {
            type = "craft",
            item = "x_farming:pillow",
            target = 250
        }
    })

    if minetest.get_modpath("farming") then
        minetest.clear_craft({
            recipe = {
                {"", "farming:cotton", "farming:cotton"},
                {"", "farming:cotton", "farming:cotton"},
                {"", "", ""},
            }
        })
        minetest.register_craft({
            type = 'shapeless',
            output = 'x_farming:pillow_white',
            recipe = {'farming:cotton', 'farming:cotton', 'farming:cotton', 'farming:cotton'}
        })
        minetest.register_craft({
            type = 'shapeless',
            output = 'x_farming:pillow_white 5',
            recipe = {'wool:white', 'wool:white', 'wool:white', 'wool:white'}
        })
    end
end
