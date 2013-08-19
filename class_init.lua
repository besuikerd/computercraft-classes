local path_settings = "class_settings"
local path_api = "class"

local url_repo = "https://github.com/besuikerd/computercraft-classes/raw/master/"

local files = {
	{name = "settings", path = "class_settings", file = "class_settings.lua"},
	{name = "classes", path = "classes", file = "classes.lua"},
	{name = "test", path = "class_test", file = "class_test.lua"},
}

--load necessary files
for i, file in ipairs(files) do
	io.write(string.format("downloading %s...", file.name))
	local handle = fs.open(file.path, "w")
	local url = string.format("%s/%s", url_repo, file.file)
	local request = http.get(url)
	if not request then error(string.format("%s not found", url)) end
	handle.write(request.readAll())
	handle.close()
	print(" done!")
end


