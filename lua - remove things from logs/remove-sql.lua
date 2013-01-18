input = io.open("sqllogs.txt", "r")

local condition = [[Starting up database]]
--[[
-- previous conditions ->
--	"SSPI"
--]]

local findbool = true

output = io.open("log" .. condition .. ".txt", "w")

---[[
while true do
	local line = input:read()
	if line == nil then break end

	if findbool then
		if line:find(condition) then
			--print(line)
			output:write(line..'\n')
		end
	else
		if not line:find(condition) then
			--print(line)
			output:write(line..'\n')
		end
	end
	--[[
	--print (condition, findbool)
	if line:find(condition) then
		if findbool then
			print(line)
			--output:write(line..'\n')
		end
	else

	end
	--]]
end
--]]
