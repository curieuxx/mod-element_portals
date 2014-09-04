-- GENERATED CODE
-- Node Box Editor, version 0.7 - Iron
-- Namespace: test

minetest.register_node("tree_portals:node_back_left", {
	tiles = {
		"default_tree.png",
		"default_tree.png",
		"default_tree.png",
		"default_tree.png",
		"default_tree.png",
		"default_tree.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	drop = "tree_portals:tree_portal_root",
	groups = {tree=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.3125, -0.375, -0.4375, 0.375}, -- NodeBox1
			{-0.5, -0.5, 0.25, -0.3125, -0.4375, 0.3125}, -- NodeBox2
			{-0.375, -0.5, 0.1875, -0.1875, -0.4375, 0.25}, -- NodeBox3
			{-0.3125, -0.5, 0.125, -0.125, -0.4375, 0.1875}, -- NodeBox4
			{-0.375, -0.5, 0.0625, -0.0625, -0.4375, 0.125}, -- NodeBox5
			{-0.5, -0.5, 0, 0, -0.4375, 0.0625}, -- NodeBox6
			{-0.25, -0.5, -0.0625, 0.0625, -0.4375, 0}, -- NodeBox7
			{-0.5, -0.5, -0.125, 0.125, -0.375, -0.0625}, -- NodeBox8
			{-0.25, -0.5, -0.1875, 0.1875, -0.375, -0.125}, -- NodeBox9
			{-0.0625, -0.5, -0.3125, 0.25, -0.375, -0.1875}, -- NodeBox11
			{-0.3125, -0.5, -0.375, 0.3125, -0.375, -0.3125}, -- NodeBox12
			{0, -0.5, -0.5, 0.375, -0.375, -0.375}, -- NodeBox13
			{-0.5, -0.5, -0.4375, -0.3125, -0.4375, -0.375}, -- NodeBox16
		}
	}
})

minetest.register_node("tree_portals:node_middle_left", {
	tiles = {
		"default_tree.png",
		"default_tree.png",
		"default_tree.png",
		"default_tree.png",
		"default_tree.png",
		"default_tree.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	drop = "tree_portals:tree_portal_root",
	groups = {tree=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
	node_box = {
		type = "fixed",
		fixed = {
			{0.4375, -0.5, -0.3125, 0.5, -0.4375, 0.3125}, -- NodeBox1
			{0.25, -0.5, -0.5, 0.4375, -0.4375, 0.5}, -- NodeBox2
			{0.3125, -0.4375, -0.1875, 0.375, -0.375, 0.5}, -- NodeBox3
			{0.1875, -0.5, 0.0625, 0.3125, -0.375, 0.25}, -- NodeBox4
			{-0.0625, -0.5, 0, 0.1875, -0.375, 0.1875}, -- NodeBox5
			{-0.3125, -0.5, 0, -0.0625, -0.4375, 0.125}, -- NodeBox6
			{0.125, -0.5, -0.25, 0.25, -0.4375, -0.1875}, -- NodeBox7
			{0, -0.5, -0.1875, 0.125, -0.375, -0.125}, -- NodeBox8
			{-0.3125, -0.5, -0.25, 0, -0.375, -0.1875}, -- NodeBox9
			{-0.5, -0.5, -0.3125, -0.3125, -0.4375, -0.25}, -- NodeBox10
			{-0.5, -0.5, -0.0625, -0.3125, -0.4375, 0.0625}, -- NodeBox11
			{-0.25, -0.5, -0.0625, -0.125, -0.4375, 0}, -- NodeBox12
			{-0.375, -0.5, 0.125, -0.25, -0.4375, 0.1875}, -- NodeBox13
			{-0.5, -0.5, 0.1875, -0.375, -0.375, 0.25}, -- NodeBox14
			{0.125, -0.5, 0.25, 0.25, -0.375, 0.5}, -- NodeBox15
			{-0.125, -0.5, -0.375, -0.0625, -0.375, -0.25}, -- NodeBox17
			{-0.1875, -0.5, -0.5, -0.125, -0.4375, -0.375}, -- NodeBox18
			{-0.25, -0.5, 0.375, 0, -0.375, 0.5}, -- NodeBox19
			{-0.5, -0.5, 0.3125, -0.125, -0.375, 0.4375}, -- NodeBox20
		}
	}
})

minetest.register_node("tree_portals:node_front_left", {
	tiles = {
		"default_tree.png",
		"default_tree.png",
		"default_tree.png",
		"default_tree.png",
		"default_tree.png",
		"default_tree.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	drop = "tree_portals:tree_portal_root",
	groups = {tree=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
	node_box = {
		type = "fixed",
		fixed = {
			{0.0625, -0.5, 0.375, 0.375, -0.3125, 0.5}, -- NodeBox1
			{0.125, -0.5, 0.3125, 0.3125, -0.375, 0.375}, -- NodeBox2
			{0.0625, -0.5, 0.1875, 0.25, -0.375, 0.3125}, -- NodeBox4
			{-0.375, -0.5, 0.125, 0.1875, -0.4375, 0.1875}, -- NodeBox5
			{-0.1875, -0.5, 0.0625, 0.125, -0.4375, 0.125}, -- NodeBox6
			{-0.125, -0.5, 0, 0.0625, -0.4375, 0.0625}, -- NodeBox7
			{-0.375, -0.5, -0.0625, 0, -0.4375, 0}, -- NodeBox8
			{-0.1875, -0.5, -0.125, -0.0625, -0.4375, -0.0625}, -- NodeBox9
			{-0.5, -0.5, -0.1875, -0.125, -0.4375, -0.125}, -- NodeBox10
			{-0.375, -0.5, -0.25, -0.1875, -0.4375, -0.1875}, -- NodeBox11
			{-0.4375, -0.5, -0.3125, -0.3125, -0.4375, -0.25}, -- NodeBox12
			{-0.375, -0.5, -0.375, -0.3125, -0.4375, -0.3125}, -- NodeBox13
			{-0.3125, -0.5, -0.5, -0.25, -0.4375, -0.375}, -- NodeBox14
			{-0.5, -0.5, -0.4375, -0.4375, -0.4375, -0.3125}, -- NodeBox15
			{0, -0.5, -0.25, 0.0625, -0.4375, -0.0625}, -- NodeBox17
			{0.0625, -0.5, -0.375, 0.125, -0.4375, -0.1875}, -- NodeBox18
			{0.125, -0.5, -0.4375, 0.1875, -0.4375, -0.3125}, -- NodeBox19
			{-0.5, -0.5, 0.1875, -0.3125, -0.4375, 0.25}, -- NodeBox20
		}
	}
})

minetest.register_node("tree_portals:node_front", {
	tiles = {
		"default_tree.png",
		"default_tree.png",
		"default_tree.png",
		"default_tree.png",
		"default_tree.png",
		"default_tree.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	drop = "tree_portals:tree_portal_root",
	groups = {tree=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.4375, -0.375, -0.4375, -0.375}, -- NodeBox1
			{-0.375, -0.5, -0.5, -0.1875, -0.4375, -0.4375}, -- NodeBox2
			{-0.5, -0.5, -0.3125, -0.3125, -0.4375, -0.25}, -- NodeBox3
			{-0.375, -0.5, -0.25, -0.0625, -0.4375, -0.1875}, -- NodeBox4
			{-0.5, -0.5, 0.125, -0.4375, -0.4375, 0.5}, -- NodeBox5
			{-0.4375, -0.5, 0.125, -0.375, -0.4375, 0.25}, -- NodeBox6
			{-0.375, -0.5, 0.25, -0.1875, -0.4375, 0.3125}, -- NodeBox7
			{-0.1875, -0.5, 0.3125, -0.125, -0.4375, 0.4375}, -- NodeBox8
			{-0.125, -0.5, 0.375, -0.0625, -0.4375, 0.5}, -- NodeBox9
			{-0.375, -0.5, 0.0625, -0.1875, -0.4375, 0.125}, -- NodeBox10
			{0.3125, -0.5, 0.1875, 0.5, -0.4375, 0.25}, -- NodeBox11
			{0.0625, -0.5, 0.375, 0.125, -0.4375, 0.5}, -- NodeBox12
			{0.1875, -0.5, 0.25, 0.3125, -0.4375, 0.3125}, -- NodeBox13
			{0.125, -0.5, 0.3125, 0.1875, -0.4375, 0.375}, -- NodeBox14
			{0.3125, -0.5, -0.5, 0.5, -0.4375, -0.4375}, -- NodeBox15
			{0.1875, -0.5, -0.25, 0.5, -0.4375, -0.1875}, -- NodeBox16
			{0.0625, -0.5, -0.1875, 0.25, -0.375, -0.125}, -- NodeBox17
		}
	}
})

minetest.register_node("tree_portals:node_front_right", {
	tiles = {
		"default_tree.png",
		"default_tree.png",
		"default_tree.png",
		"default_tree.png",
		"default_tree.png",
		"default_tree.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	drop = "tree_portals:tree_portal_root",
	groups = {tree=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
	node_box = {
		type = "fixed",
		fixed = {
			{0.375, -0.5, -0.375, 0.5, -0.4375, -0.3125}, -- NodeBox1
			{0.3125, -0.5, -0.3125, 0.4375, -0.4375, -0.25}, -- NodeBox2
			{0.1875, -0.5, -0.25, 0.5, -0.4375, -0.1875}, -- NodeBox3
			{0.125, -0.5, -0.1875, 0.25, -0.4375, -0.125}, -- NodeBox4
			{0.0625, -0.5, -0.125, 0.5, -0.4375, -0.0625}, -- NodeBox5
			{0, -0.5, -0.0625, 0.1875, -0.4375, 0}, -- NodeBox6
			{-0.0625, -0.5, 0, 0.25, -0.4375, 0.0625}, -- NodeBox7
			{-0.125, -0.5, 0.0625, 0.125, -0.375, 0.125}, -- NodeBox8
			{-0.1875, -0.5, 0.125, 0, -0.375, 0.1875}, -- NodeBox9
			{-0.25, -0.5, 0.1875, 0, -0.375, 0.25}, -- NodeBox10
			{-0.25, -0.5, 0.25, -0.0625, -0.375, 0.3125}, -- NodeBox11
			{-0.3125, -0.5, 0.3125, -0.0625, -0.375, 0.375}, -- NodeBox12
			{-0.375, -0.5, 0.375, -0.0625, -0.375, 0.5}, -- NodeBox13
			{0.25, -0.5, 0.0625, 0.4375, -0.4375, 0.125}, -- NodeBox14
			{0.4375, -0.5, 0.125, 0.5, -0.4375, 0.1875}, -- NodeBox15
			{-0.0625, -0.5, 0.4375, 0.25, -0.4375, 0.5}, -- NodeBox16
		}
	}
})

local tree_portal_params =  {
 fuel = "default:tree 1", 
 active_node = "tree_portals:tree_portal",
 portal_groups = {"tree_portals"},
 update_interval = 30.0,
 portal_type = element_portals.OUT_PORTAL, 
 replace_surroundings = {
 	except_nodes_containing_in_name = {"node" },
 	offsets = {
 		-- if unspecified replacement_node_names, air is the default 
 		-- back
 		{pos = {z= -1}, replacement_node_name = "tree_portals:node_front"},
 		{pos = {x=1, z= -1}, replacement_node_name = "tree_portals:node_front_left"},
 		{pos = {x=-1, z= -1}, replacement_node_name = "tree_portals:node_front_right"},
 		-- middle
 		{pos = {x=1}, replacement_node_name = "tree_portals:node_middle_left"},
 		{pos = {x=-1}, replacement_node_name = "tree_portals:node_middle_right"},
 		-- front
 		{pos = {z= 1}, replacement_node_name = "tree_portals:node_back"},
 		{pos = {x=-1, z= 1}, replacement_node_name = "tree_portals:node_back_right"},
 		{pos = {x=1, z= 1}, replacement_node_name = "tree_portals:node_back_left"},
 	}
 }
}

element_portals:register_portal_abm(tree_portal_params)

element_portals:register_private_portal_node("tree_portals:tree_portal", {
	tiles = {
		"default_tree_top.png^tree_portal_sign.png",
		"default_tree.png",
		"default_tree.png",
		"default_tree.png",
		"default_tree.png",
		"default_tree.png"
	},
	drawtype = "nodebox",
	
	paramtype = "light",
	groups = {tree=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.5, -0.4375, 0.4375, -0.375, 0.4375}, -- NodeBox1
			{-0.5, -0.5, -0.3125, -0.4375, -0.375, -0.25}, -- NodeBox2
			{-0.125, -0.5, -0.5, -0.0625, -0.4375, -0.4375}, -- NodeBox3
			{-0.375, -0.375, -0.375, 0.375, -0.3125, 0.375}, -- NodeBox4
			{-0.4375, -0.5, -0.5, -0.375, -0.4375, -0.4375}, -- NodeBox5
			{-0.5, -0.5, -0.4375, -0.4375, -0.4375, -0.375}, -- NodeBox6
			{-0.5, -0.5, 0, -0.4375, -0.375, 0.0625}, -- NodeBox7
			{-0.5, -0.5, 0.1875, -0.4375, -0.4375, 0.25}, -- NodeBox8
			{0.125, -0.5, -0.5, 0.25, -0.4375, -0.4375}, -- NodeBox9
			{0.4375, -0.5, 0.1875, 0.5, -0.4375, 0.4375}, -- NodeBox10
			{0.4375, -0.5, -0.125, 0.5, -0.4375, 0}, -- NodeBox11
			{0.4375, -0.5, -0.375, 0.5, -0.4375, -0.3125}, -- NodeBox12
			{-0.25, -0.5, 0.4375, -0.1875, -0.4375, 0.5}, -- NodeBox13
			{0.1875, -0.5, 0.4375, 0.3125, -0.4375, 0.5}, -- NodeBox14
			{-0.5, -0.5, 0.375, -0.4375, -0.4375, 0.4375}, -- NodeBox15
		}
	}
}, tree_portal_params)

minetest.register_node("tree_portals:node_middle_right", {
	tiles = {
		"default_tree.png",
		"default_tree.png",
		"default_tree.png",
		"default_tree.png",
		"default_tree.png",
		"default_tree.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	drop = "tree_portals:tree_portal_root",
	groups = {tree=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.5, -0.5, -0.3125, -0.375, 0.5}, -- NodeBox1
			{-0.5, -0.5, -0.3125, -0.4375, -0.4375, 0.3125}, -- NodeBox2
			{-0.3125, -0.5, -0.1875, -0.25, -0.4375, 0}, -- NodeBox3
			{-0.25, -0.5, -0.125, 0, -0.4375, 0}, -- NodeBox4
			{0.125, -0.5, -0.1875, 0.3125, -0.4375, -0.0625}, -- NodeBox5
			{0.3125, -0.5, -0.25, 0.5, -0.4375, -0.1875}, -- NodeBox6
			{0.3125, -0.5, -0.125, 0.4375, -0.375, -0.0625}, -- NodeBox7
			{0.4375, -0.5, -0.0625, 0.5, -0.4375, 0}, -- NodeBox8
			{-0.125, -0.5, -0.1875, 0.125, -0.4375, -0.125}, -- NodeBox9
			{0, -0.5, 0, 0.125, -0.4375, 0.0625}, -- NodeBox10
			{0.125, -0.5, 0.0625, 0.3125, -0.4375, 0.125}, -- NodeBox11
			{0.3125, -0.5, 0.125, 0.5, -0.4375, 0.1875}, -- NodeBox12
			{-0.3125, -0.5, -0.5, -0.25, -0.375, -0.375}, -- NodeBox13
			{-0.3125, -0.5, 0.125, -0.25, -0.3125, 0.5}, -- NodeBox14
			{-0.25, -0.5, 0.3125, -0.1875, -0.3125, 0.5}, -- NodeBox15
			{-0.4375, -0.375, 0, -0.3125, -0.3125, 0.5}, -- NodeBox16
			{0.125, -0.5, -0.5, 0.375, -0.4375, -0.4375}, -- NodeBox17
			{0.375, -0.5, -0.4375, 0.5, -0.4375, -0.375}, -- NodeBox18
			{0.3125, -0.5, 0.375, 0.4375, -0.4375, 0.5}, -- NodeBox19
			{0.375, -0.5, 0.3125, 0.5, -0.4375, 0.375}, -- NodeBox20
		}
	}
})

minetest.register_node("tree_portals:node_back_right", {
	tiles = {
		"default_tree.png",
		"default_tree.png",
		"default_tree.png",
		"default_tree.png",
		"default_tree.png",
		"default_tree.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	drop = "tree_portals:tree_portal_root",
	groups = {tree=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.375, -0.5, -0.5, -0.125, -0.375, -0.375}, -- NodeBox1
			{-0.3125, -0.5, -0.375, 0.0625, -0.375, -0.3125}, -- NodeBox2
			{-0.25, -0.5, -0.3125, 0.1875, -0.375, -0.1875}, -- NodeBox3
			{-0.1875, -0.5, -0.1875, 0, -0.375, -0.125}, -- NodeBox4
			{-0.125, -0.5, -0.125, 0.5, -0.375, -0.0625}, -- NodeBox5
			{-0.0625, -0.5, -0.0625, 0.125, -0.375, 0}, -- NodeBox6
			{0, -0.5, 0, 0.25, -0.375, 0.0625}, -- NodeBox7
			{0.0625, -0.5, 0.0625, 0.3125, -0.4375, 0.125}, -- NodeBox8
			{0.125, -0.5, 0.125, 0.5, -0.375, 0.1875}, -- NodeBox9
			{0.25, -0.5, 0.1875, 0.375, -0.375, 0.25}, -- NodeBox10
			{0.3125, -0.5, 0.25, 0.5, -0.375, 0.3125}, -- NodeBox15
			{0.375, -0.5, 0.3125, 0.5, -0.375, 0.375}, -- NodeBox16
			{0.125, -0.5, -0.4375, 0.3125, -0.375, -0.3125}, -- NodeBox13
			{0.3125, -0.5, -0.5, 0.4375, -0.375, -0.4375}, -- NodeBox14
			{0.3125, -0.5, -0.4375, 0.4375, -0.4375, -0.375}, -- NodeBox1008
			{0.375, -0.5, -0.1875, 0.5, -0.4375, -0.125}, -- NodeBox20
		}
	}
})

minetest.register_node("tree_portals:node_back", {
	tiles = {
		"default_tree.png",
		"default_tree.png",
		"default_tree.png",
		"default_tree.png",
		"default_tree.png",
		"default_tree.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	drop = "tree_portals:tree_portal_root",
	groups = {tree=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.3125, -0.375, -0.4375, 0.4375}, -- NodeBox1
			{-0.375, -0.5, 0.25, -0.1875, -0.4375, 0.375}, -- NodeBox2
			{-0.5, -0.5, 0, -0.25, -0.4375, 0.0625}, -- NodeBox3
			{-0.5, -0.5, -0.25, -0.4375, -0.4375, -0.1875}, -- NodeBox4
			{-0.4375, -0.5, -0.3125, -0.3125, -0.375, -0.25}, -- NodeBox5
			{-0.3125, -0.5, -0.5, -0.25, -0.4375, -0.3125}, -- NodeBox6
			{-0.1875, -0.5, 0.1875, 0, -0.4375, 0.25}, -- NodeBox7
			{-0.3125, -0.5, -0.0625, -0.125, -0.4375, 0}, -- NodeBox8
			{-0.25, -0.5, -0.3125, -0.0625, -0.4375, -0.25}, -- NodeBox9
			{-0.5, -0.5, 0.0625, -0.4375, -0.375, 0.125}, -- NodeBox10
			{-0.1875, -0.5, 0.375, 0.0625, -0.4375, 0.4375}, -- NodeBox11
			{0.3125, -0.5, 0.3125, 0.5, -0.4375, 0.375}, -- NodeBox12
			{0.125, -0.5, 0.25, 0.3125, -0.4375, 0.3125}, -- NodeBox13
			{0.25, -0.5, -0.1875, 0.5, -0.4375, -0.125}, -- NodeBox14
			{0.125, -0.5, -0.5, 0.1875, -0.4375, -0.25}, -- NodeBox15
			{0.1875, -0.5, -0.25, 0.25, -0.4375, -0.1875}, -- NodeBox16
			{0.3125, -0.5, -0.5, 0.5, -0.375, -0.4375}, -- NodeBox17
		}
	}
})


minetest.register_abm({
		nodenames = {"tree_portals:node_back", "tree_portals:node_back_left", "tree_portals:node_back_right", "tree_portals:node_front", "tree_portals:node_front_left", "tree_portals:node_front_right", "tree_portals:node_middle_left", "tree_portals:node_middle_right"} ,
		interval = 15,
		chance = 1,
		action = function(pos, node, active_object_count, active_object_count_wider)	
			local nodes_in_range =  element_portals:node_in_square_range(pos, "tree_portals:tree_portal", 1, "x", "z")
			if nodes_in_range.count == 0 then
				minetest.set_node(pos, {name="air"})			
			end 
		end
	})

minetest.register_node("tree_portals:tree_portal_root", {
		description = "Tree portal root ",
		tiles = {"tree_root.png"},
		drawtype = "plantlike",
		visual_scale = 1.0,
		portal_type = element_portals.OUT_PORTAL ,
		tiles = {"tree_root.png"},
		inventory_image = "tree_root.png",
		wield_image = "tree_root.png",
		paramtype = "light",
		walkable = false,
		is_ground_content = true,
		selection_box = {
			type = "fixed",
			fixed = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3}
		},
		groups = {tree=1,choppy=2,oddly_breakable_by_hand=1,flammable=2}
	})

minetest.register_abm({
		nodenames = {"tree_portals:tree_portal_root"} ,
		interval = 15,
		chance = 3,
		action = function(pos, node, active_object_count, active_object_count_wider)	
			minetest.set_node(pos, {name="default:sapling"})			 
		end
	})

minetest.register_on_placenode(function(pos, newnode, placer, oldnode, itemstack, pointed_thing)
    if newnode.name == "tree_portals:tree_portal_root" then
    	element_portals:show_item_portal_form(placer, "tree_portals")
	end
end)

minetest.register_craft({
	output = 'tree_portals:tree_portal',
	recipe = {
		{'default:sapling', 'dye:green', 'default:sapling'},
		{'default:sapling', 'default:tree', 'default:sapling'},
		{'default:sapling', 'default:sapling', 'default:sapling'}
	}
})



