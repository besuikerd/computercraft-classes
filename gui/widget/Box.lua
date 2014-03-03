import "gui.widget.Widget"
import "gui.layout.VerticalLayout"

class "Box" :extends(Widget)

function Box:__construct(vars)
  Widget.__construct(self, vars)
  self.dimensionX = Widget.Dimension.WRAP_CONTENT -- override horizontal dimensioning
  self.dimensionY = Widget.Dimension.WRAP_CONTENT -- override vertical dimensioning
  self.bgColor = colors.black
  
  self.layout = VerticalLayout:new()
  self.elements = {}
  self:vars(vars) 
  
  deepMap(self.elements, function(element) element.parent = self end)
end

function Box:draw(renderer, model)
  deepMap(self.elements, function(element)
    element.dx = self:absX()
    element.dy = self:absY()
  end)
  
  renderer:box(self:absX(), self:absY(), self.width, self.height, self.bgColor)
  deepMap(self.elements, function(element)
    element:draw(renderer, model)
  end)
end

function Box:clear()
  elements = {}
end

function Box:addElements(elements)
  deepMap(elements, function(element) element.parent = self end)
  self.elements = elements
end

function Box:dimension(renderer, model)
  Widget.dimension(self, renderer, model)
  self.layout:init()
  
  deepMap(self.elements, function(element)
    element:dimension(renderer, model)
  end)
  
  for i, element in ipairs(self.elements) do
    self.layout:layout(element, i)
  end
  
  if self.dimensionX == Widget.Dimension.WRAP_CONTENT then
    self.width = self.paddingLeft + self.layout:laidOutWidth() + self.paddingRight
  end
  
  if self.dimensionY == Widget.Dimension.WRAP_CONTENT then
    self.height = self.paddingTop + self.layout:laidOutHeight() + self.paddingBottom
  end
end

class "AbsoluteBox" :extends(Box)

function AbsoluteBox:__construct(vars)
  Box.__construct(self, vars)
  self.dimensionX = Widget.Dimension.ABSOLUTE
  self.dimensionY = Widget.Dimension.ABSOLUTE
end