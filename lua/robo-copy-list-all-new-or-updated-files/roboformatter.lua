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
	return filenameblacklist(l) or ""
end

function filenameblacklist(l)
	if l == nil then
		return ""
	end
	flag = true

	fileblacklist = {"Thumbs.db"}
	if string.find(l, "Thumbs.db") then
		return ""
	end

	fileend = string.match(l, '.+([.].-)$')
	if fileend ~= nil then
		fileend = string.lower(fileend)
	else
		return ""
	end
	--return fileend
	--print(fileend,l)

	filetypeblacklist = {
		".jpeg",
		".jpg",
		".ds_store",
		".lnk",
		".pdf",
		".tif",
		".tmp",
		".img",
		".png",
		".bmp",
		".mpg",
		".mp4",
		".mov",
		".thm",
		".trashes",
		".wma",
		".ico"
	}
	for i,v in ipairs(filetypeblacklist) do
		if fileend == v then
			flag = false
			break
		end
	end

	if flag then
		return l
	else
		return ""
	end
end

function openoutput(l)
	local file, msg = true, nil
	l = string.match(l, ':%s(.*)')
	l = string.gsub(l, ':', '.')
	l = "RoboLog from "..l..".txt"

	try = l
	num = 1
	repeat -- check file existence until a file does not exist with that name
		file, msg = io.open(try, "r")
		if file then
			io.close(file)
			try = num.." - "..l
		end
		num = num + 1
	until not file

	output = io.open(try, "w")
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
			--output:write(string.match(filename, '.+([.].-)$').."\t"..filename.."\n")
			--print(filepath.."\t"..filename)
			--print(filename)
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
