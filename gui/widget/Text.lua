import "gui.widget.Widget"

class "Text" :extends(Widget)

function Text:__construct(vars)
  if type(vars) == "table" then
    self:vars(vars)
  elseif type(vars) == "string" then
    self.text = vars
  else
    error("no text specified in Text constructor")
  end
  
  self:enforce{
    text = "text in this Text widget"
  }
end

function Text:draw(renderer)
  renderer:text(self:absX(), self:absY(), self.text)
end