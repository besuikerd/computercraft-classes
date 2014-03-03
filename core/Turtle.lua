function turtle.selectEmpty()
  local slot = turtle.getEmptySlot()
  if slot ~= -1 then
    turtle.select(slot)
    return true
  end
  return false
end

function turtle.getEmptySlot()
  for i=1,16 do
    if turtle.getItemCount(i) == 0 then
      return i
    end
  end
  return -1
end

function turtle.u(amount) return rep(turtle.up, amount) end
function turtle.d(amount) return rep(turtle.down, amount) end
function turtle.f(amount) return rep(turtle.forward, amount) end
function turtle.b(amount) return rep(turtle.back, amount) end

function turtle.l(amount) return rep(turtle.turnLeft, amount) end
function turtle.r(amount) return rep(turtle.turnRight, amount) end

function turtle.forcem(movef, digf, amount)
  for i=1, amount or 1 do
    if not movef() then
      local hasEmpty = turtle.selectEmpty()
      digf()
      if hasEmpty then turtle.drop() end
      while not movef() do end
    end
  end
end

function turtle.forcef(amount) turtle.forcem(turtle.forward, turtle.dig, amount) end
function turtle.forceb(amount) turtle.forcem(turtle.back, function() turtle.l(2) turtle.dig() turtle.r(2) end) end
function turtle.forceu(amount) turtle.forcem(turtle.up, turtle.digUp, amount) end
function turtle.forced(amount) turtle.forcem(turtle.down, turtle.digDown, amount) end

function turtle.forcep(slot, placef, digf)
  local success, e
  while not success do
    turtle.select(slot)
    success, e = placef()
    if e == "No items to place" then error "No items to place" end
    if e == "Cannot place block here" then
      local hasEmpty = turtle.selectEmpty()
      if digf() and hasEmpty then turtle.drop() end
    end
  end
end

function turtle.forcePlace(slot) turtle.forcep(slot, turtle.place, turtle.dig) end
function turtle.forcePlaceUp(slot) turtle.forcep(slot, turtle.placeUp, turtle.digUp) end
function turtle.forcePlaceDown(slot) turtle.forcep(slot, turtle.placeDown, turtle.digDown) end




