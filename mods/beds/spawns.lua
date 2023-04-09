local world_path = minetest.get_worldpath()
local org_file = world_path .. "/beds_spawns"
local beds_file = world_path .. "/beds_player_beds"
local file = world_path .. "/beds_spawns"
local bkwd = false

-- check for PA's beds mod spawns
local cf = io.open(world_path .. "/beds_player_spawns", "r")
if cf ~= nil then
	io.close(cf)
	file = world_path .. "/beds_player_spawns"
	bkwd = true
end

function beds.read_spawns()
	local spawns = beds.spawn
	local input = io.open(file, "r")
	if input and not bkwd then
		repeat
			local x = input:read("*n")
			if x == nil then
				break
			end
			local y = input:read("*n")
			local z = input:read("*n")
			local name = input:read("*l")
			spawns[name:sub(2)] = { x = x, y = y, z = z }
		until input:read(0) == nil
		io.close(input)
	elseif input and bkwd then
		beds.spawn = minetest.deserialize(input:read("*all"))
		input:close()
		beds.save_spawns()
		os.rename(file, file .. ".backup")
		file = org_file
	end
end

function beds.read_player_beds()
	local spawns = beds.player_bed
	local input = io.open(beds_file, "r")
	if input then
		repeat
			local k = input:read("*l")
			if k == nil then
				break
			end
			local v = input:read("*l")
			if v == nil then
				break
			end
			local x = input:read("*n")
			if x == nil then
				break
			end
			local y = input:read("*n")
			local z = input:read("*n")
			local name = input:read("*l")
			spawns[minetest.serialize({ x = x, y = y, z = z })] = name:sub(2)
		until input:read(0) == nil
		io.close(input)
	end
end

function beds.save_spawns()
	if not beds.spawn then
		return
	end
	local data = {}
	local output = io.open(org_file, "w")
	for k, v in pairs(beds.spawn) do
		table.insert(data, string.format("%.1f %.1f %.1f %s\n", v.x, v.y, v.z, k))
	end
	output:write(table.concat(data))
	io.close(output)
end

function beds.save_player_beds()
	if not beds.player_bed then
		return
	end
	local data = {}
	local output = io.open(beds_file, "w")
	for k, v in pairs(beds.player_bed) do
		local pos = minetest.deserialize(k)
		table.insert(data, string.format("%.1f %.1f %.1f %s\n", pos.x, pos.y, pos.z, v))
	end
	output:write(table.concat(data))
	io.close(output)
end

function beds.set_spawns()
	for name, _ in pairs(beds.player) do
		local player = minetest.get_player_by_name(name)
		local p = player:get_pos()
		-- but don't change spawn location if borrowing a bed
		if not minetest.is_protected(p, name) then
			beds.spawn[name] = p
		end
	end
	beds.save_spawns()
end

function beds.remove_spawns_at(pos)
	for name, p in pairs(beds.spawn) do
		if vector.equals(vector.round(p), pos) then
			beds.spawn[name] = nil
		end
	end
	beds.save_spawns()
end

function beds.remove_player_beds_at(pos)
	for p, _ in pairs(beds.player_bed) do
		if vector.equals(vector.round(minetest.deserialize(p)), pos) then
			beds.player_bed[p] = nil
		end
	end
	beds.save_player_beds()
end

local save_loop
save_loop = function()
	-- code to execute after the interval has passed
	-- schedule the function to be executed again in 300 seconds
	beds.save_player_beds()
	minetest.after(60, save_loop)
end

beds.read_spawns()
beds.read_player_beds()
minetest.after(60, save_loop)

minetest.register_on_shutdown(function()
	beds.save_player_beds()
end)
