
local handle_update = function(player, fields, meta)
    if fields["selected_portal_name"] and meta then
    	meta:set_string("selected_portal_name", fields["selected_portal_name"] or "")
    end
	if fields["portal_name"] and fields["portal_key"] then
		portal_name =  element_portals:update_portal_name(player, fields["portal_key"], fields["portal_name"])
		if meta and portal_name then
			meta:set_string("infotext", "Portal ".. portal_name .." (owned by "..meta:get_string("owner")..")")
		end
	end
end

function element_portals:consume_fuel(meta, player)
	local inv = meta:get_inventory()
	local fuel_stack = meta:get_string("fuel_stack")
	
	if inv:contains_item("fuel", fuel_stack) then
		-- exception for bucket with water, lava or anything else - be god and just empty the bucket
		
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

local handle_teleport = function(player, fields, meta)
	if fields["selected_portal_name"] and fields["teleport"] == "Teleport" then
		local selected_portal_name = fields["selected_portal_name"]
		local travel_free = fields["travel_free"] == "true"
		element_portals:teleport_to(selected_portal_name, player, travel_free, meta)
	end
end

local retrieve_meta = function(fields)
	local meta
	if fields["portal_pos"]  then
		local pos = minetest.string_to_pos(fields["portal_pos"])
		if pos then 
			meta = minetest.get_meta(pos)
		end
	end
	return meta
end

function element_portals:update_portal_name(player, portal_key, new_name)
	if not player or not portal_key or not new_name then
			return
	end
    local player_name = player:get_player_name()
	local portals = element_portals:read_player_portals_table(player)
	
	if portals[portal_key] then
		
		local old_name = portals[portal_key].portal_name;
		-- not changed
		if old_name == new_name then
			return old_name
		end
		local message = ""
		local revert = false
		if new_name == "" then
			message = "No portal name was specified, reverting to "..old_name
			minetest.chat_send_player(player_name, message)
			element_portals:show_name_portal_form(portals[portal_key].pos, player, message)
			return old_name
		end 
		for k,v in pairs(portals) do
			if portal_key ~= k then
				if v.portal_name == new_name then
					message = "You own another portal with the name ".. new_name .." at "..  minetest.pos_to_string(v.pos) ..", reverting to "..old_name
					minetest.chat_send_player(player_name, message)
					element_portals:show_name_portal_form(portals[portal_key].pos, player, message)
					return old_name
				end
			end
		end
		portals[portal_key].portal_name = new_name
		element_portals:write_player_portals_table(player, portals)
		return new_name;
	end
end

minetest.register_on_player_receive_fields(function(player,formname,fields)
	if formname ~= element_portals.PORTAL_FORM_NAME then 
		return
	end
	local meta  = retrieve_meta(fields)
	handle_update(player,fields, meta)
	if fields['quit'] then
		handle_teleport(player, fields, meta) 
	end
end)
