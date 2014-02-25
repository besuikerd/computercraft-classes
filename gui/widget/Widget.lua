class "Widget"

Widget.Dimension = table.immutable({
  WRAP_CONTENT = "WRAP_CONTENT",
  ABSOLUTE = "ABSOLUTE"
})


function Widget:__construct()
  self.x = 1
  self.y = 1
  self.width = 0
  self.height = 0
  self.dx = 0
  self.dy = 0
  self.paddingTop = 0
  self.paddingRight = 0
  self.paddingBottom = 0
  self.paddingLeft = 0
  self.dimensionX = Widget.Dimension.ABSOLUTE
  self.dimensionY = Widget.Dimension.ABSOLUTE
end

function Widget:draw(renderer) end
function Widget:dimension() end
function Widget:update() end

function Widget:absX() return self.x + self.dx end
function Widget:absY() return self.y + self.dy end
function Widget:paddedWidth() return self.width + self.paddingLeft + self.paddingRight end
function Widget:paddedHeight() return self.height + self.paddingTop + self.paddingBottom end


function Widget:padding(top, right, bottom, left)
  self.paddingTop = top
  self.paddingRight = right
  self.paddingBottom = bottom
  self.paddingLeft = left
end

