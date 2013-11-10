input = io.open("input.txt", "r")

output = io.open("output.txt", "w")

local thing = 0

function removeQuotes(s)
  return (s:gsub('""', ''))
end

while true do
	local line = input:read()
	if line == nil then break end

	output:write(removeQuotes(line) .. '\n')
end
