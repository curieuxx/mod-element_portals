if not element_portals then
	element_portals = {}
end

element_portals.registered_portals = {}
element_portals.disabled_portal_keys = {}

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

function element_portals:generate_portal_name(portals)
	local count = element_portals:tablelength(portals);
	local prefix = "Portal"
	return element_portals:generate_portal_name_with(prefix, count-1, portals, {})
end

function element_portals:table_contains(value, values) 
	local result = false
	if values and value then
		for _, check_value in pairs(values) do
			if check_value  == value then
				result = true
				break
			end
		end
	else 
		result = true 
	end
	return result
end

function element_portals:name_exists(name, portals, exclude_keys) 
	local name_exists = false
	for k,v in pairs(portals) do	
		if not element_portals:table_contains(k, exclude_keys) and v.portal_name == name then
			name_exists = true
			break
		end
	end
	return name_exists
end

function element_portals:generate_portal_name_with(prefix, count, portals, exclude_keys)
	local generated_name = prefix
	local name_exists = element_portals:name_exists(generated_name, portals, exclude_keys) 
	while name_exists do
		count = count + 1
		generated_name = prefix.." "..count
		name_exists = element_portals:name_exists(generated_name, portals, exclude_keys) 
	end
	return generated_name
end

function element_portals:create_portal(pos, player, node_name) 
	local name = player:get_player_name()
	local coords = minetest.pos_to_string(pos)
	minetest.chat_send_player(name, "Attempting to create portal at "..coords..".")
	if not player then
		minetest.chat_send_player(name, "Failed to create portal at "..coords..". Player is not set")
		return
	end
	local portals = element_portals:read_player_portals_table(player)
	local portal_name = element_portals:generate_portal_name(portals)
	local key = element_portals:construct_portal_id_key(pos, player)
	portals[key] = {pos = pos, portal_name = portal_name, node_name = node_name}
	element_portals:write_player_portals_table(player, portals)
	minetest.chat_send_player(name, "Portal added at "..coords..".")
	return portal_name
end

local set_meta_int = function(meta, key, value)
	local current_value = meta:get_int(key) 
	local value_to_set = value
	if current_value ~= value_to_set then
		meta:set_int(key, value_to_set)
	end
end

local set_meta = function(meta, key, value)
	local current_value = meta:get_string(key) or "";
	local value_to_set = value or ""
		if current_value ~= value_to_set then
			meta:set_string(key, value_to_set)
		end

end

function element_portals:set_portal_node_meta(meta, params, name)
	set_meta(meta, "fuel_surrounding", params.fuel_surrounding)
	set_meta_int(meta, "fuel_surrounding_count", params.fuel_surrounding_count)
	set_meta(meta, "fuel_stack", params.fuel_stack)
	set_meta(meta, "portal_node_name", name)
end

function element_portals:register_portal(portal_name, portal_params) 
	if portal_name and not element_portals.registered_portals[portal_name] then
		element_portals.registered_portals[portal_name] = portal_params
	end
end


function element_portals:is_registerd_portal(node_name)
	for k, v in pairs(element_portals.registered_portals) do
		if k == node_name then
			return true
		end
	end
	return false
end

function element_portals:get_portal_filter_group(node_name)
	local result = nil
	if element_portals.registered_portals[node_name] then
		local data = element_portals.registered_portals[node_name]
		result = data.filter_group
	end
	return result
end

function element_portals:is_registered_out_portal(node_name, group)
	if element_portals.registered_portals[node_name] then
		local data = element_portals.registered_portals[node_name]
		local out_type = data.portal_type == element_portals.IN_OUT_PORTAL 
				or data.portal_type == element_portals.OUT_PORTAL
		local in_group = element_portals:table_contains(group, data.portal_groups) 
		if out_type and in_group then
			return true
		end
	end 
	return false
end

function element_portals:fix_portal_name(k, v, portals)
	return element_portals:generate_portal_name_with(v.portal_name or "Portal", 0, portals, {k})
end

function element_portals:sanitize_player_portals(player)
	local portals = element_portals:read_player_portals_table(player)
	local altered_portals
	local portal_keys_to_remove = {}
	for k, v in pairs(portals) do
		local fix_data_result = element_portals:fix_portal_data(k, v)
		if fix_data_result == element_portals.REMOVE_PORTAL_ACTION then
			 print("Portal with key "..k.." was scheduled to be removed from user portal data")
			 table.insert(portal_keys_to_remove, k)
		end
		local new_name_result = element_portals:fix_portal_name(k, v, portals)
		if new_name_result ~= v.portal_name then 
			print("Portal with key "..k.." has a duplicate name "..v.portal_name.. " renaming to "..new_name_result)
			v.portal_name = new_name_result
		end
		
	end
	for _, key in pairs(portal_keys_to_remove) do
		portals[key] = nil
	end
	element_portals:write_player_portals_table(player, portals)
	print ("Finishing portal sanitization")
end

function element_portals:disable_portal(portal_key)
	table.insert(element_portals.disabled_portal_keys, portal_key)
end

function element_portals:get_portal_node_data(portal_key, portal_params)
	local manip = minetest.get_voxel_manip()
	manip:read_from_map(portal_params.pos, portal_params.pos)
	local meta = minetest.get_meta(portal_params.pos)
	local node = minetest.get_node(portal_params.pos)
	return {meta = meta, node=node}
end

function element_portals:fix_portal_data(k, v)
 	local node_data = element_portals:get_portal_node_data(k, v)
	local meta = node_data.meta
	local node = node_data.node
	local node_name = node.name
	if not element_portals:is_registerd_portal(node_name) then
		print("Portal with key "..k.." of type  ".. node_name.." is not registered") 
		if node_name == 'air' then
			-- remove from data - but delegate to 
			return element_portals.REMOVE_PORTAL_ACTION
		-- else
			-- portal type is either disabled from game mod config, 
			-- either it was replaced somehow without calling portal 
			-- node on_desctruct impl.
			-- Solution would be to disable it, but if it's stored in a 
			-- global variable then it may get costly for each user 
			-- in a multiplayer game, for now the node/data is checked
			-- only on teleport function 
			-- element_portals:disable_portal(k)
		end
	else 	
		-- overwrite node meta
		print("Portal with key "..k.." of type  ".. node_name.." is registered and the right type of node exists, setting meta on the node") 
		element_portals:set_portal_node_meta(meta, element_portals.registered_portals[node_name], node_name)
		-- overwrite portal data name 
		v.node_name = node_name
	end
	return element_portals.VOID_ACTION
end

local check_portal = function(portal_key, portal_params)
	local node_data = element_portals:get_portal_node_data(portal_key, portal_params)
	return element_portals:is_registered_out_portal(node_data.node.name) 
end

function element_portals:teleport_to(selected_portal_name, player, travel_free, meta)
	local portals = element_portals:read_player_portals_table(player)
	for k,v in pairs(portals) do
		if v.portal_name ==  selected_portal_name then
			local valid_end_point_portal = check_portal(k, v)
			if valid_end_point_portal then
				local teleport_posible = travel_free or (meta and element_portals:consume_fuel(meta, player))
				if teleport_posible then
					v.pos.y  = v.pos.y + 1
					player:setpos(v.pos)
				end
			else
				minetest.chat_send_player(player:get_player_name(), "The selected portal is disabled and it cannot be used")
			end
			return
		end
	end
end
-- run a sanitize when player joins when the player joins
minetest.register_on_joinplayer(function(player) 
  if player then
  	element_portals:sanitize_player_portals(player)
  end 
end)
