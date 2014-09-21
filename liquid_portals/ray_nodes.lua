
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
		is_ground_content = false,
		buildable_to = true,
		light_source = LIGHT_MAX - 1,
		post_effect_color = post_effect_color, 
		node_box = element_portals.node_box.cylinder_box_14,
		selection_box = element_portals.node_box.normal_box
	})
	
	minetest.register_abm({
		nodenames = {name} ,
		interval = 5,
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

