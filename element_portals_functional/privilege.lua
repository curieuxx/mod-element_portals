if not element_portals then
	element_portals = {}
end


function  element_portals:has_private_portal_privilege(meta, player)
	local owner = meta:get_string("owner")
	local result = false
	if not owner or owner == "" then
		result = true
	end
	if player:get_player_name() == owner then
		result = true
	end
	return result
end

function element_portals:is_portal_powered_from_inv(meta, pos)
	local fuel_stack = meta:get_string("fuel_stack")
	if fuel_stack ~= "" then
		local inv = meta:get_inventory()
		return inv:contains_item("fuel", fuel_stack)
	else 
		return false
	end
end

function element_portals:is_portal_powered_from_surroundings(meta, pos)
	local fuel_surrounding = meta:get_string("fuel_surrounding")
	local fuel_surrounding_count = meta:get_int("fuel_surrounding_count") or 4
	local result = false 
	if fuel_surrounding ~= "" then 
		local res = element_portals:node_in_square_range(pos, fuel_surrounding, 1, "x", "z")
		result = res.count >= fuel_surrounding_count
	end
	
	return result
end

function element_portals:is_portal_powered(meta, pos)
	return element_portals:is_portal_powered_from_inv(meta, pos) or element_portals:is_portal_powered_from_surroundings(meta, pos)
end
