import "gui.widget.Widget"

class "Square" :extends(Widget)

function Square:__construct(width, height, color)
  Widget.__construct(self)
  self.width = width
  self.height = height
  self.color = color
  
  self:enforce{
    width = "width of the square",
    height = "width of the square",
    color = "color of the square"
  }
end

function Square:draw(renderer)
  renderer:box(self:absX(), self:absY(), self.width, self.height, self.color)
end