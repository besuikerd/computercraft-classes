import "gui.renderer.Renderer"

class "GlassesRenderer" :extends(Renderer)

function GlassesRenderer:__construct(bridge, scale)
  if bridge then
    if type(bridge) == "string" then
      if peripheral.getType(bridge) == "openperipheral_glassesbridge" then
        bridge = peripheral.wrap(bridge)
      else
        error(string.format("not a terminal glasses bridge on side %s", monitor))        
      end
    end
    self.bridge = bridge
  else
    error("no bridge specified in GlassesRenderer constructor")
  end
  
  self.scale = scale or 5
end

function GlassesRenderer:box(x, y, width, height, color, opacity)
--debug("y: %.2f <=> %d",(y - 1) * self.scale * GlassesRenderer.correctionY, math.ceil((y - 1) * self.scale * GlassesRenderer.correctionY))
--debug("height: %.2f <=> %d", (height * self.scale * GlassesRenderer.correctionY), math.ceil(height * self.scale * GlassesRenderer.correctionY))

  self.bridge.addBox((x - 1) * self.scale, math.ceil((y - 1) * self.scale * GlassesRenderer.correctionY), width * self.scale, math.ceil(height * self.scale * GlassesRenderer.correctionY), GlassesRenderer.color[color], opacity or 1)
end

function GlassesRenderer:text(x, y, text, color, bgColor)
  self:box(x, y, #text, 1, bgColor or colors.black)
  self.bridge.addText((x - 1) * self.scale, (y - 1) * self.scale * GlassesRenderer.correctionY, text, GlassesRenderer.color[color or colors.white])
end

function GlassesRenderer:size()
  return 30, 20
end

function GlassesRenderer:clear()
  self.bridge.clear()
end

--correction seems to be working better at 1.5 instead of 11/7 due to rounding issues
GlassesRenderer.correctionY = 1.5

--maps terminal colors to terminal glasses api colors
GlassesRenderer.color = {}
GlassesRenderer.color[colors.white] = 0xffffff
GlassesRenderer.color[colors.orange] = 0xffa500
GlassesRenderer.color[colors.magenta] =0xff00ff
GlassesRenderer.color[colors.lightBlue] =0xadd8e6
GlassesRenderer.color[colors.yellow] =0xffff00
GlassesRenderer.color[colors.lime] =0x32cd32
GlassesRenderer.color[colors.pink] =0xffc0cb
GlassesRenderer.color[colors.gray] =0x808080
GlassesRenderer.color[colors.lightGray] =0xd3d3d3
GlassesRenderer.color[colors.cyan] =0x00ffff
GlassesRenderer.color[colors.purple] =0x800080
GlassesRenderer.color[colors.blue] =0x0000ff
GlassesRenderer.color[colors.brown] =0xa52a2a
GlassesRenderer.color[colors.green] =0x00ff00
GlassesRenderer.color[colors.red] =0xff0000
GlassesRenderer.color[colors.black] =0x000000
GlassesRenderer.color = table.immutable(GlassesRenderer.color)
