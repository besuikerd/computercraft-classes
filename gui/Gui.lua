class "Gui"

function Gui:__construct(vars)
  self:vars(vars)
  self:enforce{
    root = "root element to display",
    renderer = "renderer to use"
  }
end

function Gui:clear()
  self.renderer:clear()
end

function Gui:render()
  self.root:update()
  self.root:dimension()
  
  self.root:draw(self.renderer)
end