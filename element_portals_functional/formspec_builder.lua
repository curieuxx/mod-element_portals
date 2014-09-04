if not element_portals then
	element_portals = {}
end

----------------------- Form buider methods
local build_portal_list = function(portals, this_portal_key, selected_portal_name, portal_group)
	local list = ""
	local k
	local v
	local selected_index = 1 -- first by default
	local count = 0 
	for k,v in pairs(portals) do
		local registered = element_portals:is_registered_out_portal(v.node_name, portal_group)
		if this_portal_key ~= k and registered then	
			if v.portal_name == selected_portal_name then
			 	selected_index = count+1
			end
			list = list..v.portal_name..","
			count = count + 1
		end
	end
	-- remove the last comma because it adds an empty item into the list,
	-- handled here since lua doensn't have (I dont't know) a cheap count
	-- table method
	if count > 0 then
		list = string.sub(list, 0, -2) 
	end
	return {list=list, selected_index = selected_index}
end

local append_user_inventory_form_fields = function(result, pos)
	local spos = pos.x .. "," .. pos.y .. "," ..pos.z
	result = result.."list[nodemeta:".. spos .. ";fuel;6,3;1,1;]"..
		"list[current_player;main;0,5;8,4;]"
	return result
end

local append_current_portal_form_fields = function(result, key ,data)
	-- the ones with minus sign are supposed to be hidden
	result = result.."field[0.3,1;4,1;portal_name;This portal Name:;"..data.portal_name.."]"
	result = result.."field[-6,1;4,1;portal_key;This portal key:;"..key.."]"
	result = result.."field[-7,1;4,1;portal_pos;This portal pos:;"..minetest.pos_to_string(data.pos).."]"
	return result
end

local append_active_input_portal_fields = function(result, portals, key, data, selected_portal_name)
	local portal_filter_group = element_portals:get_portal_filter_group(data.portal_node)
	local list_result = build_portal_list(portals, key, selected_portal_name, portal_filter_group);
	result = result.."dropdown[0,2;5;selected_portal_name;"..list_result.list..";"..list_result.selected_index.."]"
	result = result.."button_exit[0,3;5,1;teleport;Teleport]" 
	return result
end

local append_travel_free_fields = function(result)
	result = result.."field[-8,1;4,1;travel_free;Travel Free:;true]"
	return result
end 

-- end form builder methods 

function element_portals:create_portal_formspec(pos, player, selected_portal_name, active, message)
	local portals = element_portals:read_player_portals_table(player)
	local this_portal_key = element_portals:construct_portal_id_key(pos, player)
	local this_portal_data = portals[this_portal_key]
	local portal_name = this_portal_data.portal_name
	local portal_node = this_portal_data.node_name
	local result = append_current_portal_form_fields( "size[8,9]", this_portal_key, this_portal_data)
	local result = append_user_inventory_form_fields(result, pos)
	if active then
		result = append_active_input_portal_fields(result, portals,  this_portal_key, this_portal_data, selected_portal_name)	
	else
		result = result.."label[0,2;Add natural element to power the portal]"
	end 
	
	if message then
		result = result.."label[0,4;"..message.."]"		
	end
	return result
end

function element_portals:create_fuel_surrounds_portal_formspec(pos, player, selected_portal_name, message)
	local portals = element_portals:read_player_portals_table(player)
	local this_portal_key = element_portals:construct_portal_id_key(pos, player)
	local this_portal_data = portals[this_portal_key]
	local result = append_current_portal_form_fields("size[5,4]", this_portal_key, this_portal_data)
	result = append_travel_free_fields(result)
	result = append_active_input_portal_fields(result, portals, this_portal_key, this_portal_data, selected_portal_name)	
	if message then
		result = result.."label[0,4;"..message.."]"
	end
	return result
end

function element_portals:create_out_portal_formspec(pos, player, selected_portal_name, message)
	local portals = element_portals:read_player_portals_table(player)
	local this_portal_key = element_portals:construct_portal_id_key(pos, player)
	local this_portal_data = portals[this_portal_key]
	local result = append_current_portal_form_fields("size[5,2]", this_portal_key, this_portal_data)
	return result
end

function element_portals:create_item_portal_formspec(player, portal_group, message)
	local portals = element_portals:read_player_portals_table(player)
	-- the ones with minus sign are supposed to be hidden
	local result = "size[5,2]"
		local list_result = build_portal_list(portals, nil, nil, portal_group)
		result = result.."dropdown[0,0;5;selected_portal_name;"..list_result.list..";"..list_result.selected_index.."]"
		result = result.."button_exit[0,1;5,1;teleport;Teleport]"
		result = result.."field[-8,1;4,1;travel_free;Travel Free:;true]"
	return result
end
