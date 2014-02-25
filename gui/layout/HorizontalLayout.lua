import "gui.layout.Layout"
import "gui.widget.Widget"

class "HorizontalLayout" :extends(Layout)

local DEFAULT_MARGINX = 0
local DEFAULT_MARGINY = 0

function HorizontalLayout:__construct(marginX, marginY)
  self.marginX = marginX or DEFAULT_MARGINX
  self.marginY = marginY or DEFAULT_MARGINY 
end

function HorizontalLayout:init()
  self.xOffset = 0
  self.yOffset = 0
  self.maxHeight = 0
end

function HorizontalLayout:layout(element, index)
  if element.parent.dimensionX ~= Widget.Dimension.WRAP_CONTENT and self.xOffset + element:paddedWidth() > element.parent.width then
    self.yOffset = element:paddedHeight() + self.marginY
    self.xOffset = element.parent.paddingLeft
    self.maxHeight = element.height
  elseif element.height > self.maxHeight then 
    self.maxHeight = element.height
  end
  
  element.x = self.xOffset
  element.y = self.yOffset
  self.xOffset = self.xOffset + element.width + (#element.parent.elements == index and 0 or self.marginX) --increment y offset
end

function HorizontalLayout:laidOutDimensions()
  return self.xOffset, self.yOffset + self.maxHeight
end