input = io.open("ad-hocs.txt", "r")


output = io.open("list.txt", "w")

local list = {}
local pattern = [[.+%[(.+)%]$]]

function gettext(text, pattern)
	return string.match(text, pattern)
	--return string.lower(string.match(text, pattern) or '')
end

while true do
	local line = input:read()
	if line == nil then break end

	--print(string.match(line,pattern))
	---[[
	local returned = gettext(line, pattern)
	if returned ~= nil then
		--if returned:find('_') then print(returned) end
		output:write(returned .. '\n')
	else
		--print("\n")
		output:write('\n')
	end
	--]]
end
