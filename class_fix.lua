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
		self.__construct(instance, ...)
		
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
		print(tostring(rawget(table, "__name"))..": "..key)
	
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

class("Person")

function Person:__construct(name, surname)
	print("constructor called!")
	self.name = name
	self.surname = surname
end

function Person:greet()
	print(string.format("Hello I am a person and my name is %s %s", tostring(self.name), tostring(self.surname)))
end

function Person:toString()
	return string.format("Person[name=%s, surname=%s]")
end

class("Heart")

function Heart:beat()
	print("I can feel my heartbeat")
end

class("Brain")

function Brain:think()
	print("I am pondering...")
end

class "Student" 
:extends(Person)
:include(Brain, Heart)

function Student:study()
	print("I am studying")
end

local student = Student:new("Piet", "Piraat")

student:study()
student:greet()
student:think()
student:beat()
