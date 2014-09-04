-- GENERATED CODE
-- Node Box Editor, version 0.7 - Iron
-- Namespace: test
local ray_node_fixed_box =  {
		type = "fixed",
		fixed = {
			{0.4375, -0.5, -0.125, 0.5, 0.5, 0.125}, -- NodeBox1
			{0.375, -0.5, 0.125, 0.4375, 0.5, 0.25}, -- NodeBox2
			{0.3125, -0.5, 0.25, 0.375, 0.5, 0.3125}, -- NodeBox3
			{0.25, -0.5, 0.25, 0.3125, 0.5, 0.375}, -- NodeBox4
			{0.125, -0.5, 0.375, 0.25, 0.5, 0.4375}, -- NodeBox5
			{-0.125, -0.5, 0.4375, 0.125, 0.5, 0.5}, -- NodeBox6
			{-0.25, -0.5, 0.375, -0.125, 0.5, 0.4375}, -- NodeBox7
			{-0.3125, -0.5, 0.25, -0.25, 0.5, 0.375}, -- NodeBox8
			{-0.375, -0.5, 0.25, -0.3125, 0.5, 0.3125}, -- NodeBox9
			{-0.4375, -0.5, 0.125, -0.375, 0.5, 0.25}, -- NodeBox10
			{-0.5, -0.5, -0.125, -0.4375, 0.5, 0.125}, -- NodeBox11
			{-0.125, -0.5, -0.5, 0.125, 0.5, -0.4375}, -- NodeBox12
			{-0.25, -0.5, -0.4375, -0.125, 0.5, -0.375}, -- NodeBox13
			{-0.4375, -0.5, -0.25, -0.375, 0.5, -0.125}, -- NodeBox14
			{-0.375, -0.5, -0.3125, -0.25, 0.5, -0.25}, -- NodeBox15
			{-0.3125, -0.5, -0.375, -0.25, 0.5, -0.3125}, -- NodeBox18
			{0.125, -0.5, -0.4375, 0.25, 0.5, -0.375}, -- NodeBox19
			{0.375, -0.5, -0.25, 0.4375, 0.5, -0.125}, -- NodeBox20
			{0.25, -0.5, -0.375, 0.375, 0.5, -0.3125}, -- NodeBox21
			{0.3125, -0.5, -0.3125, 0.375, 0.5, -0.25}, -- NodeBox22
		}
	}

local register_portal_ray = function(name ,texture, post_effect_color)

	minetest.register_node(name, {
		tiles = {
			"ray_y_tile.png",
			"ray_y_tile.png",
			texture,
			texture,
			texture,
			texture
		},
		paramtype="light",
		use_texture_alpha = true,
		walkable = false,
		pointable = false,
		diggable = false,
		drawtype = "nodebox",
		is_ground_content = true,
		light_source = LIGHT_MAX - 1,
		post_effect_color = post_effect_color, 
		node_box = ray_node_fixed_box 
	})
	
	minetest.register_abm({
		nodenames = {name} ,
		interval = 3,
		chance = 1,
		action = function(pos, node, active_object_count, active_object_count_wider)
			local result = element_portals:node_on_axis(pos, "portal_active", -4, -1, "y")
			if result.count == 0 then 	
				minetest.set_node(pos, {name="air"})
			end			 
		end
	})
	
	
end

register_portal_ray("liquid_portals:water_portal_ray_bottom", "water_portal_ray_bottom.png", { r=125, g=198, b=198, a=50 })
register_portal_ray("liquid_portals:water_portal_ray_top", "water_portal_ray_top.png", { r=125, g=198, b=198, a=50 })
register_portal_ray("liquid_portals:lava_portal_ray_bottom", "lava_portal_ray_bottom.png", { r=125, g=198, b=198, a=50 })
register_portal_ray("liquid_portals:lava_portal_ray_top", "lava_portal_ray_top.png", { r=125, g=198, b=198, a=50 })

