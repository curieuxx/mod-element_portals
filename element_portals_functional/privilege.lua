if not element_portals then
	element_portals = {}
end


function  element_portals:has_private_portal_privilege(meta, player)
	if player:get_player_name() ~= meta:get_string("owner") then
		return false
	end
	return true
end

function element_portals:is_portal_powered(meta)
	local inv = meta:get_inventory()
	local fuel_stack = meta:get_string("fuel_stack")
	return inv:contains_item("fuel", fuel_stack)
end
