minetest.register_chatcommand("sanitize_portals", {
	params = "",
	description = "checks all the portals of an user and corrects their state if possible, otherwise the portal data is removed or is disabled from user portals file, attempts to correct the node meta as well",
	func = function(name, param)
		local player = minetest.get_player_by_name(name)
		if not player then
			return false, "Player not found"
		end
		element_portals:sanitize_player_portals(player)
		return true, "Done."
	end,
})


minetest.register_chatcommand("teleport_free", {
	params = "",
	description = "Opens Teleport dialog - allows user to teleport for free",
	func = function(name, param)
		local player = minetest.get_player_by_name(name)
		if not player then
			return false, "Player not found"
		end
		element_portals:show_item_portal_form(player)
		return true, "Done."
	end,
})
