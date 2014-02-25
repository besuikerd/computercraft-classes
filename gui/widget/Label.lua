import "gui.widget.Widget"

class "Label" :extends(Widget)

function Label:__construct(vars)
  self.marginX = 1
  self.marginY = 1
  self.color = colors.white
  self.bgColor = colors.black
  self:vars(vars)
  
  self:enforce{
    text = "text to be displayed on the label"
  }
  
  if self.width == 0 then self.width = #self.text + 2 * self.marginX end
  if self.height == 0 then self.height = 1 + 2 * self.marginY end
end

function Label:draw(renderer)
  renderer:label(self:absX(), self:absY(), self.width, self.height, self.text, self.color, self.bgColor, self.marginX, self.marginY)
end