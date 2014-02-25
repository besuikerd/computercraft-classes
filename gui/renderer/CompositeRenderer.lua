import "gui.renderer.Renderer"

class "CompositeRenderer" :extends(Renderer)

function CompositeRenderer:__construct(renderers)
  if type(renderers) ~= "table" then
    error("CompositeRenderer needs a table of renderers as a constructor argument")
  end
  self.renderers = renderers
end

function CompositeRenderer:box(x, y, width, height, color, opacity)
  deepMap(self.renderers, function(renderer) renderer:box(x, y, width, height, color, opacity) end)
end

function CompositeRenderer:text(x, y, text, color, bgColor)
  deepMap(self.renderers, function(renderer) renderer:text(x, y, text, color, bgColor) end)
end

function Renderer:box(x, y, width, height, color, opacity) end
function Renderer:text(x, y, text, color, bgColor) end


function Renderer:size() 
  local maxX, maxY
  deepMap(self.renderers, function(renderer)
    local x, y = renderer:size()
    if x > maxX then maxX = x end
    if y > maxY then maxY = y end
  end)
  return maxX, maxY
end

function Renderer:clear() 
  deepMap(self.renderers, function(renderer) renderer:clear() end)
end