--load settings
local handle = fs.open("class_repos", "r")
_G["__class_repos"] = textutils.unserialize(handle.readAll())
handle.close()

___Class = nil

--class prototype
___Class = {
	
	__index = function(table, key) 
		return ___Class[key]
	end,
	
	--class constructor
	__construct = function() end,
	
	--new instance
	new = function(self, ...)
		local instance = {}
		
		--inherit ___Instance keys
		setmetatable(instance, ___Instance)
		
		--attach class reference to instance		
		instance.__cls = self

		--call constructor method
		instance:__construct(...)
		
		return instance
	end,
	
	--include a module to this class
	include = function(self, ...)
		local args = {...}
		for i, module in pairs(args) do
			table.insert(self.__modules, module)
		end
		return self
	end,

	--let class extends an other class
	extends = function(self, super)
		if self.__super ~= Object then error(string.format("class already has a super class: %s", super.__name)) end
		self.__super = super
		return self
	end,
}

--instance prototype
___Instance = {


	__index = function(table, key)
		return ___Instance.__index_key(table.__cls, key)
	end,
	
	--[[
		* lookup key in class
		* lookup key in modules
		* lookup in super class
	]]
	__index_key = function(table, key)
		--print(tostring(rawget(table, "__name"))..": "..key)
	
		--lookup key in current table
		local f = rawget(table, key)
		--wheter lookup was from a module or not
		local moduled = nil
		
		--search superclasses for key
		if not f and rawget(table, "__super") then
			f, moduled = ___Instance.__index_key(table.__super, key)
		end
		
		--search modules
		if not f or moduled then
			for i, module in ipairs(table.__modules) do
				if module[key] then return module[key], true end
			end
		end
		
		return f
	end,
	
	__index_super = function(table, key)
		
		
		--lookup key in class
		local f = rawget(table, key)

		--lookup key in modules				
		if f == nil then
			for i, module in ipairs(table.__modules) do
				f = module[key]
				if f then break end
			end
		end
		
		--recursively check super class
		return f or rawget(table, "__super") and ___Instance.__index_super(table.__super, key)
	end,
	
	__concat = function(pre, table)
		
	end

}

--class constructor
function class(name)

	--check if name is set
	if not name then error("No classname specified") end
	
	--check if class already exists
	--if _G[name] then error(string.format("Class %s already exists.", name)) end

	--create class table
	local instance = {
		__index = ___Class.__index,
		__name = name,
		__super = name == "Object" and nil or Object,
		__modules = {},
	}
	--inherit methods from ___Class	prototype
	setmetatable(instance, ___Class)

	--namespace the class to given name	
	_G[name] = instance
	
	return instance
end

class("Object")

function Object:toString()
	return string.format("%s", self.__name)
end

--attach table of variables to instance
function Object:vars(table)
	for k, v in pairs(table) do
		self[k] = v
	end
end

function Object:getClass()
	return self.__cls
end

class("ClassLoader")

function ClassLoader:__construct()
	self.loadedClasses = {}
end

--[[
	loads a class
	* check if class was already loaded before
	* check if class is located locally
	* check if class is located remotely in one of the repos
	* when not found, throw an error
	* execute classloading
]]
function ClassLoader:load(cls)

	--check if class was already loaded before
	if not self.loadedClasses[cls] then
		
		--convert dotted notation to uri
		local path = string.gsub(cls, "%.", "/")
		
		--check if class is located locally when force is off
		if not self.force and fs.exists(path) then
			local handle = fs.open(path, "r")
			local file = handle.readAll()
			handle.close()
			return self:loadClass(cls, file)
		end
		
		--check if class is located remotely in one of the repos
		for i, repo in ipairs(__class_repos) do
			
			--concatenate url, repo and branch
			local url = string.format("%s/%s%s%s.lua", repo.url, repo.repo, not (repo.branch or repo.branch == "") and "" or "/"..repo.branch, path)
			--print("url: "..url)
			
			local request = http.request(url)
			local response = nil
			while not response do
				local event, url, handle = os.pullEvent()
				if event == "http_success" or event == "http_failure" then
					response = handle
				end
			end
			
			if response and response.getResponseCode() == 200 then 
				return self:loadClass(cls, response.readAll())
			end
		end
	end
end

function ClassLoader:loadClass(name, cls)
	self.loadedClasses[name] = loadstring(cls)
	if not self.loadedClasses[name] then error(string.format("Unable to load class %s", name)) end
	
	--execute class
	self.loadedClasses[name]()
	local path = string.gsub(name, "%.", "/")
	
	if not fs.exists(path) or self.force then
		local pattern = "/[^/]*$"
		local seperator = string.find(path, pattern)
		local folder = string.sub(path, 1, seperator - 1)
		local file = string.sub(path, seperator + 1)
		
		--create directory if it doesn't exist yet
		if not fs.exists(folder) then
			fs.makeDir(folder)
		end
		
		--write file to computer
		local handle = fs.open(path, "w")
		handle.write(cls)
		handle.close()
	end
	return self.loadedClasses[name]
end

function ClassLoader:forceUpdate(force)
	self.force = force
end

--acces variables as global variables
_G["class"] = class
_G["classloader"] = ClassLoader:new()
_G["force_load"] = function(force) classloader.force = force end
_G["import"] = function(cls) classloader:load(cls) end
