class "Renderer"

function Renderer:box(x, y, width, height, color, opacity) end
function Renderer:text(x, y, text, color, bgColor) end

function Renderer:label(x, y, width, height, text, color, bgColor, paddingX, paddingY)
  local paddingX = paddingX or 0
  local paddingY = paddingY or 0
  
  local color = color or colors.white
  local bgColor = bgColor or colors.black
  
  self:box(x, y, width, height, bgColor)
  local realWidth = width - paddingX * 2
  local lines = math.ceil(#text / realWidth)
  gui.debug("realwidth:%d, lines:%d", realWidth, lines)
  for i=1,lines do
    self:text(x + (width - math.min(realWidth, #text)) / 2, y + (i - 1) + (height - lines) / 2, string.sub(text, (i - 1)*realWidth + 1, i * realWidth), color, bgColor)
  end
end

function Renderer:clear() end

function Renderer:size() end

function Renderer:width() 
  local width, height = self:size()
  return width
end
function Renderer:height() 
  local width, height = self:size()
  return height
end