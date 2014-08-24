if not element_portals then
	element_portals = {}
end

function element_portals:read_player_portals_table(player)
	local player_name = player:get_player_name();
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

function element_portals:write_player_portals_table (player, portals)
	local player_name = player:get_player_name();
	local file = io.open(minetest.get_worldpath().."/portals_"..player_name, "w")
	if file then
		file:write(minetest.serialize(portals))
		file:close()
	end
end

function element_portals:construct_portal_id_key (pos, player)
	local name = player:get_player_name()
	local coords = minetest.pos_to_string(pos)
	return name..coords
end

function element_portals:get_portal_meta_by_key(key)
	local portals = element_portals:read_player_portals_table(player)
	return portals[key]
end

function element_portals:get_portal_meta(pos, player)
	local key = portal_key or element_portals:construct_portal_id_key(pos, player)
	element_portals:get_portal_meta_by_key(key)
end

function element_portals:remove_portal_data (pos, player)
	local portals = element_portals:read_player_portals_table(player)
	local key = element_portals:construct_portal_id_key(pos, player)
	if not pos or not player then
		return
	end 
	portals[key] = nil
	element_portals:write_player_portals_table(player, portals)
	minetest.chat_send_player(player:get_player_name(), "Portal removed from "..minetest.pos_to_string(pos)..".")
end

function element_portals:create_portal (pos, player) 
	local name = player:get_player_name()
	local coords = minetest.pos_to_string(pos)
	minetest.chat_send_player(name, "Attempting to create portal at "..coords..".")
	if not player then
		return
	end
	local portals = element_portals:read_player_portals_table(player)
	local portal_number = element_portals:tablelength(portals);
	local portal_name = "Portal "..portal_number;
	local key = element_portals:construct_portal_id_key(pos, player)
	portals[key] = {pos = pos, portal_name = portal_name}
	element_portals:write_player_portals_table(player, portals)
	minetest.chat_send_player(name, "Portal added at "..coords..".")
	return portal_name
end

