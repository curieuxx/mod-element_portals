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

-- checks if portal is powered or unpowered and swaps the node acordingly
function element_portals:swap_if_needed (node, pos, meta, fuel_stack, active_node, inactive_node)
	if element_portals:is_portal_powered(meta, fuel_stack) and node.name ~= active_node then
		element_portals:swap_node(pos, active_node)
	end
	if not element_portals:is_portal_powered(meta, fuel_stack) and node.name == active_node then
		element_portals:swap_node(pos, inactive_node)
	end
end

-- creates a boiler plate for private portals - adds owner in meta and allows only private use   
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
	minetest.register_node(name, node)
	
	minetest.register_abm({
		nodenames = {params.inactive_node, params.active_node},
		interval = 1.0,
		chance = 1,
		action = function(pos, node, active_object_count, active_object_count_wider)
			local meta = minetest.get_meta(pos)
			 element_portals:swap_if_needed(node, pos, meta, params.fuel, params.active_node, params.inactive_node)
		end
	})
	
end
