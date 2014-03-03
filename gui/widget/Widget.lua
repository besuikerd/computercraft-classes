class "Widget"

Widget.Dimension = table.immutable({
  WRAP_CONTENT = "WRAP_CONTENT",
  ABSOLUTE = "ABSOLUTE"
})


function Widget:__construct(vars)
  self.x = 1
  self.y = 1
  self.width = 0
  self.height = 0
  self.dx = 0
  self.dy = 0
  if not vars then vars = {} end
  if vars.padding then
    self:padding(vars.padding)
  else
    self.paddingTop = vars.paddingTop or 0
    self.paddingRight = vars.paddingRight or 0
    self.paddingBottom = vars.paddingBottom or 0
    self.paddingLeft = vars.paddingLeft or 0
  end
  self.dimensionX = Widget.Dimension.ABSOLUTE
  self.dimensionY = Widget.Dimension.ABSOLUTE
end

function Widget:draw(renderer, model) end
function Widget:dimension(renderer, model) end
function Widget:update(model) end

function Widget:absX() return (self.parent and self.parent.paddingLeft or 0) + self.x + self.dx end
function Widget:absY() return (self.parent and self.parent.paddingTop or 0) + self.y + self.dy end
function Widget:paddedWidth() return self.width + self.paddingLeft + self.paddingRight end
function Widget:paddedHeight() return self.height + self.paddingTop + self.paddingBottom end

function Widget:padding(top, right, bottom, left)
  if top and not right and not bottom and not left then
    return self:padding(top, top, top, top)
  end
  
  self.paddingTop = top
  self.paddingRight = right
  self.paddingBottom = bottom
  self.paddingLeft = left
  return self
end

