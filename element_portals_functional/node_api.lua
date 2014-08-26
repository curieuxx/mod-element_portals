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
function element_portals:build_private_node_template (fuel_stack)
	return {
	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		meta:set_string("owner", placer:get_player_name() or "")
		local portal_name = element_portals:create_portal(pos, placer)
		meta:set_string("infotext", "Portal ".. portal_name .." (owned by "..
				meta:get_string("owner")..")")
		
	end,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", "Private Portal")
		meta:set_string("owner", "")
		local inv = meta:get_inventory()
		inv:set_size("fuel", 1)
		meta:set_string("fuel_stack", fuel_stack)
	end,
	after_dig_node = function(pos, oldnode, oldmeta, digger)
		element_portals:remove_portal_data(pos, digger)
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

function element_portals:except_nodes_by_name (node_name, exept_table)
	if exept_table then
		for e, except in pairs(exept_table) do
			if except and string.find(node_name, except) then 
				return true
			end
		end
	end
	return false
end

function element_portals:except_nodes_by_pos_offset(axis_key, axis_offset, params)
	if params.except_pos then
		for axis_except_key, axis_offset_excepts in pairs(params.except_pos) do
			for k, axis_offset_except in pairs(axis_offset_excepts) do
				if axis_except_key==axis_key and axis_offset_except == axis_offset  then 
					return true
				end
			end
		end
	end
	return false
end

function element_portals:iterate_offsets (pos, params, callback)
	local x = pos.x
	local y = pos.y
	local z = pos.z
	local buffer_pos
	for axis, offset in pairs(params.offsets or {}) do 
		for index, offset_value in pairs (offset.values or {}) do
			-- calculate offset position 
			buffer_pos = {x=x, y=y, z=z}
			local new_val = buffer_pos[axis]+offset_value
			buffer_pos[axis]=new_val
			local affected_node = minetest.get_node(buffer_pos)
			local affected_node_name = affected_node.name
			
			-- extract replacement_node_name from params with fallback 
			local replacement_node_name
			if offset.replacement_node_names and offset.replacement_node_names[index] then
				replacement_node_name = offset.replacement_node_names[index]
			else 
				replacement_node_name = "air"
			end	
			
			local node_name_matched = false
			if offset.match_node_names and offset.match_node_names[index] then
			
				local match_node_name = offset.match_node_names[index]
				node_name_matched = affected_node_name ==  match_node_name

			end	
			-- compute exceptions 
			local except = element_portals:except_nodes_by_name(affected_node_name, params.except_nodes_containing_in_name)
			if (not except or node_name_matched) and affected_node_name ~= replacement_node_name then 
				callback(buffer_pos, node_name_matched, replacement_node_name, affected_node_name)
			end	
		end
	end
end


function element_portals:handle_dig_sourroundings_on_activate(node_name, pos, params)
	if node_name == params.active_node and params.dig_sourroundings_on_activate then
		local callback = function( buffer_pos, node_name_matched, replacement_node_name, affected_node_name)
			minetest.dig_node(buffer_pos)
			if replacement_node_name and replacement_node_name~="air" then 
				node = minetest.get_node(buffer_pos)
				if node.name ~= replacement_node_name then
					minetest.set_node(buffer_pos, {name=replacement_node_name})
				end
			end
		end
		element_portals:iterate_offsets(pos, params.dig_sourroundings_on_activate, callback)
	end
end

function element_portals:handle_clear_sourroundings_on_deactivate(node_name, pos, params)
	if node_name == params.inactive_node and params.clear_sourroundings_on_deactivate then
		local callback = function( buffer_pos, node_name_matched, replacement_node_name, affected_node_name)
			
			if node_name_matched then 
				
				minetest.set_node(buffer_pos, {name="air"})
			end
		end
		element_portals:iterate_offsets(pos, params.clear_sourroundings_on_deactivate, callback)
	end
end


-- checks if portal is powered or unpowered and swaps the node acordingly
function element_portals:swap_if_needed (node, pos, meta, fuel_stack, active_node, inactive_node)
	if element_portals:is_portal_powered(meta, fuel_stack) and node.name ~= active_node then
		element_portals:swap_node(pos, active_node)
	end
	if not element_portals:is_portal_powered(meta, fuel_stack) and node.name == active_node then
		element_portals:swap_node(pos, inactive_node)
	end
end

-- Configures the template for the node and expands it with the overwrites
-- parameter. 
-- params should contain the `active_node` ex: `default:tree` the `inactive_node` and the `fuel` stack string ex `default:wood 1` 
function element_portals:create_private_portal_node(name, overwrites, params)
	node = {}
	local node_template = element_portals:build_private_node_template(params.fuel)
	for k,v in pairs(node_template) do
		node[k]=v
	end
	for k,v in pairs(overwrites) do
		node[k]=v
	end
	-- register node here
	minetest.register_node(name, node)
	-- register interval for active inactive node swaping
	minetest.register_abm({
		nodenames = {params.inactive_node, params.active_node},
		interval = 1.0,
		chance = 1,
		action = function(pos, node, active_object_count, active_object_count_wider)
			 local meta = minetest.get_meta(pos)
			 element_portals:swap_if_needed(node, pos, meta, params.fuel, params.active_node, params.inactive_node)
			 element_portals:handle_dig_sourroundings_on_activate(node.name, pos, params)
			 element_portals:handle_clear_sourroundings_on_deactivate(node.name, pos, params);
		end
	})
	
end
