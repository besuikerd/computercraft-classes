import "Renderer"

class "HudRenderer" :extends Renderer

function HudRenderer:__construct(bridge)
	self.bridge = bridge
end

function HudRenderer:box(x, y, width, height, color, opacity)
	self.bridge.addBox(x, y, width, height, color, opacity)
end

function HudRenderer:text(x, y, width, height, color, bgColor)
	if bgColor then
		self:box(x, y, width, height, bgColor)
	end
	self.bridge.addText(x, y, width, height, color, opacity)
end

function HudRenderer:clear()
	self.bridge.clear()
end
