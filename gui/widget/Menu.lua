import "gui.widget.Widget"
import "gui.widget.Border"
import "gui.layout.HorizontalLayout"

class "Menu" :extends(AbsoluteBox)

function Menu:__construct(vars)
  AbsoluteBox.__construct(self, vars)
  if not self.color then self.color = colors.lightGray end
  if not self.borderColor then self.borderColor = colors.gray end
  
  self:enforce{
    items = "items to be displayed in Menu"
  }
  
  local mapMenu
  mapMenu = function(m) return map(m, function(v, k) if type(v) == "table" then return mapMenu(v) else return Label:new{text=tostring(v), bgColor = colors.lightGray} end end) end
  --self.items = mapMenu(self.items)
  
  if self.height < 4 then self.height = 4 end
  
  self:clear()
  self:addElements{
    Border:new({0,0,1,0}, self.borderColor, AbsoluteBox:new{
      height = self.height - 1,
      bgColor = self.bgColor,
      elements = mapMenu(self.items),
      layout = HorizontalLayout:new(1,0)
    })
  }
end

function Menu:dimension(renderer, model)
  self.width = renderer:width()
  self.elements[1].widget.width = renderer:width()
  Box.dimension(self, renderer, model)
end
