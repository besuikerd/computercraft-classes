import "gui.Gui"
import "gui.widget.Box"
import "gui.widget.Square"
import "gui.widget.Text"
import "gui.widget.Label"
import "gui.renderer.CompositeRenderer"
import "gui.renderer.TermRenderer"
import "gui.renderer.GlassesRenderer"
import "gui.layout.HorizontalLayout"

ui = Box:new{
  bgColor = colors.green,
  layout = HorizontalLayout:new(),
  elements = {
  
    Box:new{
      bgColor = colors.gray,
      elements = {
        Square:new(5, 2, colors.red),
        Square:new(5, 2, colors.blue),
      }
    },
    
    Box:new{
      bgColor = colors.pink,
      elements = {
        Square:new(5, 2, colors.magenta),
        Square:new(5, 2, colors.orange),
      }
    }
  }
}

ui = Box:new{
  dimensionX = Widget.Dimension.ABSOLUTE,
  dimensionY = Widget.Dimension.ABSOLUTE,
  width = 20,
  height = 15,
  bgColor = colors.cyan,
  elements = {
    Square:new(11, 7, colors.red),
    Label:new{
      text = "test",
      marginX = 1,
    }
  }
}

g = Gui:new{
  renderer = CompositeRenderer:new{
    TermRenderer:new("right"),
    TermRenderer:new(),
    GlassesRenderer:new("left", 5)
  },
  root = ui
}

g:clear()
g:render()
local x, y = term.getSize()
term.setCursorPos(1, y - 1)