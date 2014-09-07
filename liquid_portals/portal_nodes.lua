-- GENERATED CODE
-- Node Box Editor, version 0.7 - Iron
local liquid_portal_nodebox = {
		type = "fixed",
		fixed = {
			{-0.125, -0.375, -0.125, 0.125, 0.375, 0.125}, -- NodeBox6
			{-0.25, -0.3125, -0.125, 0.25, 0.3125, 0.125}, -- NodeBox7
			{-0.125, -0.3125, -0.25, 0.125, 0.3125, 0.25}, -- NodeBox9
			{-0.1875, -0.3125, -0.1875, 0.1875, 0.3125, 0.1875}, -- NodeBox15
			{-0.3125, -0.25, -0.125, 0.3125, 0.25, 0.125}, -- NodeBox16
			{-0.125, -0.25, -0.3125, 0.125, 0.25, 0.3125}, -- NodeBox17
			{-0.1875, -0.25, -0.25, 0.1875, 0.25, 0.25}, -- NodeBox19
			{-0.25, -0.25, -0.1875, 0.25, 0.25, 0.1875}, -- NodeBox20
			{-0.25, -0.1875, -0.25, 0.25, 0.1875, 0.25}, -- NodeBox21
			{-0.3125, -0.1875, -0.1875, 0.3125, 0.1875, 0.1875}, -- NodeBox22
			{-0.1875, -0.1875, -0.3125, 0.1875, 0.1875, 0.3125}, -- NodeBox23
			{-0.125, -0.125, -0.375, 0.125, 0.125, 0.375}, -- NodeBox24
			{-0.375, -0.125, -0.125, 0.375, 0.125, 0.125}, -- NodeBox25
			{-0.3125, -0.125, -0.1875, 0.3125, 0.125, 0.1875}, -- NodeBox26
			{-0.1875, -0.125, -0.3125, 0.1875, 0.125, 0.3125}, -- NodeBox27
			{-0.25, -0.125, -0.25, 0.25, 0.125, 0.25}, -- NodeBox28
			{-0.5, -0.5, -0.5, -0.3125, 0.5, -0.4375}, -- NodeBox30
			{-0.5, -0.5, -0.4375, -0.4375, 0.5, -0.3125}, -- NodeBox31
			{-0.5, -0.5, 0.4375, -0.3125, 0.5, 0.5}, -- NodeBox32
			{-0.5, -0.5, 0.3125, -0.4375, 0.5, 0.4375}, -- NodeBox33
			{0.4375, -0.5, 0.3125, 0.5, 0.5, 0.5}, -- NodeBox34
			{0.3125, -0.5, 0.4375, 0.5, 0.5, 0.5}, -- NodeBox35
			{0.3125, -0.5, -0.5, 0.5, 0.5, -0.4375}, -- NodeBox36
			{0.4375, -0.5, -0.4375, 0.5, 0.5, -0.3125}, -- NodeBox37
			{-0.5, -0.5, -0.5, 0.5, -0.4375, -0.3125}, -- NodeBox38
			{-0.5, -0.5, 0.3125, 0.5, -0.4375, 0.5}, -- NodeBox39
			{0.3125, -0.5, -0.5, 0.5, -0.4375, 0.5}, -- NodeBox40
			{-0.5, -0.5, -0.5, -0.3125, -0.4375, 0.5}, -- NodeBox41
			{-0.5, -0.5, -0.5, 0.5, -0.3125, -0.4375}, -- NodeBox42
			{0.4375, -0.5, -0.5, 0.5, -0.3125, 0.5}, -- NodeBox43
			{-0.5, -0.5, -0.5, -0.4375, -0.3125, 0.5}, -- NodeBox44
			{-0.5, -0.5, 0.4375, 0.5, -0.3125, 0.5}, -- NodeBox45
			{-0.5, 0.4375, -0.5, -0.3125, 0.5, 0.5}, -- NodeBox46
			{-0.5, 0.4375, 0.3125, 0.5, 0.5, 0.5}, -- NodeBox47
			{0.3125, 0.4375, -0.5, 0.5, 0.5, 0.5}, -- NodeBox48
			{-0.5, 0.4375, -0.5, 0.5, 0.5, -0.3125}, -- NodeBox49
			{-0.5, 0.3125, 0.4375, 0.5, 0.5, 0.5}, -- NodeBox50
			{-0.5, 0.3125, -0.5, -0.4375, 0.5, 0.5}, -- NodeBox51
			{-0.5, 0.3125, -0.5, 0.5, 0.5, -0.4375}, -- NodeBox52
			{0.4375, 0.3125, -0.5, 0.5, 0.5, 0.5}, -- NodeBox53
		}
	} 
-- END GENERATED CODE

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
	node_box = liquid_portal_nodebox,
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
	node_box = liquid_portal_nodebox,
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
	node_box = liquid_portal_nodebox,
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
	node_box = liquid_portal_nodebox,		
	groups = {cracky=3,hot=3, igniter=5},
	light_source = LIGHT_MAX - 1,
	liquidtype = "source",
	liquid_alternative_flowing = "liquid_portals:lava_flowing",
	liquid_alternative_source = "liquid_portals:lava_portal_active",
	liquid_renewable = false,
	post_effect_color = {a=192, r=255, g=64, b=0}
},  lava_portal_params )

element_portals:register_portal_abm(lava_portal_params)

