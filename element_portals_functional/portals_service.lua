--[[

Portal read and write business rules related functions 

Copyright 2014 Tiberiu CORBU
Authors: Tiberiu CORBU

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
--]]

if not element_portals then
	element_portals = {}
end

element_portals.registered_portals = {}
element_portals.disabled_portal_keys = {}

-- builds a key form the position and the player instances. 
-- all i/o on portal data rely on this function  
function element_portals:construct_portal_id_key (pos, player)
	local name = player:get_player_name()
	local coords = minetest.pos_to_string(pos)
	return name..coords
end

function element_portals:get_portal_data_by_key(key)
	local portals = element_portals:read_player_portals_table(player)
	return portals[key]
end

function element_portals:get_portal_data(pos, player)
	local key = portal_key or element_portals:construct_portal_id_key(pos, player)
	element_portals:get_portal_data_by_key(key)
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
	local k, v
	for k, v in pairs(portals) do	
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

function element_portals:register_portal(portal_node_name, portal_params) 
	if portal_node_name and not element_portals.registered_portals[portal_node_name] then
		element_portals.registered_portals[portal_node_name] = portal_params
	end
end


function element_portals:is_registerd_portal(node_name)
	local k, v
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

-- verifyes if the portal is registered (submod enabled) and is an out type 
function element_portals:is_registered_out_portal(node_name, group)
	
	if element_portals.registered_portals[node_name] then
	
		local data = element_portals.registered_portals[node_name]
		
		local out_type = data.portal_type == element_portals.IN_OUT_PORTAL 
				or data.portal_type == element_portals.OUT_PORTAL
		
		local in_group = element_portals:table_contains(group, data.portal_groups)
		
		if out_type and in_group then
			return true
		end
		
	else 
		minetest.log("action", node_name .." is not a registered portal")
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
	local k, v
	for k, v in pairs(portals) do
		local fix_data_result = element_portals:fix_portal_data(k, v)
		if fix_data_result == element_portals.REMOVE_PORTAL_ACTION then
			 minetest.log("action", "Portal with key "..k.." was scheduled to be removed from user portal data")
			 table.insert(portal_keys_to_remove, k)
		end
		local new_name_result = element_portals:fix_portal_name(k, v, portals)
		if new_name_result ~= v.portal_name then 
			minetest.log("action", "Portal with key "..k.." has a duplicate name "..v.portal_name.. " renaming to "..new_name_result)
			v.portal_name = new_name_result
		end
		
	end
	local _, key
	for _, key in pairs(portal_keys_to_remove) do
		portals[key] = nil
	end
	element_portals:write_player_portals_table(player, portals)
	minetest.log("info", "Finishing portal sanitization")
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
		minetest.log("error", "Portal with key "..k.." of type  ".. node_name.." is not registered") 
		if node_name == 'air' then
			-- remove from data - but delegate to 
			return element_portals.REMOVE_PORTAL_ACTION
		-- else
			--[[ portal type is either disabled from game mod config, 
			 either it was replaced somehow without calling portal 
			 node on_desctruct impl.
			for now the node/data is checked
			 only on teleport function]]-- 
			 
			-- element_portals:disable_portal(k)
		end
	else 	
		-- overwrite node meta
		minetest.log("action", "Portal with key "..k.." of type  ".. node_name.." is registered and the right type of node exists, setting meta on the node") 
		element_portals:set_portal_node_meta(meta, element_portals.registered_portals[node_name], node_name)
		-- overwrite portal data name 
		v.node_name = node_name
	end
	return element_portals.VOID_ACTION
end

-- Consumes the fuel, substracts the number of the stack specifiend in meta
-- @return true if the fuel was consumed, false otherwise 
function element_portals:consume_fuel(meta)
	local inv = meta:get_inventory()
	local fuel_stack = meta:get_string("fuel_stack")
	
	if inv:contains_item("fuel", fuel_stack) then
		-- exception for bucket with water, lava or anything else - be good and just empty the bucket
		
		local take_stack = ItemStack(fuel_stack)
		
		local inv_list = inv:get_list("fuel");
		local inv_stack = inv_list[1];
		-- 						   ^ - magic number that works
		inv_stack:take_item(take_stack:get_count())
		-- mintest support about stacks is poor documented -- any simple solution ?  
		if element_portals:string_starts(fuel_stack, "bucket:bucket") and inv_stack:get_count() == 0 then
			inv:set_list("fuel", {"bucket:bucket_empty 1"}) 
		else 
			inv:set_list("fuel", {inv_stack})
		end	 
		return true
	else 
		return false
	end
end

function element_portals:teleport_to(selected_portal_name, player, travel_free, departure_meta_and_pos)
	local departure_portal_meta 
	local departure_portal_pos
	local departure_portal_node_name 
	if departure_meta_and_pos then
		departure_portal_meta = departure_meta_and_pos.meta
		departure_portal_pos = departure_meta_and_pos.pos
	end 
	local portals = element_portals:read_player_portals_table(player)
	if departure_portal_pos then
		local departure_portal_key = element_portals:construct_portal_id_key (departure_portal_pos, player)
		if portals[departure_portal_key] then
		 departure_portal_node_name =  portals[departure_portal_key].node_name
		end
	end
	local k, v
	for k,v in pairs(portals) do
		if v.portal_name ==  selected_portal_name then
			local destination_node_data = element_portals:get_portal_node_data(k, v)
			local valid_end_point_portal =  element_portals:is_registered_out_portal(destination_node_data.node.name)
			if valid_end_point_portal then
				local teleport_posible = travel_free or (departure_portal_meta and element_portals:consume_fuel(departure_portal_meta, player))
				if teleport_posible then
					v.pos.y  = v.pos.y + 1
					if departure_portal_node_name then
						element_portals:play_node_action_sound(element_portals.TELEPORT_ACTION, departure_portal_node_name , player)
					end
					player:setpos(v.pos)
				end
			else
				minetest.chat_send_player(player:get_player_name(), "The selected portal is disabled and it cannot be used")
			end
			return
		end
	end
end
-- run a sanitize when player joins
minetest.register_on_joinplayer(function(player) 
  if player then
  	 element_portals:sanitize_player_portals(player)
  end 
end)
