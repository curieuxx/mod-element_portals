if not element_portals then
	element_portals = {}
end

------------------------------------------------------------------------
------------------------ PUBLIC PORTAL NODE ---------------------------
------------------------------------------------------------------------

-- creates a boilerplate for private portals - adds owner in meta and allows only private use   
function element_portals:build_public_node_io_template (params, portal_node_name)
	return {
	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		local portal_name = element_portals:create_portal(pos, placer, portal_node_name)
		if placer then
			meta:set_string("placer", placer:get_player_name())
		end
		meta:set_string("infotext", "Portal ".. portal_name)
	end,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", "Public Portal")
		local inv = meta:get_inventory()
		inv:set_size("fuel", 1)
		element_portals:set_portal_node_meta(meta, params)
	end,
	on_destruct = function(pos)
		local meta = minetest.get_meta(pos)
--		local player = minetest.get_player_by_name(meta:get_string("owner"))
		if meta and player then 
		element_portals:remove_portal_data(pos, player)
		end 
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("fuel")
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		element_portals:show_portal_form(pos, player)
		
		minetest.log("action", player:get_player_name()..
				" moves stuff in portal at "..minetest.pos_to_string(pos))
	end,
    on_metadata_inventory_put = function(pos, listname, index, stack, player)
    	element_portals:show_portal_form(pos, player)	
    			
		minetest.log("action", player:get_player_name()..
				" moves stuff to portal at "..minetest.pos_to_string(pos))
	end,
    on_metadata_inventory_take = function(pos, listname, index, stack, player)
    	element_portals:show_portal_form(pos, player)
		minetest.log("action", player:get_player_name()..
				" takes stuff from portal at "..minetest.pos_to_string(pos))
	end,
	on_rightclick = function(pos, node, clicker)
		element_portals:show_portal_form(pos,  clicker)
	end
	}
end

local build_public_node_template = function(params, name)
	local node_template
	if params.portal_type == element_portals.IN_OUT_PORTAL or params.portal_type == element_portals.IN_PORTAL then 
		 node_template = element_portals:build_public_node_io_template(params, name)
	else	
		 node_template = element_portals:build_public_node_o_template(params, name)
	end
	return node_template
end


function element_portals:register_public_portal_node(name, overwrites, params)
	local node_template = build_public_node_template(params, name)
	extent_and_register_node(node_template, name, overwrites, params)
end

------------------------------------------------------------------------
------------------------ PRIVATE PORTAL NODE ---------------------------
------------------------------------------------------------------------


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

local build_private_node_template = function(params, name)
	local node_template
	if params.portal_type == element_portals.IN_OUT_PORTAL or params.portal_type == element_portals.IN_PORTAL then 
		 node_template = element_portals:build_private_node_io_template(params, name)
	else	
		 node_template = element_portals:build_private_node_o_template(params, name)
	end
	return node_template
end
 
function element_portals:register_private_portal_node(name, overwrites, params)
	local node_template = build_private_node_template(params, name)
	extent_and_register_node(node_template ,name, overwrites, params )
end




------------------------------------------------------------------------
------------------------ NODE COMMON LOGIC -----------------------------
------------------------------------------------------------------------

function extent_and_register_node(node_template, name, overwrites, params)
	local node = {}
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
