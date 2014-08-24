if not element_portals then
	element_portals = {}
end

function element_portals:tablelength(table)
  local count = 0
  for _ in pairs(table) do count = count + 1 end
  return count
end
