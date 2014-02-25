os.loadAPI("classes")

force_load(true)

import "command.CommandHandler"


local load = function(cls)
	if not cls then
		print "usage: load [cls]"
	else
		local hadforce = classloader.force
		force_load(true)
		
		local success, e  = pcall(function() classloader:load(cls) end)
		if success then
			print(string.format("%s loaded succesfully!", cls))
		else
			print(string.format("%s failed loading: %s", cls, e))
		end
		force_load(hadforce)
	end
end

local handler = CommandHandler:new({
	load,
	
	debug = function(...)
		local args = {...}
		if #args > 0 then
			local cls = args[1]
			load(cls)
			shell.run(table.concat(args, " "))
		else
			print("please specify a program to debug")
		end
	end,
	
	
	_fallback = function(name, args)
		local success, e = pcall(function() 
			table.insert(args, 1, name) 
			shell.run(table.concat(args, " ")) 
		end)
	end
})

handler:scanner()
