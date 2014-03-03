import "gui.Gui"
import "gui.widget.Box"
import "gui.widget.Square"
import "gui.widget.Text"
import "gui.widget.Label"
import "gui.widget.Border"
import "gui.widget.Menu"
import "gui.renderer.CompositeRenderer"
import "gui.renderer.TermRenderer"
import "gui.renderer.GlassesRenderer"
import "gui.layout.HorizontalLayout"

ui3 = Box:new{
  bgColor = colors.green,
  padding=1,
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

ui2 = Box:new{
  width = 20,
  height = 15,
  bgColor = colors.cyan,
  elements = {
    Square:new(11, 3, colors.red):padding(1),
    Border:new({1,20,1,1}, colors.gray, 
      Label:new{
        padding=3,
        bgColor = colors.blue,
        text = gui.dynamic("someString")
      }
    )
  }
}

ui = Menu:new{
  items = {"first", "second", "third"},
  bgColor = colors.blue,
}

model = {
  someString = "starts"
}

g = Gui:new{
  renderer = CompositeRenderer:new{
    TermRenderer:new("right"),
    TermRenderer:new(),
    GlassesRenderer:new("left", 5)
  },
  root = ui,
  model = model
}

if true then
  g:clear()
  g:render()
else
  while true do
    g:clear()
    g.root = (g.root == ui and ui2) or ui
    g:render()
    sleep(0.1)
  end
end
