os.loadAPI("classes")

import "programs.quarry.chunker"

local args = {...}
if #args < 2 then error("usage: [x,y,direction]") end

local lengthX = tonumber(args[1]) or error "x must be an integer"
local lengthY = tonumber(args[2]) or error "y must be an integer"
if args[3] and not (args[3] == "left" or args[3] == "right") then error "direction must be either left or right" end
local dirFunction = args[3] and args[3] == "right" and turtle.turnRight or turtle.turnLeft

local X = 0
local Y = 1

local currentDirection = X 
local current = 0

local slot_chest = 1
local slot_chunks = 2
local slot_fence = 3



local chunker = Chunker:new("up", slot_chunks)

for i=1,4 do --a square has four sides
  print(current)
  while current < (currentDirection == X and lengthX or currentDirection == Y and lengthY) do
    chunker:run()
    
    ensureFences()
    turtle.select(slot_fence)
    turtle.forcePlaceDown(slot_fence)
    current = current + 1
  end
  current = 0
  currentDirection = currentDirection == X and Y or X
  dirFunction()
end

function ensureFences()
  if turtle.getItemCount(slot_fence) == 0 then
    turtle.forcePlaceDown(slot_chest)
    turtle.select(slot_fence)
    while not turtle.suckDown() do end
    turtle.select(slot_chest)
    turtle.digDown()
  end
end