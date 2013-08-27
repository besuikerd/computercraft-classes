os.loadAPI("classes")

import "command.CommandHandler"

local handler = CommandHandler:new({
	"bla" = function(arg1, arg2)
		print(string.format("blabla: %s %s", arg1, arg2))
	end,
	
	"hoi" = function()
		print("hoi called")
	end
})

while true do
	handler:scan()
end
