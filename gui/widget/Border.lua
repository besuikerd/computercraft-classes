import "gui.widget.Widget"

class "Border" :extends(Widget)

function Border:__construct(border, color, widget)
  Widget.__construct(self)
  if type(border) == "number" then self:border(border) 
  elseif type(border) == "table" then self:border(border[1] or 0, border[2] or 0, border[3] or 0, border[4] or 0) end
  
  if not widget then error("no widget specified in Border constructor") end
  self.widget = widget
  if not color then color = colors.white end
  
  self.color = color
end

function Border:update(model)
  self.widget:update(model)
end

function Border:dimension(renderer, model)
  self.widget:dimension(renderer, model)
  
  debug("widget dimensions: (%d,%d,%d,%d)", self.widget.x, self.widget.y, self.widget:paddedWidth(), self.widget:paddedHeight())
  self.widget.x = self.borderLeft + self.widget.paddingLeft
  self.widget.y = self.borderTop + self.widget.paddingTop
  self.width = self.borderLeft + self.widget:paddedWidth() + self.borderRight
  self.height = self.borderTop + self.widget:paddedHeight() + self.borderBottom
end

function Border:draw(renderer, model)
  debug("printing border at (%d,%d,%d,%d)", self:absX(), self:absY(), self.width, self.height)
  
  --top border
  renderer:box(self:absX(), self:absY(), self.width, self.borderTop, self.color)
  
  --right border
  renderer:box(self:absX() + self.width - self.borderRight, self:absY(), self.borderRight, self.height, self.color)
  
  --bottom border
  renderer:box(self:absX(), self:absY() + self.height - self.borderBottom, self.width, self.borderBottom, self.color)
  
  --left border
  renderer:box(self:absX(), self:absY(), self.borderLeft, self.height, self.color)
  
  self.widget.dx = self:absX()
  self.widget.dy = self:absY()
  self.widget:draw(renderer, model)
end

function Border:border(top, right, bottom, left)
  if top and not right and not bottom and not left then
    return self:border(top, top, top, top)
  end
  
  self.borderTop = top
  self.borderRight = right
  self.borderBottom = bottom
  self.borderLeft = left
end