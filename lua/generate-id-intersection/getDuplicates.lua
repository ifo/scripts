input = io.open("list-flipped.txt", "r")



local list = {}
local currentTable = ""
local file = ""

function isTable(text)
	if text:find('AD_HOC_') ~= nil then return true else return false end
end

function removeAdHoc(text)
	return text:match('^AD_HOC_(.+)')
end

---[[
while true do
	local line = input:read()
	if line == nil then break end

	if line ~= '' then
		if isTable(line) then
			currentTable = line
		else
			if list[line] == nil then
				list[line] = {}
				table.insert(list[line], removeAdHoc(currentTable))
			else
				table.insert(list[line], removeAdHoc(currentTable))
			end
		end
	end
end
--]]

for key, value in pairs(list) do
	if #value ~= 1 then

		file = file .. key .. '\t' .. table.concat(value, '\t') .. '\n'
	end
end

---[[
output = io.open("duplicates.txt", "w")
output:write(file)
--]]
--print(file)
