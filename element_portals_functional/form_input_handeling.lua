--[[

Handle portal form submission functions, creates a bridge between the variables received the form and the "service" functions. 

Copyright 2014 Tiberiu CORBU
Authors: Tiberiu CORBU

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
--]]
-- Namespace
if not element_portals then
	element_portals = {}
end

-- 
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

local handle_teleport = function(player, fields, meta_and_pos)
	if fields["selected_portal_name"] and fields["teleport"] == "Teleport" then
		local selected_portal_name = fields["selected_portal_name"]
		local travel_free = fields["travel_free"] == "true"
		element_portals:teleport_to(selected_portal_name, player, travel_free, meta_and_pos)
	end
end

local retrieve_meta_and_pos = function(fields)
	local result
	if fields["portal_pos"]  then
		local pos = minetest.string_to_pos(fields["portal_pos"])
		if pos then 
			result = {meta = minetest.get_meta(pos), pos = pos}
		end
	end
	return result
end

function element_portals:update_portal_name(player, portal_key, new_name)
	if not player or not portal_key or not new_name then
			return
	end
    local player_name = player:get_player_name()
	local portals = element_portals:read_player_portals_table(player)
	
	if portals[portal_key] then
		
		local old_name = portals[portal_key].portal_name;
		-- not changed
		if old_name == new_name then
			return old_name
		end
		local message = ""
		local revert = false
		if new_name == "" then
			message = "No portal name was specified, reverting to "..old_name
			minetest.chat_send_player(player_name, message)
			element_portals:show_name_portal_form(portals[portal_key].pos, player, message)
			return old_name
		end 
		for k,v in pairs(portals) do
			if portal_key ~= k then
				if v.portal_name == new_name then
					message = "You own another portal with the name ".. new_name .." at "..  minetest.pos_to_string(v.pos) ..", reverting to "..old_name
					minetest.chat_send_player(player_name, message)
					element_portals:show_name_portal_form(portals[portal_key].pos, player, message)
					return old_name
				end
			end
		end
		portals[portal_key].portal_name = new_name
		element_portals:write_player_portals_table(player, portals)
		return new_name;
	end
end


minetest.register_on_player_receive_fields(function(player,formname,fields)
	if formname ~= element_portals.PORTAL_FORM_NAME then 
		return
	end
	local meta_and_pos  = retrieve_meta_and_pos(fields)
	if meta_and_pos then
		handle_update(player, fields, meta_and_pos.meta)
	end
	if fields['quit'] then
		handle_teleport(player, fields, meta_and_pos) 
	end
end)
