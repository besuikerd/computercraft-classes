class "Chunker"


Chunker.sides = table.immutable{
  up = 0,
  down = 0,
  front = 0,
  back = 2,
  right = 1,
  left = 3,
}

function Chunker:__construct(side, slot)
  if not Chunker.sides[side] then error("invalid side: "..tostring(side)) end
  if not slot then error("no slot specified in Chunker constructor") end
  self.side = side
  self.place = self.side == "up" and turtle.placeUp or self.side == "down" and turtle.placeDown or turtle.place
  self.dig = self.side == "up" and turtle.digUp or self.side == "down" and turtle.digDown or turtle.dig
  self.slot = slot
end

function Chunker:run()
  turtle.forcef()
  self:doPlace()
  turtle.forceb()
  self:doRemove()
  turtle.forcef()
end


function Chunker:doRemove()
  self:position()
  turtle.select(self.slot) -- select chunkloader slot
  self.dig()
  self:reposition()
end

function Chunker:doPlace()
  self:position() --position correctly to the chunk loader
  
  turtle.select(self.slot) --select chunkloader slot
  
  if not self.place() then --try to place chunkloader
    local hasEmpty = turtle.selectEmpty() --select an empty slot
    self.dig() --try to dig away the block
    if hasEmpty then turtle.drop() end -- drop item that was cleared
    turtle.select(self.slot) --select chunkloader slot
    while not self.place() do end --try to place it again
  end
  
  self:reposition()
end


function Chunker:position()
  for i=1, Chunker.sides[self.side] do
    turtle.turnRight()
  end
end

function Chunker:reposition()
  for i=1, Chunker.sides[self.side] do
    turtle.turnLeft()
  end
end
