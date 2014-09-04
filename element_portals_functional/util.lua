if not element_portals then
	element_portals = {}
end

function element_portals:tablelength(table)
  local count = 0
  for _ in pairs(table) do count = count + 1 end
  return count
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
