if not element_portals then
	element_portals = {}
end

function element_portals:show_item_portal_form(clicker, portal_group ,message)
	local formspec = element_portals:create_item_portal_formspec(clicker, portal_group, message)
	minetest.show_formspec(
		clicker:get_player_name(),
		element_portals.PORTAL_FORM_NAME,
		formspec
	)
end

function element_portals:show_name_portal_form(pos, clicker, message)
	local meta = minetest.get_meta(pos)
	if element_portals:has_private_portal_privilege(meta, clicker) then
		local formspec = element_portals:create_out_portal_formspec(pos, clicker, selected_portal_name , message)
		minetest.show_formspec(
			clicker:get_player_name(),
			element_portals.PORTAL_FORM_NAME,
			formspec
		)
	end
end

function element_portals:show_out_portal_form(pos ,clicker, message)
	local meta = minetest.get_meta(pos)
	if element_portals:has_private_portal_privilege(meta, clicker) then
		local formspec = element_portals:create_out_portal_formspec(pos, clicker, selected_portal_name , message)
		minetest.show_formspec(
			clicker:get_player_name(),
			element_portals.PORTAL_FORM_NAME,
			formspec
		)
	end
end

function element_portals:show_portal_form(pos, clicker, message)
	local meta = minetest.get_meta(pos)
	
	if element_portals:has_private_portal_privilege(meta, clicker) then
		local formspec = ""
		local selected_portal_name = meta:get_string("selected_portal_name")
		local acitve_from_inv = element_portals:is_portal_powered_from_inv(meta, pos) 
		if not acitve_from_inv then
			local acitve_from_surr = element_portals:is_portal_powered_from_surroundings(meta, pos)
			if acitve_from_surr then
				formspec = element_portals:create_travel_free_portal_formspec(pos, clicker, selected_portal_name , message)
			end
		end
		
		if formspec == "" then
			formspec = element_portals:create_portal_formspec(pos, clicker, selected_portal_name, acitve_from_inv,message)
		end
		
		minetest.show_formspec(
			clicker:get_player_name(),
			element_portals.PORTAL_FORM_NAME,
			formspec
		)
	end
end
