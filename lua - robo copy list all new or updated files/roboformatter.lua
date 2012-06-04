input = io.open("input.txt", "r")
output = io.open("output.txt", "w")
prevline = ""
lastnumline = ""

function testline(l)
	return string.find(l, '^%s*%d')
end

function getfilepath(l)
	return string.match(l, '(h:.+\\).*$') or ""
end

function getfilename(l)
	l = string.match(l, '\t.*\t~?%$?(.+)')
	--l = string.match(l, '~?%$?(.+)')
	return l or ""
end

while true do
	local line = input:read()
	if line == nil then break end

	--local lout = nil

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
			output:write(filepath..filename.."\n\n")
		end
		--[[


		if prevtest then
			--print(prevline.."\n"..line)
		else
			--print(lastnumline.."\n"..line)
		end


		print(getfilepath(prevline)..getfilename(line))
		]]
	else
		--print(prevline.."\n" .. line)
		--print(line)
	end

	if not linetest and prevtest then
		lastnumline = prevline
	end

	prevline = line
	--output:write(lout)
end
