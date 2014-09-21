local water_portal_params =  {
 fuel_stack = "bucket:bucket_water 1",
 fuel_surrounding = "default:water_source",
 fuel_surrounding_count = 4,
 portal_type = element_portals.IN_OUT_PORTAL,
 portal_groups = {"liquid_portals"},
 filter_group = "liquid_portals",
 active_node = "liquid_portals:water_portal_active", 
 inactive_node = "liquid_portals:water_portal",
 swap_enabled = true, 
 sounds = {
 	{action=element_portals.TELEPORT_ACTION ,sound="water_splash"}	
 },
 replace_surroundings = {
 	except_nodes_containing_in_name = {"water_source", "water_flowing", "portal_ray" },
 	offsets = {
 		-- if unspecified replacement_node_names, air is the default 
 		{pos = {x=-1}},
 		{pos = {x= 1}},
 		{pos = {z = -1}},
 		{pos = {z=1}},
 		{pos = {y= -1}},
 		{pos = {y = 1}, replacement_node_name="liquid_portals:water_portal_ray_bottom"},
 		{pos = {y = 2}, replacement_node_name="liquid_portals:water_portal_ray_top"}
 	}
 }
}

element_portals:register_portal_abm(water_portal_params)

element_portals:register_private_portal_node("liquid_portals:water_portal", {
	description = "Water Portal",
	tiles = {
		{name="portal_water_anim.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=2.0}}
	},
	drawtype = "nodebox",
	use_texture_alpha = false,
	is_ground_content = true,
	paramtype="light",
	node_box = element_portals.node_box.sphere_in_hollow_box,
	selection_box = element_portals.node_box.normal_box,
	groups = {cracky=3}
}, water_portal_params)


element_portals:register_private_portal_node("liquid_portals:water_portal_active", {
	description = "Active Water Portal",
	tiles = {
		{name="portal_water_anim_active.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=2.0}}
	},
	drawtype = "nodebox",
	use_texture_alpha = false,
	is_ground_content = true,
	paramtype="light",
	drop = "liquid_portals:water_portal",
	node_box = element_portals.node_box.sphere_in_hollow_box,
	selection_box = element_portals.node_box.normal_box,
	liquidtype = "source",
	liquid_alternative_flowing = "liquid_portals:water_flowing",
	liquid_alternative_source = "liquid_portals:water_portal_active",
	groups = {cracky=3, puts_out_fire=1},
}, water_portal_params)

local lava_portal_params =  {
 fuel_stack = "bucket:bucket_lava 1",
 fuel_surrounding = "default:lava_source",
 fuel_surrounding_count = 4,
 portal_groups = {"liquid_portals"},
 filter_group = "liquid_portals",
 portal_type = element_portals.IN_OUT_PORTAL,
 active_node = "liquid_portals:lava_portal_active", 
 inactive_node = "liquid_portals:lava_portal",
 leaks = "liquid_portals:lava_flowing",
 swap_enabled = true,
 sounds = {
 	{action=element_portals.TELEPORT_ACTION ,sound="fireball_whoosh"}
 	
 },
 replace_surroundings = {
 	except_nodes_containing_in_name = {"lava_source", "lava_flowing", "portal_ray" },
 	offsets = {
 		-- if unspecified replacement_node_names, air is the default 
 		{pos = {x=-1}},
 		{pos = {x= 1}},
 		{pos = {z = -1}},
 		{pos = {z= 1}},
 		{pos = {y= -1}},
 		{pos = {y = 1}, replacement_node_name="liquid_portals:lava_portal_ray_bottom"},
 		{pos = {y = 2}, replacement_node_name="liquid_portals:lava_portal_ray_top"}
 	}
 }
}

element_portals:register_private_portal_node("liquid_portals:lava_portal", {
	description = "Lava Portal",
	drawtype = "nodebox",
	is_ground_content = true,
	paramtype="light",
	node_box = element_portals.node_box.sphere_in_hollow_box,
	selection_box = element_portals.node_box.normal_box,
	tiles = {
		{name="portal_lava_anim.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=2.0}}
	},
	groups = {cracky=3}

}, lava_portal_params  )

element_portals:register_private_portal_node("liquid_portals:lava_portal_active", {
	description = "Lava Portal Active",
	tiles = {
		{name="portal_lava_anim_active.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=2.0}}
	},
	drawtype = "nodebox",
	is_ground_content = true,
	paramtype="light",
	drop = "liquid_portals:lava_portal",	
	node_box = element_portals.node_box.sphere_in_hollow_box,
	selection_box = element_portals.node_box.normal_box,		
	groups = {cracky=3,hot=3, igniter=5},
	light_source = LIGHT_MAX - 1,
	liquidtype = "source",
	liquid_alternative_flowing = "liquid_portals:lava_flowing",
	liquid_alternative_source = "liquid_portals:lava_portal_active",
	liquid_renewable = false,
	post_effect_color = {a=192, r=255, g=64, b=0}
},  lava_portal_params )

element_portals:register_portal_abm(lava_portal_params)

