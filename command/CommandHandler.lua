import "core/String"

class "CommandHandler"

function CommandHandler:__construct(commands)
	self.commands = {}
	for key, f in pairs(commands) do
		self.commands[key] = f
	end
end

--receive user input and parse the result
function CommandHandler:scan()
	term.write(">")
	local input = String:new(read())
	local args = input:split(" ")
	local key = table.remove(args, 1)
	if not self.commands[key] then
		--call fallback method if it exists
		if self.commands["_fallback"] then
			self.commands["_fallback"](key, args)
		else
			print(string.format("%s is not a valid command", key)) 
		end
	else
		local success, e = pcall(function() self.commands[key](unpack(args)) end)
		if not success then
			print(string.format("command %s failed: %s", key, e))
		end
	end
end

function CommandHandler:scanner()
	local scanning = true
	self.commands["exit"] = function()
		scanning = false
	end
	
	while scanning do
		self:scan()
	end
	
	print "Exiting..."
end
