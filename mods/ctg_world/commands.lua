local S = minetest.get_translator(minetest.get_current_modname())

local mods_loaded = false
minetest.register_on_mods_loaded(function()
    mods_loaded = true
end)

minetest.register_chatcommand("listbiomes", {
    description = "List all biomes",
    params = "",
    privs = { debug = true },
    func = function(name, param)
        if not mods_loaded then
            return false
        end
        local biomes
        local b = 0
        biomes = {}
        for k, v in pairs(minetest.registered_biomes) do
            table.insert(biomes, k)
            b = b + 1
        end
        if b == 0 then
            return true, S("No biomes.")
        else
            table.sort(biomes)
            for i = 1, #biomes do
                minetest.chat_send_player(name, biomes[i])
                minetest.log(biomes[i])
            end
            return true
        end
    end,
})

minetest.register_chatcommand("biome", {
    description = "Give the current biome",
    params = "",
    privs = { debug = true },
    func = function(name, param)
        local player = minetest.get_player_by_name(name)
        local biome = minetest.get_biome_data(player:get_pos())

        minetest.chat_send_player(name,
            "\nBiome: " .. minetest.get_biome_name(biome.biome)
            .. "\nHeat: " .. biome.heat ..
            "\nHumidity: " .. biome.humidity)
    end,
})
