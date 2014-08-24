if not element_portals then
	element_portals = {}
end

local build_portal_list = function(portals, this_portal_key, selected_portal_name)
	local list = ""
	local k
	local v
	local selected_index = 0
	local count = 0 
	for k,v in pairs(portals) do
		if this_portal_key ~= k then	
			if v.portal_name == selected_portal_name then
			 	selected_index = count+1
			end
			list =list..v.portal_name..","
			count = count + 1
		end
	end
	return {list= list, selected_index = selected_index}
end

function element_portals:create_portal_formspec(pos, player, selected_portal_name, active, message)
	local portals = element_portals:read_player_portals_table(player)
	local this_portal_key = element_portals:construct_portal_id_key(pos, player)
	local portal_name = "" 
	if portals[this_portal_key] then 
		portal_name = portals[this_portal_key].portal_name
	end
	
	-- the ones with - sign are supposed to be hidden
	local spos = pos.x .. "," .. pos.y .. "," ..pos.z
	local result = "size[8,9]"..
		"field[0.3,1;4,1;portal_name;This portal Name:;"..portal_name.."]button[4,0.7;1,1;set;set]"..
		"list[nodemeta:".. spos .. ";fuel;6,3;1,1;]"..
		"list[current_player;main;0,5;8,4;]"..
		"field[-6,1;4,1;portal_key;This portal key:;"..this_portal_key.."]"..
		"field[-7,1;4,1;portal_pos;This portal pos:;"..minetest.pos_to_string(pos).."]"
	
	if active then
		local list_result = build_portal_list(portals, this_portal_key, selected_portal_name);
		result = result.."dropdown[0,2;5;selected_portal_name;"..list_result.list..";"..list_result.selected_index.."]"
		result = result.."button_exit[0,3;5,1;teleport;teleport]"
	else
		result = result.."label[0,2;Add natural element to power the portal]"
	end 
	
	if message then
		result = result.."label[0,4;"..message.."]"		
	end
	
	return result
end


function element_portals:show_portal_form(pos ,clicker, message)
	local meta = minetest.get_meta(pos)
	
	if element_portals:has_private_portal_privilege(meta, clicker) then
		local selected_portal_name = meta:get_string("selected_portal_name")
		minetest.show_formspec(
			clicker:get_player_name(),
			"element_portals:portal_form",
			element_portals:create_portal_formspec(pos, clicker, selected_portal_name, element_portals:is_portal_powered(meta), message)
		)
	end
end

local handle_update = function(player, fields, meta)
    if fields["selected_portal_name"] and meta then
    	meta:set_string("selected_portal_name", fields["selected_portal_name"] or "")
    end
	if fields["portal_name"] and fields["portal_key"] then
		portal_name =  element_portals:update_portal_name(player, fields["portal_key"], fields["portal_name"])
		if meta and portal_name then
			meta:set_string("infotext", "Portal ".. portal_name .." (owned by "..meta:get_string("owner")..")")
		end
	end
end

function string_starts(str,start)
   return string.sub(str,1,string.len(start))==start
end


function element_portals:consume_fuel(meta, player)
	local inv = meta:get_inventory()
	local fuel_stack = meta:get_string("fuel_stack")
	
	if inv:contains_item("fuel", fuel_stack) then
		-- exception for bucket with water, lava or anything else - be god and just empty the bucket
		
		local take_stack = ItemStack(fuel_stack)
		
		local inv_list = inv:get_list("fuel");
		local inv_stack = inv_list[1];
		-- 						   ^ - magic number that works
		inv_stack:take_item(take_stack:get_count())
		-- mintest support about stacks is poor documented -- any simple solution ?  
		if string_starts(fuel_stack, "bucket:bucket") and inv_stack:get_count() == 0 then
			inv:set_list("fuel", {"bucket:bucket_empty 1"}) 
		else 
			inv:set_list("fuel", {inv_stack})
		end	 
		return true
	else 
		return false
	end
end

local handle_teleport = function(player, fields, meta)
	if fields["teleport"] == "teleport" then
		if fields["selected_portal_name"] and fields["teleport"] == "teleport" then
			local portals = element_portals:read_player_portals_table(player)
			for k,v in pairs(portals) do
					if v.portal_name == fields["selected_portal_name"] then
						-- double check here because ... because fuck you
						consume_result = element_portals:consume_fuel(meta, player)
						if consume_result then
							v.pos.y  = v.pos.y + 1
							player:setpos(v.pos)
						end
						return
					end
			end
		end
	end
end

local retrieve_meta = function(fields)
	local meta
	if fields["portal_pos"]  then
		local pos = minetest.string_to_pos(fields["portal_pos"])
		if (pos) then 
			meta = minetest.get_meta(pos)
		end
	end
	return meta
end

minetest.register_on_player_receive_fields(function(player,formname,fields)
	if formname ~= "element_portals:portal_form" then 
		return
	end
	local meta  = retrieve_meta(fields)
	handle_update(player,fields, meta)
	if meta and fields['quit'] then
		handle_teleport(player, fields, meta) 
	end
end)
