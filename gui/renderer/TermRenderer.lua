import "gui.renderer.Renderer"

class "TermRenderer" 
:extends(Renderer)

local COLOR_TEXT = colors.white
local COLOR_BG = colors.black

function TermRenderer:__construct(monitor)
	if monitor then
  	if type(monitor) == "string" then
  	 if peripheral.getType(monitor) == "monitor" then
  	   self.monitor = peripheral.wrap(monitor)
  	 else
  	   error(string.format("not a monitor on side %s", monitor))
  	 end
  	else
  	 self.monitor = monitor
  	end
  else
   self.monitor = term
	end
end

function TermRenderer:box(x, y, width, height, color, opacity)
	local monitor = self.monitor
	if monitor.isColor() then monitor.setBackgroundColor(color) end
	--draw box pixels
	for i=1, width do
		for j=1, height do
			monitor.setCursorPos(x + i - 1, y + j - 1)
			monitor.write(" ")
		end
	end
	if monitor.isColor() then monitor.setBackgroundColor(COLOR_BG) end --restore default bg color
	self:cursorDown()
end

function TermRenderer:text(x, y, text, color, bgColor)
	local monitor = self.monitor
	if monitor.isColor() then
  	monitor.setTextColor(color or COLOR_TEXT)
  	monitor.setBackgroundColor(bgColor or COLOR_BG)
	end
	
	monitor.setCursorPos(x, y)
	monitor.write(text)
	
	if monitor.isColor() then
  	monitor.setTextColor(COLOR_TEXT) --reset default text color
  	monitor.setBackgroundColor(COLOR_BG) -- reset default bg color
	 end
	self:cursorDown()
end

function TermRenderer:size()
  return self.monitor.getSize()
end

function TermRenderer:clear()
  local monitor = self.monitor
  if monitor.isColor() then monitor.setBackgroundColor(colors.black) end
  monitor.clear()
  self:cursorDown()
end

function TermRenderer:cursorDown()
  if self.monitor == term then
    local x, y = self.monitor:getSize()
    self.monitor.setCursorPos(1, y)
  end
end
