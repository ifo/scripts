input = io.open("COUNTRY.txt", "r")
output = io.open("varCountryList.txt", "w")
while true do
	local line = input:read()
	if line == nil then break end
	--[[
	local thing = string.match(line, '[,%a .&]+')
	output:write('new Country { Name="'..thing..'" },', "\n")
	--print('new Country { Name="'..thing..'" },')
	]]
	local thing = string.match(string.match(line, '\t"?(.*)'), '[^"]*')
	-- gets all characters after the first tab
	print(thing)
	--output:write('new Country { Name="'..thing..'" },', "\n")
end
