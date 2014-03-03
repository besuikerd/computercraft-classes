local path_settings = "class_settings"
local path_api = "class"

local url_repo = "https://raw.github.com/besuikerd/computercraft-classes/master"

local files = {
	{name = "repos", path = "class_repos", file = "class_repos.lua"},
	{name = "classes", path = "classes", file = "classes.lua"},
	--{name = "command", path = "commander", file = "command/commander.lua"}, not using this atm
	{name = "load", path = "load", file="programs/load.lua"},
	{name = "reload", path = "reload", file="programs/reload.lua"},
	{name = "superlua", path = "superlua", file="programs/superlua.lua"},
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



os.loadAPI("classes")
