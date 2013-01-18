input = io.open("list.txt", "r")

output = io.open("list-flipped.txt", "w")

local text = {}

while true do
	local line = input:read()
	if line == nil then break end

	table.insert(text, line)
end

for i = #text, 1, -1 do
	output:write(text[i]..'\n')
end
