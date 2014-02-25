class "Layout"

function Layout:init() end
function Layout:layout(element, index) end
function Layout:laidOutDimensions() end

function Layout:laidOutWidth()
  local width, height = self:laidOutDimensions()
  return width
end

function Layout:laidOutHeight()
  local width, height = self:laidOutDimensions()
  return height
end