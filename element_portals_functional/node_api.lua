--[[

Node handeling and manip related functions

Copyright 2014 Tiberiu CORBU
Authors: Tiberiu CORBU

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
--]]

if not element_portals then
	element_portals = {}
end
-- utility method that helps to swap between active and inactive nodes 
-- but its use is not limited to that
function element_portals:swap_node(pos,name)
	local node = minetest.get_node(pos)
	if node.name == name then
		return
	end
	node.name = name
	minetest.swap_node(pos,node)
end

function element_portals:except_nodes_by_name (node_name, global_except_table, pos_except_table)
	return element_portals:contains_any(node_name, global_except_table) or element_portals:contains_any(node_name, pos_except_table)
end

function element_portals:node_on_axis(pos, node_name_contains, range_min, range_max, axis)
	local offsets = {}
	local min_value =  range_min
	local max_value =  range_max
	for axis_offset = min_value, max_value, 1 do	
			local buffer_pos = {}
			buffer_pos[axis] = axis_offset 
			table.insert(offsets, {pos= buffer_pos, match_node_names=node_name})		
	end
	local count = 0
	local result = {pos = {}}
	local callback = function( buffer_pos, node_name_matched, replacement_node_name, affected_node_name)
		if element_portals:contains_any(affected_node_name ,{node_name_contains}) then
			table.insert(result.pos, {buffer_pos})
			count = count+1
		end 
	end
	element_portals:iterate_offsets(pos, {offsets= offsets }, callback)
	result["count"] = count
	return result
end

function element_portals:node_in_square_range(pos, node_name, range, first_axis, second_axis)
	local offsets = {}
	local min_value = range*(-1)
	local max_value = range
	for first_axis_offset = min_value, max_value, 1 do	
		for second_axis_offset = min_value, max_value, 1 do	
			local buffer_pos = {}
			buffer_pos[first_axis] = first_axis_offset
			buffer_pos[second_axis] = second_axis_offset 
			table.insert(offsets, {pos= buffer_pos, match_node_names=node_name})
		end		
	end
	local count = 0
	local result = {pos = {}}
	local callback = function( buffer_pos, node_name_matched, replacement_node_name, affected_node_name)
		if node_name_matched then
			table.insert(result.pos, {buffer_pos})
			count = count+1
		end 
	end
	element_portals:iterate_offsets(pos, {offsets= offsets }, callback)
	result["count"] = count
	return result
end

function element_portals:iterate_offsets (pos, params, callback)
	local buffer_pos
	for index, offset in pairs(params.offsets or {}) do 	
			buffer_pos = {x=pos.x, y=pos.y, z=pos.z}
			
			for axis, offset_value in pairs(offset.pos) do
				local new_val = buffer_pos[axis]+offset_value
				buffer_pos[axis]=new_val
			end
			local affected_node = minetest.get_node(buffer_pos)
			local affected_node_name = affected_node.name
			
			-- extract replacement_node_name from params with fallback 
			local replacement_node_name
			if offset.replacement_node_name and offset.replacement_node_name then
				replacement_node_name = offset.replacement_node_name
			else 
				replacement_node_name = "air"
			end	
			
			local node_name_matched = false
			if offset.match_node_names and offset.match_node_names then
			
				local match_node_name = offset.match_node_names
				node_name_matched = affected_node_name ==  match_node_name

			end	
			-- compute exceptions 
			local except = element_portals:except_nodes_by_name(affected_node_name, params.except_nodes_containing_in_name, offset.except_nodes_containing_in_name)
			if (not except or node_name_matched) and affected_node_name ~= replacement_node_name then 
				callback(buffer_pos, node_name_matched, replacement_node_name, affected_node_name)
			end	
	end
end

function element_portals:handle_replace_surroundings(node_name, pos, params)
	if node_name == params.active_node and params.replace_surroundings  then
		local replaced_at_least_one_node = false
	
		local callback = function( buffer_pos, node_name_matched, replacement_node_name, affected_node_name)
			minetest.dig_node(buffer_pos)
			if replacement_node_name and replacement_node_name~="air" then 
				node = minetest.get_node(buffer_pos)
				if node.name ~= replacement_node_name then
					replaced_at_least_one_node  = true
					minetest.set_node(buffer_pos, {name=replacement_node_name})
				end
			end
		end

		element_portals:iterate_offsets(pos, params.replace_surroundings, callback)
		if replaced_at_least_one_node and params.replace_surroundings.sounds then 
			element_portals:play_action_sound_at_pos(pos, element_portals.SUCCESFUL_NODE_REPLACE_ACTION, params.replace_surroundings.sounds) 
		end
	end
end


-- checks if portal is powered or unpowered and swaps the node acordingly
function element_portals:swap_if_needed (node, pos, meta, active_node, inactive_node)
	local portal_powered = element_portals:is_portal_powered(meta, pos)
	if portal_powered and node.name ~= active_node then
		element_portals:swap_node(pos, active_node)
	end
	if not portal_powered and node.name == active_node then
		element_portals:swap_node(pos, inactive_node)
	end
end

local construct_portal_node_names = function(params)
	local portal_node_names = {}
	if params.inactive_node then 
		table.insert(portal_node_names, params.inactive_node)
	end
	if params.active_node then 
		table.insert(portal_node_names, params.active_node)
	end
	if params.node_name then 
		table.insert(portal_node_names, params.node_name)
	end
	return portal_node_names
end


function element_portals:register_portal_abm(params)
-- register interval for active inactive node swaping
	local portal_node_names = construct_portal_node_names(params)
	
	minetest.register_abm({
		nodenames = portal_node_names ,
		interval = params.update_interval or 1.0,
		chance = 1,
		action = function(pos, node, active_object_count, active_object_count_wider)
			 local meta = minetest.get_meta(pos) 
			 if params.swap_enabled then
			 	element_portals:swap_if_needed(node, pos, meta, params.active_node, params.inactive_node)
			 end
			 element_portals:handle_replace_surroundings(node.name, pos, params)
		end 
	})
end
