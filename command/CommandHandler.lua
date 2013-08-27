class "CommandHandler"

function CommandHandler:__construct(commands)
	self.commands = {}
	for key, f in pairs(commands) do
		commands[key] = f
	end
end

--receive user input and parse the result
function CommandHandler:scan()
	term.write(">")
	local input = String:new(read())
	local args = input:split(" ")
	local key = table.remove(1)
	if not self.commands[key] then print(string.format("%s is not a valid command", key))
	self.commands[key](unpack(args))
end
