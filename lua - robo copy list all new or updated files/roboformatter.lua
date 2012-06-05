input = io.open("ROBO-COMMON.LOG", "r")
output = "" --io.open("output.txt", "w")
prevline = ""
lastnumline = ""
getoutputname = true

--[[
limit = 500
i = 1
--]]

function testline(l)
	if string.find(l, '^%s*%d') or string.find(l, 'New Dir') then
		return true
	else
		return false
	end
	-- original function:
	--return string.find(l, '^%s*%d')
end

function getfilepath(l)
	return string.match(l, '(h:.+\\).*$') or ""
end

function getfilename(l)
	l = string.match(l, '\t.*\t~?%$?(.+)')
	return l or ""
end

function openoutput(l)
	local file, msg = true, nil
	l = string.match(l, ':%s(.*)')
	l = string.gsub(l, ':', '.')
	l = "RoboLog from "..l..".txt"

	repeat -- check file existence until a file does not exist with that name
		file, msg = io.open(l, "r")
		if file then
			io.close(file)
			l = "1 - "..l
		end
	until not file

	output = io.open(l, "w")

	--[[ -- first attempt at the above repeat section - did not work
	while true do
		local f = io.open(l, "r")
		if f ~= nil then
			io.close(f)
			l = "1 - "..l
		else
			io.close(f)
			break
		end
	end
	]]
end

while true do
	local line = input:read()
	if line == nil then break end

	local prevtest = testline(prevline)
	local linetest = testline(line)

	if not linetest and not string.find(line, '^%s*$') then

		local filename = getfilename(line)
		local filepath = nil

		if prevtest then
			filepath = getfilepath(prevline)
		else
			filepath = getfilepath(lastnumline)
		end

		if filename ~= nil and filename ~= "" then
			output:write(filepath.."\t"..filename.."\n")
			--print(filepath.."\t"..filename.."\n")
		end
	else
		-- don't print the line
	end

	if getoutputname and string.find(line, 'Started') then
		openoutput(line)
		getoutputname = false -- don't open another file
	end

	if not linetest and prevtest then
		lastnumline = prevline
	end

	prevline = line

	--[[
	i = i + 1
	if i > limit then
		break
	end
	--]]
end
