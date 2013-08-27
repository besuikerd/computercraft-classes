import "Renderer"

class "MonitorRenderer" :extends Renderer


function MonitorRenderer:__construct(monitor)
	self.monitor = monitor
end

function MonitorRenderer:box(x, y, width, height, color, opacity)
	local monitor = self.monitor
	monitor.setBackgroundColor(color)
	--draw box pixels
	for i=1, width do
		monitor.setCursorPos(x, y)
		for j=1, height do
			monitor.write(" ")
		end
		x = x + 1
	end
end

function MonitorRenderer:text(x, y, width, height, color, bgColor)
	local monitor = self.monitor
	monitor.setTextColor(color)
	monitor.setBackgroundColor(bgColor or colors.black)
end
