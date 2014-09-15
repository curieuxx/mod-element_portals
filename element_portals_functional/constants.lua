--[[

Constants used by the mods in this modpack

Copyright 2014 Tiberiu CORBU
Authors: Tiberiu CORBU

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
--]]

if not element_portals then
	element_portals = {}
end

-- portal types
element_portals.UNKNOWN_PORTAL = -1

element_portals.IN_PORTAL = 1
element_portals.OUT_PORTAL = 2
element_portals.IN_OUT_PORTAL = 3


-- actions 
element_portals.VOID_ACTION = -2

element_portals.REMOVE_PORTAL_ACTION = 4
element_portals.TELEPORT_ACTION = 5
element_portals.ACTIVATE_ACTION = 6
element_portals.DEACTIVATE_ACTION = 7
element_portals.SUCCESFUL_NODE_REPLACE_ACTION = 8

--sformspec

element_portals.PORTAL_FORM_NAME = "element_portals:portal_form"

