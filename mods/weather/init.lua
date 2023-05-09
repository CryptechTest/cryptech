-- Disable by mapgen or setting

local mg_name = minetest.get_mapgen_setting("mg_name")
if minetest.settings:get_bool("enable_weather") == false then
	return
end

if mg_name == "v6" or mg_name == "singlenode" then
	-- set a default shadow intensity for mgv6 and singlenode
	minetest.register_on_joinplayer(function(player)
		player:set_lighting({ shadows = { intensity = 0.33 } })
	end)

	return
end

-- Parameters

local TSCALE = 600 -- Time scale of noise variation in seconds
local CYCLE = 8    -- Time period of cyclic clouds update in seconds

local np_density = {
	offset = 0.5,
	scale = 0.5,
	spread = { x = TSCALE, y = TSCALE, z = TSCALE },
	seed = 813,
	octaves = 1,
	persist = 0,
	lacunarity = 2,
}

local np_thickness = {
	offset = 0.5,
	scale = 0.5,
	spread = { x = TSCALE, y = TSCALE, z = TSCALE },
	seed = 96,
	octaves = 1,
	persist = 0,
	lacunarity = 2,
}

local np_speedx = {
	offset = 0,
	scale = 1,
	spread = { x = TSCALE, y = TSCALE, z = TSCALE },
	seed = 911923,
	octaves = 1,
	persist = 0,
	lacunarity = 2,
}

local np_speedz = {
	offset = 0,
	scale = 1,
	spread = { x = TSCALE, y = TSCALE, z = TSCALE },
	seed = 5728,
	octaves = 1,
	persist = 0,
	lacunarity = 2,
}

-- End parameters


-- Initialise noise objects to nil

local nobj_density = nil
local nobj_thickness = nil
local nobj_speedx = nil
local nobj_speedz = nil

local player_weather = {}
local player_sky = {}

-- Update clouds function

local function rangelim(value, lower, upper)
	return math.min(math.max(value, lower), upper)
end

local os_time_0 = os.time()
local t_offset = math.random(0, 300000)

local function update_clouds()
	-- Time in seconds.
	-- Add random time offset to avoid identical behaviour each server session.
	local time = os.difftime(os.time(), os_time_0) - t_offset

	nobj_density = nobj_density or minetest.get_perlin(np_density)
	nobj_thickness = nobj_thickness or minetest.get_perlin(np_thickness)
	nobj_speedx = nobj_speedx or minetest.get_perlin(np_speedx)
	nobj_speedz = nobj_speedz or minetest.get_perlin(np_speedz)

	local n_density = nobj_density:get_2d({ x = time, y = 0 })  -- 0 to 1
	local n_thickness = nobj_thickness:get_2d({ x = time, y = 0 }) -- 0 to 1
	local n_speedx = nobj_speedx:get_2d({ x = time, y = 0 })    -- -1 to 1
	local n_speedz = nobj_speedz:get_2d({ x = time, y = 0 })    -- -1 to 1

	for _, player in ipairs(minetest.get_connected_players()) do
		-- Fallback to mid-value 50 for very old worlds
		local precip = "none"
		local clouds = player:get_clouds()
		local cloud_height = clouds and clouds.height or 120
		if player:get_pos().y >= -11000 and player:get_pos().y <= 2000 then
			local humid = minetest.get_humidity(player:get_pos()) or 50
			-- Default and classic density value is 0.4, make this happen
			-- at humidity midvalue 50 when n_density is at midvalue 0.5.
			-- density_max = 0.25 at humid = 0.
			-- density_max = 0.8 at humid = 50.
			-- density_max = 1.35 at humid = 100.
			local density_max = 0.7 + ((humid - 50) / 50) * 0.55
			local density = rangelim(density_max, 0.2, 1.0) * n_density
			player:set_clouds({
				-- Range limit density_max to always have occasional
				-- small scattered clouds at extreme low humidity.
				density = density,
				thickness = math.max(math.floor(
					rangelim(32 * humid / 100, 8, 32) * n_thickness
				), 2),
				speed = { x = n_speedx * 4, z = n_speedz * 4 },
			})

			-- now adjust the shadow intensity
			local biome = minetest.get_biome_data(player:get_pos())
			player:set_lighting({ shadows = { intensity = 0.77 * (1 - density) } })
			local moisture_index = math.abs((biome.heat - 10) * biome.humidity / 100)
			local is_storming = density > density_max * 0.85 and moisture_index > 17
			local is_raining = density > density_max * 0.7 and moisture_index > 16
			local is_sprinkling = density > density_max * 0.6 and moisture_index > 14
			if player:get_pos().y > cloud_height + 1.5 then
				player_weather[player:get_player_name()] = "normal"
			elseif is_storming then
				player_weather[player:get_player_name()] = "storm"
			elseif is_raining then
				player_weather[player:get_player_name()] = "rain"
			elseif is_sprinkling then
				player_weather[player:get_player_name()] = "sprinkle"
			else
				player_weather[player:get_player_name()] = "normal"
			end
			lightning.storm(player, player_weather[player:get_player_name()] ~= nil and is_storming)

			if biome.heat > 35 then
				if is_storming then
					precip = "storm"
				elseif is_raining then
					precip = "rain"
				elseif is_sprinkling then
					precip = "sprinkle"
				end
			else
				if is_storming then
					precip = "snow_storm"
				elseif is_raining then
					precip = "snow"
				elseif is_sprinkling then
					precip = "flurry"
				end
			end
		else
			lightning.storm(player, false)
			player_weather[player:get_player_name()] = nil
			player_sky[player:get_player_name()] = nil
		end
		if player:get_pos().y <= cloud_height + 1.5 then
			precipitation.set_precipitation(player, precip)
		else
			precipitation.set_precipitation(player, "none")
		end
	end
end

local function update_sky()
	for _, player in ipairs(minetest.get_connected_players()) do
		local ppos = player:get_pos()
		if ppos.y >= -74 and ppos.y <= 2000 then
			local clouds = player:get_clouds()
			local player_name = player:get_player_name()
			local current_weather = player_weather[player_name]

			if current_weather == "storm" and player_sky[player_name] ~= "storm" then
				player_sky[player_name] = "storm"

				player:set_sky({
					type = "regular",
					clouds = true,
					base_color = "#545151",
					sunrise_visible = false,
					sky_color = {
						day_sky = "#4F6474",
						day_horizon = "#56646D",
						dawn_sky = "#5A606D",
						dawn_horizon = "#5B616C",
						fog_tint_type = "custom",
						fog_sun_tint = "#625952",
						fog_moon_tint = "#545C68",
						night_sky = "#354154",
						night_horizon = "#4C5B6E",
						indoors = "#4B5F6D",
					}
				})
				clouds.color = "#5B636AFF"
				player:set_clouds(clouds)
				player:set_moon()
				player:set_stars({
					visible = false,
					color = "#ebebff0f"
				})
				player:set_sun({
					visible = false,
					sunrise_visible = false
				})
			elseif current_weather == "rain" and player_sky[player_name] ~= "rain" then
				player_sky[player_name] = "rain"
				player:set_sky({
					type = "regular",
					clouds = true,
					sunrise_visible = false,
					base_color = "#7E92A0",
					sky_color = {
						day_sky = "#749EBC",
						day_horizon = "#84A8BD",
						dawn_sky = "#909FBE",
						dawn_horizon = "#92A2BB",
						fog_tint_type = "custom",
						fog_sun_tint = "#A58B74",
						fog_moon_tint = "#7E94AF",
						night_sky = "#5485C0",
						night_horizon = "#6991C0",
						indoors = "#75838C",
					}
				})
				clouds.color = "#B5B3B8FF"
				player:set_clouds(clouds)
				player:set_moon()
				player:set_stars({
					visible = false,
					color = "#ebebff13"
				})
				player:set_sun()
			elseif current_weather == "sprinkle" and player_sky[player_name] ~= "sprinkle" then
				player_sky[player:get_player_name()] = "sprinkle"
				player:set_sky({
					type = "regular",
					clouds = true,
					sunrise_visible = false,
					base_color = "#BFC9D0",
					sky_color = {
						day_sky = "#A0C2DC",
						day_horizon = "#AFCCDD",
						dawn_sky = "#BBC4DE",
						dawn_horizon = "#BDC6DB",
						fog_tint_type = "custom",
						fog_sun_tint = "#D1B094",
						fog_moon_tint = "#AAB9CF",
						night_sky = "#7FAAE0",
						night_horizon = "#95B6E0",
						indoors = "#A1A7AC",
					}
				})
				clouds.color = "#DAD2D4F0"
				player:set_clouds(clouds)
				player:set_moon()
				player:set_stars({
					visible = true,
					color = "#ebebff36"
				})
				player:set_sun()
			elseif (current_weather == "normal") and player_sky[player_name] ~= "normal" then
				player_sky[player:get_player_name()] = "normal"
				player:set_sky({
					type = "regular",
					clouds = true,
					sunrise_visible = true,
					base_color = "#ffffff",
					sky_color = {
						day_sky = "#61b5f5",
						day_horizon = "#90d3f6",
						dawn_sky = "#9193a3",
						dawn_horizon = "#bac1f0",
						fog_tint_type = "default",
						night_sky = "#006bff",
						night_horizon = "#4090ff",
						indoors = "#5A5858",
					}
				})
				clouds.color = "#fff0f0d5"
				player:set_clouds(clouds)
				player:set_moon()
				player:set_stars()
				player:set_sun()
			else
				player_sky[player:get_player_name()] = nil
				player_weather[player_name] = nil
			end
		end
	end
end


local function cyclic_update()
	update_clouds()
	minetest.after(CYCLE, cyclic_update)
end

local function skybox_update()
	update_sky()
	minetest.after(0.7, skybox_update)
end


minetest.after(0, cyclic_update)
minetest.after(0.7, skybox_update)


-- Update on player join to instantly alter clouds from the default

minetest.register_on_joinplayer(function(player)
	update_clouds()
end)
