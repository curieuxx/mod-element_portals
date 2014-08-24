if not element_portals then
	element_portals = {}
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
			element_portals:show_portal_form(portals[portal_key].pos, player, message)
			return old_name
		end 
		for k,v in pairs(portals) do
			if portal_key ~= k then	
			 	
				if v.portal_name == new_name then
					message = "You own another portal with the name ".. new_name .." at "..  minetest.pos_to_string(v.pos) ..", reverting to "..old_name
					minetest.chat_send_player(player_name, message)
					element_portals:show_portal_form(portals[portal_key].pos, player, message)
					return old_name
				end
			end
		end
		portals[portal_key].portal_name = new_name
		element_portals:write_player_portals_table(player, portals)
		return new_name;
	end
end
