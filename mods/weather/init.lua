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
		if player:get_pos().y >= -11000 and player:get_pos().y <= 200 then
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
			local moisture_index = (biome.heat - 10) * biome.humidity / 100
			local is_storming = (density > density_max - (density_max / 8)) and moisture_index > 17
			local is_raining = density > density_max * 0.75 and moisture_index > 16
			local is_sprinkling = density > density_max * 0.7 and moisture_index > 14
			local current_weather = player_weather[player:get_player_name()]
			if is_storming and current_weather ~= "storm" then
				player_weather[player:get_player_name()] = "storm"
				player:set_moon({
					visible = false,
					scale = 0.0,
				})
				player:set_stars({
					visible = false
				})
				player:set_sun({
					visible = false,
					scale = 0.0,
					sunrise_visible = false
				})
				player:set_sky({
					type = "plain",
					clouds = true,
					base_color = "#2c2f2f",
					sunrise_visible = false,
					sky_color = {
						day_horizon = "#6c95ab",
						dawn_horizon = "#959abd",
						fog_sun_tint = "#c28d63",
						fog_moon_tint = "#687999",
						dawn_sky = "#9193a3",
						day_sky = "#9fafbd",
						night_sky = "#002559",
						indoors = "#444444",
						night_horizon = "#4b70a3"
					}
				})
				local clouds = player:get_clouds()
				clouds.color = "#787777f5"
				player:set_clouds(clouds)
			elseif is_raining and current_weather ~= "rain" then
				player_weather[player:get_player_name()] = "rain"
				player:set_sky({
					type = "regular",
					clouds = true,
					sunrise_visible = false,
					base_color = "#4E5056",
					sky_color = {
						day_sky = "#3E5C71",
						day_horizon = "#4D6671",
						dawn_sky = "#4E5056",
						dawn_horizon = "#5B606F",
						fog_tint_type = "default",
						night_sky = "#1D4374",
						night_horizon = "#334F74",
						indoors = "#4F4F4F",
					}
				})
				local clouds = player:get_clouds()
				clouds.color = "#A59F9Fe5"
				player:set_clouds(clouds)
				player:set_moon({
					visible = false,
					scale = 0.0,
				})
				player:set_stars({
					visible = false
				})
				player:set_sun({
					visible = false,
					scale = 0.0,
					sunrise_visible = false
				})
			elseif is_sprinkling and current_weather ~= "sprinkle" then
				player_weather[player:get_player_name()] = "sprinkle"
				player:set_sky({
					type = "regular",
					clouds = true,
					sunrise_visible = false,
					base_color = "#4F88B3",
					sky_color = {
						day_sky = "#4F88B3",
						day_horizon = "#6F9CB4",
						dawn_sky = "#6F727C",
						dawn_horizon = "#8B90B0",
						fog_tint_type = "default",
						night_sky = "#0F57BA",
						night_horizon = "#3970BA",
						indoors = "#595959",
					}
				})
				local clouds = player:get_clouds()
				clouds.color = "#D2C8C8d5"
				player:set_clouds(clouds)
				player:set_moon({
					visible = false,
					scale = 1.0,
				})
				player:set_stars({
					visible = false
				})
				player:set_sun({
					visible = false,
					scale = 1.0,
					sunrise_visible = false
				})
			else
				if current_weather ~= "normal" then
					player_weather[player:get_player_name()] = "normal"
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
							indoors = "#646464",
						}
					})
					local clouds = player:get_clouds()
					clouds.color = "#fff0f0d5"
					player:set_clouds(clouds)
					player:set_moon({
						visible = true
					})
					player:set_stars({
						visible = true
					})
					player:set_sun({
						visible = true,
						scale = 1.0,
						sunrise_visible = true
					})
				end
			end
			lightning.storm(player, is_storming)

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
		end
		precipitation.set_precipitation(player, precip)
	end
end


local function cyclic_update()
	update_clouds()
	minetest.after(CYCLE, cyclic_update)
end


minetest.after(0, cyclic_update)


-- Update on player join to instantly alter clouds from the default

minetest.register_on_joinplayer(function(player)
	update_clouds()
end)
