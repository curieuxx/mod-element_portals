--[[

Sound related functions

Copyright 2014 Tiberiu CORBU
Authors: Tiberiu CORBU

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
--]]

if not element_portals then
	element_portals = {}
end

function element_portals:play_node_action_sound(action, node_name, player)
 local portal_params = element_portals.registered_portals[node_name]
 if player and portal_params and portal_params.sounds then  
 	local _, v
 	for _, v in pairs(portal_params.sounds) do
 		if v.action == action and v.sound then
 			minetest.sound_play(v.sound,{to_player = player:get_player_name()})
 			break
 		end 
 	end
 end
end

function element_portals:play_action_sound_at_pos(pos, action, sounds)
	local _, v
	for _, v in pairs(sounds) do
 		if v.action == action and v.sound then
 			minetest.sound_play(v.sound,{pos = pos, max_hear_distance = 30})
 			break
 		end 
 	end
end
