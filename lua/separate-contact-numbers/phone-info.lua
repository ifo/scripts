input = io.open("phone-info.txt", "r")

local condition = [[Starting up database]]
--[[
-- previous conditions ->
--	"SSPI"
--]]

local findbool = true

output = io.open("office-phones.txt", "w")

local thing = 0

function trim(s)
  return (s:gsub("^%s*(.-)%s*$", "%1"))
end

while true do
	local line = input:read()
	if line == nil then break end

	local outputline, officephone, officefax, cellphone  = '','','',''

	-- get office phone
	if string.find(line, "Office phone:") then
		officephone = string.match(line, "Office phone:(.+)")
		if string.find(officephone, "[OC]") then
			officephone = string.match(officephone, "^%s?(.+)%s[OC].+")
		end
		if officephone then
			outputline = outputline .. trim(officephone)
		end
	end

	-- get office fax
	if string.find(line, "Office fax:") then
		officefax = string.match(line, "Office fax:(.+)")
		if string.find(officefax, "[OC]") then
			officefax = string.match(officefax, "^%s?(.+)%s[OC].+")
		end
		outputline = outputline .. ',' .. trim(officefax)
	else
		outputline = outputline .. ','
	end
	
	-- get cell phone
	if string.find(line, "Cell phone:") then
		cellphone = string.match(line, "Cell phone:(.+)")
		if string.find(cellphone, "[OC]") then
			cellphone = string.match(cellphone, "^%s?(.+)%s[OC].+")
		end
		outputline = outputline .. ',' .. trim(cellphone)
	else
		outputline = outputline .. ','
	end

	--print(officephone or ',')
	if outputline then
		output:write(outputline .. '\n')
	else
		output:write('\n')
	end
	--]]

	thing = thing + 1
end

print(thing)
