if not element_portals then
	element_portals = {}
end

if not element_portals.cache or not element_portals.cache.portals then 
	element_portals.cache = {portals = {}}
end

local portal_cache_enabled = minetest.setting_getbool("element_portals_enable_memonize")
if (portal_cache_enabled == nil) then
    -- Set up a suitable default value
    portal_cache_enabled = true
end

local scheduled_cache_write_interval = tonumber(minetest.setting_get("element_portals_memonize_store_interval"))
if (scheduled_cache_write_interval == nil) then
    -- Set up a suitable default value
    scheduled_cache_write_interval = 30
end

-- shorthand for cache space variable
local portal_cache = element_portals.cache.portals

-- short hand for deep_copy
-- does a copy of the values, since the inner values are passed by
-- reference altering a field in this may lead to unexpected results 
-- all over the place
 
local copy = function(value) 
	return element_portals:deep_copy(value)
end


local read_from_file = function(player)
	local player_name = player:get_player_name() 
	local portals = {}
	local file = io.open(minetest.get_worldpath().."/portals_"..player_name, "r")
	if file then
		portals = minetest.deserialize(file:read("*all"))
		file:close()
	end
	if not portals then
		portals = {} 
	end
	return portals
end

local write_to_file = function(player, portals) 
	local player_name = player:get_player_name() 
	local file = io.open(minetest.get_worldpath().."/portals_"..player_name, "w")
	if file then
		file:write(minetest.serialize(portals))
		file:close()
	end
end


function element_portals:read_player_portals_table(player)
	local player_name = player:get_player_name()
	if portal_cache_enabled and portal_cache[player_name] then
		minetest.log("info", "Reading portals for player: ".. player_name .." from cache")
		return copy(portal_cache[player_name].portals)
	end
	minetest.log("action", "Reading portals for player: ".. player_name .." from file")
	local portals = read_from_file(player)
	if portal_cache_enabled then
		portal_cache[player_name] = {portals=portals, player=player}
	end
	return portals
end

function element_portals:write_player_portals_table (player, portals)
	if portal_cache_enabled then	
		local player_name = player:get_player_name()
		portal_cache[player_name] = {portals=copy(portals), player = player, changed = true}
	else
		write_to_file(player, portals) 
	end
end

-- local interval callback 
local scheduled_cache_write = function()
	element_portals:write_players_portal_files()
end

function element_portals:write_players_portal_files(no_schedule)
	if not portal_cache_enabled then
		return
	end
	minetest.log("info", "Checking players portals for changes")
	for player_name, cache_data in pairs(portal_cache) do
		if cache_data.changed then
			minetest.log("action", "Portals for player ".. player_name .." changed, writing to file")
			write_to_file(cache_data.player, cache_data.portals) 		
			cache_data.changed=false
		end
	end
	
	-- schedule next write
	if not no_schedule then
		minetest.after(scheduled_cache_write_interval , scheduled_cache_write)
	end
end

if portal_cache_enabled then
	-- start write interval loop 
	minetest.log("action", "Scheduling portal cache write on interval")
	minetest.after(scheduled_cache_write_interval, scheduled_cache_write)
	-- register write when a player leaves
	minetest.register_on_leaveplayer(function(player)
		if not player then
			return
		end
		local player_name = player:get_player_name();
		if portal_cache[player_name] and portal_cache[player_name].changed then
			minetest.log("action", "Portals for player ".. player_name .." changed, writing to file")
			element_portals:write_player_portals_table(player, portal_cache[player_name].portals)
			portal_cache[player_name] = nil
		end 
	end)
	
	minetest.register_on_shutdown(function()
		minetest.log("action", "Triggering shutdown cache to file write check")
   		element_portals:write_players_portal_files(true)
	end)
end
