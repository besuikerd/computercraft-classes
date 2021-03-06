import "gui.widget.Widget"

class "Label" :extends(Widget)

function Label:__construct(vars)
  Widget.__construct(self, vars)
  self.marginX = 1
  self.marginY = 1
  self.color = colors.white
  self.bgColor = colors.black
  self:vars(vars)
  
  self:enforce{
    text = "text to be displayed on the label"
  }
  if self.width == 0 then self.dynamicWidth = true end
  if self.height == 0 then self.dynamicHeight = true end
  
end

function Label:dimension(renderer, model)
  Widget:dimension(renderer, model)
  local theText = tostring(gui.getDynamic(self.text, model))
  
  if self.dynamicWidth then self.width = #theText + 2 * self.marginX end
  if self.dynamicHeight then self.height = 1 + 2 * self.marginY end
end

function Label:draw(renderer, model)
  Widget.draw(self, renderer, model)
  renderer:label(self:absX(), self:absY(), self.width, self.height, tostring(gui.getDynamic(self.text, model)), self.color, self.bgColor, self.marginX, self.marginY)
end