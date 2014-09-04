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

-- creates a boilerplate for private portals - adds owner in meta and allows only private use   
function element_portals:build_private_node_o_template (params, portal_node_name)
	return {
	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		meta:set_string("owner", placer:get_player_name() or "")
		print (portal_node_name)
		local portal_name = element_portals:create_portal(pos, placer, portal_node_name)
		meta:set_string("infotext", "Portal ".. portal_name .." (owned by "..
				meta:get_string("owner")..")")
	end,
	on_destruct = function(pos)
		local meta = minetest.get_meta(pos)
		local player = minetest.get_player_by_name(meta:get_string("owner"))
		element_portals:remove_portal_data(pos, player)
	end,
	can_dig = function(pos, player)
		local meta = minetest.get_meta(pos);
		return element_portals:has_private_portal_privilege(meta, player)
	end,
	on_rightclick = function(pos, node, clicker)
		element_portals:show_out_portal_form(pos,  clicker)
	end
	}
end

-- creates a boilerplate for private portals - adds owner in meta and allows only private use   
function element_portals:build_private_node_io_template (params, portal_node_name)
	return {
	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		meta:set_string("owner", placer:get_player_name() or "")
		local portal_name = element_portals:create_portal(pos, placer, portal_node_name)
		meta:set_string("infotext", "Portal ".. portal_name .." (owned by "..
				meta:get_string("owner")..")")
	end,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", "Private Portal")
		meta:set_string("owner", "")
		local inv = meta:get_inventory()
		inv:set_size("fuel", 1)
		element_portals:set_portal_node_meta(meta, params)
	end,
	on_destruct = function(pos)
		local meta = minetest.get_meta(pos)
		local player = minetest.get_player_by_name(meta:get_string("owner"))
		if meta and player then 
		element_portals:remove_portal_data(pos, player)
		end 
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("fuel") and element_portals:has_private_portal_privilege(meta, player)
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local meta = minetest.get_meta(pos)
		if not  element_portals:has_private_portal_privilege(meta, player) then
			minetest.log("action", player:get_player_name()..
					" tried to access a private portal belonging to "..
					meta:get_string("owner").." at "..
					minetest.pos_to_string(pos))
			return 0
		end
		return count
	end,
    allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		if not element_portals:has_private_portal_privilege(meta, player) then
			minetest.log("action", player:get_player_name()..
					" tried to access a private portal belonging to "..
					meta:get_string("owner").." at "..
					minetest.pos_to_string(pos))
			return 0
		end
		return stack:get_count()
	end,
    allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		if not  element_portals:has_private_portal_privilege(meta, player) then
			minetest.log("action", player:get_player_name()..
					" tried to access a private portal belonging to "..
					meta:get_string("owner").." at "..
					minetest.pos_to_string(pos))
			return 0
		end
		return stack:get_count()
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		element_portals:show_portal_form(pos, player)
		
		minetest.log("action", player:get_player_name()..
				" moves stuff in private portal at "..minetest.pos_to_string(pos))
	end,
    on_metadata_inventory_put = function(pos, listname, index, stack, player)
    	element_portals:show_portal_form(pos, player)	
    			
		minetest.log("action", player:get_player_name()..
				" moves stuff to private portal at "..minetest.pos_to_string(pos))
	end,
    on_metadata_inventory_take = function(pos, listname, index, stack, player)
    	element_portals:show_portal_form(pos, player)		
    	
		minetest.log("action", player:get_player_name()..
				" takes stuff from private portal at "..minetest.pos_to_string(pos))
	end,
	on_rightclick = function(pos, node, clicker)
		element_portals:show_portal_form(pos,  clicker)
	end
	}
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
		local callback = function( buffer_pos, node_name_matched, replacement_node_name, affected_node_name)
			minetest.dig_node(buffer_pos)
			if replacement_node_name and replacement_node_name~="air" then 
				node = minetest.get_node(buffer_pos)
				if node.name ~= replacement_node_name then
					minetest.set_node(buffer_pos, {name=replacement_node_name})
				end
			end
		end
		element_portals:iterate_offsets(pos, params.replace_surroundings, callback)
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

local build_node_template = function(params, name)
	local node_template
	if params.portal_type == element_portals.IN_OUT_PORTAL then 
		 node_template = element_portals:build_private_node_io_template(params, name)
	elseif params.postal_type == element_portals.IN_PORTAL then
		 node_template = element_portals:build_private_node_i_template(params, name)
	else
		 node_template = element_portals:build_private_node_o_template(params, name)
	end
	return node_template
end
-- Configures the template for the node and expands it with the overwrites
-- parameter. 
-- params should contain the `active_node` ex: `default:tree` the `inactive_node` and the `fuel` stack string ex `default:wood 1` 
function element_portals:register_private_portal_node(name, overwrites, params)
	node = {}
	
	local node_template = build_node_template(params, name)
	
	for k,v in pairs(node_template) do
		node[k]=v
	end
	for k,v in pairs(overwrites) do
		node[k]=v
	end
	
	element_portals:register_portal(name, params)
	
	-- register node here
	minetest.register_node(name, node)
	
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
