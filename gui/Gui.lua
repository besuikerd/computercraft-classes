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

gui = {}
gui.logger = CompositeLogger:new{
  FileLogger:new("logs/gui", Logger.Level.DEBUG),
  Logger:new(Logger.Level.WARN)
}
gui.error = function(msg, ...) gui.logger:error(msg, ...) end
gui.warn = function(msg, ...) gui.logger:warn(msg, ...) end
gui.info = function(msg, ...) gui.logger:info(msg, ...) end
gui.debug = function(msg, ...) gui.logger:debug(msg, ...) end