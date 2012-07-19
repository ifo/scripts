input = io.open("STATES.txt", "r")
output = io.open("varStateList.txt", "w")
while true do
	local line = input:read()
	if line == nil then break end
	local shortName, name, id = string.match(line, '\t(%a%a)\t(.-)%s*\t(%d*)')
	-- works now, by magically using - instead of *

	-- the above is not fully working yet, still need to remove trailing spaces of name

	--name = string.match(name, '(.*)')

	--local name = string.match(string.match(line, '%a%a\t[,%a .&]+'), '[,%a .&]+')
	--local name = string.match(line, "%a%a\t[%a]+")
	--name = string.match(name, "\t[%a]+")
	--name = string.match(name, "%a+")
	--local id = string.match(line, "[^%a]%d+")
	--id = string.match(id, "%d+")
	output:write('new State { Name="'..name..'", ShortName="'..shortName..'", CountryID='..id..' },', "\n")
	--print('new State { Name="'..name..'", ShortName="'..shortName..'", CountryID="'..id..' },')

	--print(shortName, name, id)
end
