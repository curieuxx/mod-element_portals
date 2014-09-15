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
