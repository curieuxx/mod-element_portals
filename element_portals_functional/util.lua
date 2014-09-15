--[[

Utility methods

Copyright 2014 Tiberiu CORBU
Authors: Tiberiu CORBU

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
--]]

if not element_portals then
	element_portals = {}
end

function element_portals:tablelength(table)
  local count = 0
  for _ in pairs(table) do count = count + 1 end
  return count
end

function element_portals:string_starts(str,start)
   return string.sub(str,1,string.len(start))==start
end

function element_portals:contains_any(str, values)
	if values then
		for i, value in pairs(values) do
			if value and string.find(str, value) then 
				return true
			end
		end
	end
	return false
end


function element_portals:deep_copy(from)
   return minetest.deserialize(minetest.serialize(from))
end
