import "gui.widget.Widget"
import "gui.layout.VerticalLayout"

class "Box" :extends(Widget)

function Box:__construct(vars)
  self.__super:__construct()
  self.dimensionX = Widget.Dimension.WRAP_CONTENT -- override horizontal dimensioning
  self.dimensionY = Widget.Dimension.WRAP_CONTENT -- override vertical dimensioning
  self.bgColor = colors.black
  
  self.layout = VerticalLayout:new()
  self.elements = {}
  self:vars(vars) 
  
  deepMap(self.elements, function(element) element.parent = self end)
end

function Box:draw(renderer)
  deepMap(self.elements, function(element)
    element.dx = self:absX()
    element.dy = self:absY()
  end)


  renderer:box(self:absX(), self:absY(), self.width, self.height, self.bgColor)
  deepMap(self.elements, function(element)
    element:draw(renderer)
  end)
end

function Box:dimension()
  self.layout:init()
  
  deepMap(self.elements, function(element)
    element:dimension()
  end)
  
  for i, element in ipairs(self.elements) do
    self.layout:layout(element, i)
  end
  
  if self.dimensionX == Widget.Dimension.WRAP_CONTENT then
    self.width = self.layout:laidOutWidth()
  end
  
  if self.dimensionY == Widget.Dimension.WRAP_CONTENT then
    self.height = self.layout:laidOutHeight()
  end
end