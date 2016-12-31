--[[ Old recipe
minetest.register_craft({
	output = 'liquid_portals:water_portal',
	recipe = {
		{'default:steel_ingot', 'default:mese_crystal_fragment', 'default:steel_ingot'},
		{'default:mese_crystal_fragment', 'bucket:bucket_water', 'default:mese_crystal_fragment'},
		{'default:steel_ingot', 'default:mese_crystal_fragment', 'default:steel_ingot'}
	}
})
--]]

-- Accept all kind of water
minetest.register_craft({
	output = 'liquid_portals:water_portal',

	recipe = {
		{'default:steel_ingot', 'default:mese_crystal_fragment', 'default:steel_ingot'},
		{'default:mese_crystal_fragment', 'group:water_bucket', 'default:mese_crystal_fragment'},
		{'default:steel_ingot', 'default:mese_crystal_fragment', 'default:steel_ingot'}
	}
})	

minetest.register_craft({
	output = 'liquid_portals:lava_portal',
	recipe = {
		{'default:steel_ingot', 'default:mese_crystal_fragment', 'default:steel_ingot'},
		{'default:mese_crystal_fragment', 'bucket:bucket_lava', 'default:mese_crystal_fragment'},
		{'default:steel_ingot', 'default:mese_crystal_fragment', 'default:steel_ingot'}
	}
})
