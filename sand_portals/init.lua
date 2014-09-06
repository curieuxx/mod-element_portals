local sand_portal_params=  {
 fuel_stack = "default:sand 1",
 --fuel_surrounding = "default:sand",
 --fuel_surrounding_count = 4,
 portal_type = element_portals.IN_PORTAL,
 portal_groups = {"sand_portals"},
 filter_group = "sand_portals",
 active_node = "sand_portals:sand_portal_active", 
 inactive_node = "sand_portals:sand_portal",
 swap_enabled = true,
 replace_surroundings = {
 	except_nodes_containing_in_name = {"water_source", "lava_source", "lava_flowing", "water_flowing", "sand_portal_vortex" },
 	offsets = {
 		{pos = {y = 1}, replacement_node_name="sand_portals:sand_portal_vortex"},
 		{pos = {y = 2}, replacement_node_name="sand_portals:sand_portal_vortex"}
 	}
 }
}

element_portals:register_private_portal_node("sand_portals:sand_portal_active", {
	description = "Sand Portal - Input",
	tiles = {"default_sand.png"},
	is_ground_content = true,
	paramtype="light",
	groups = {cracky=3}
}, sand_portal_params)

element_portals:register_private_portal_node("sand_portals:sand_portal", {
	description = "Sand Portal - Input",
	tiles = {"default_sand.png"},
	is_ground_content = true,
	paramtype="light",
	groups = {cracky=3}
}, sand_portal_params)

element_portals:register_portal_abm(sand_portal_params)

local teleport_to = function(selected_portal_name, player, meta)
	element_portals:teleport_to(selected_portal_name, player, false, meta)
end

local player_in_radius = function (pos, player_name) 
	local all_objects = minetest.get_objects_inside_radius(pos, element_portals.SCAN_RADIUS or 1)
	local players = {}
	local _,obj
	local result = false
	for _,obj in ipairs(all_objects) do
		if obj:is_player() and obj:get_player_name() == player_name then		
			result = obj
			break
		end
	end
	return result
end

minetest.register_abm({
		nodenames = {"sand_portals:sand_portal_active"} ,
		interval = 0.5,
		chance = 1,
		action = function(pos, node, active_object_count, active_object_count_wider)
			local meta = minetest.get_meta(pos)
			local owner = meta:get_string("owner")
			local selected_portal_name = meta:get_string("selected_portal_name")
			if not owner and not selected_portal_name then 
				return
			end
			local player = player_in_radius(pos, owner)
			if player then 
				teleport_to(selected_portal_name, player, meta)
			end 
		end
})

local desert_sand_portal_params =  {
 portal_type = element_portals.OUT_PORTAL,
 portal_groups = {"sand_portals"},
 active_node = "sand_portals:desertsand_portal"
}

element_portals:register_private_portal_node("sand_portals:desertsand_portal", {
	description = "Desert Sand Portal - Output",
	tiles = {"default_sand.png"},
	is_ground_content = true,
	paramtype="light",
	groups = {cracky=3}
}, desert_sand_portal_params)



minetest.register_node("sand_portals:sand_portal_vortex", {
	description = "Desert Sand Portal - Vortex",
	tiles = {"default_sand.png"},
	drawtype = "normal",
	is_ground_content = true,
	liquidtype =  "source",
	liquid_alternative_flowing = "sand_portals:sand_portal_vortex_power_field",
	liquid_alternative_source  = "sand_portals:sand_portal_vortex",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	paramtype = "light",
	liquid_viscosity = 30 ,
	groups = {water=3, liquid=3}
})

minetest.register_node("sand_portals:sand_portal_vortex_power_field", {
	description = "Desert Sand Portal - Vortex",
	tiles = {"default_sand.png"},
	drawtype = "airlike",
	is_ground_content = true,
	liquidtype =  "none",
	liquid_alternative_flowing = "sand_portals:sand_portal_vortex_power_field",
	liquid_alternative_source  = "sand_portals:sand_portal_vortex",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	paramtype = "light",
	--paramtype2 = "flowingliquid",
	liquid_viscosity = 30 ,
	groups = {water=3, liquid=3}
})


minetest.register_abm({
		nodenames = {"sand_portals:sand_portal_vortex"} ,
		interval = 3,
		chance = 1,
		action = function(pos, node, active_object_count, active_object_count_wider)
			local result = element_portals:node_on_axis(pos, "sand_portal_active", -4, -1, "y")
			if result.count == 0 then 	
				minetest.set_node(pos, {name="air"})
			end			 
		end
	})

