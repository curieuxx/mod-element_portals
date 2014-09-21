--[[

Bootstraping of this mod

Copyright 2014 Tiberiu CORBU
Authors: Tiberiu CORBU

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
--]]

local MOD_NAME = minetest.get_current_modname()

dofile(minetest.get_modpath(MOD_NAME).."/util.lua")

dofile(minetest.get_modpath(MOD_NAME).."/constants.lua")

dofile(minetest.get_modpath(MOD_NAME).."/node_box_library.lua")

dofile(minetest.get_modpath(MOD_NAME).."/portal_data_api.lua")

dofile(minetest.get_modpath(MOD_NAME).."/privilege.lua")

dofile(minetest.get_modpath(MOD_NAME).."/sound_api.lua")

-- forms manip.
dofile(minetest.get_modpath(MOD_NAME).."/formspec_builder.lua")
dofile(minetest.get_modpath(MOD_NAME).."/form.lua")
dofile(minetest.get_modpath(MOD_NAME).."/form_input_handeling.lua")

dofile(minetest.get_modpath(MOD_NAME).."/portals_service.lua")
dofile(minetest.get_modpath(MOD_NAME).."/portal_node_builder.lua")
dofile(minetest.get_modpath(MOD_NAME).."/node_api.lua")
