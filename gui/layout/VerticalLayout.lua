import "gui.layout.Layout"
import "gui.widget.Widget"

class "VerticalLayout" :extends(Layout)

local DEFAULT_MARGINX = 0
local DEFAULT_MARGINY = 0

function VerticalLayout:__construct(marginX, marginY)
  self.marginX = marginX or DEFAULT_MARGINX
  self.marginY = marginY or DEFAULT_MARGINY 
end

function VerticalLayout:init()
  self.xOffset = 0
  self.yOffset = 0
  self.maxWidth = 0
end

function VerticalLayout:layout(element, index)
  if element.parent.dimensionY ~= Widget.Dimension.WRAP_CONTENT and self.yOffset + element:paddedHeight() > element.parent.height then
    self.yOffset = element.parent.paddingTop
    self.xOffset = self.xOffset + element:paddedWidth() + self.marginX
    self.maxWidth = element.width
  elseif element.width > self.maxWidth then 
    self.maxWidth = element.width
  end
  
  element.x = self.xOffset
  element.y = self.yOffset
  self.yOffset = self.yOffset + element.height + (#element.parent.elements == index and 0 or self.marginY) --increment y offset
end

function VerticalLayout:laidOutDimensions()
  return self.xOffset + self.maxWidth, self.yOffset
end