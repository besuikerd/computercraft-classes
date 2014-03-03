function map(list, f)
  local result = {}
  for k,v in pairs(list) do
    result[k] = f(v, k) or v
  end
  return result
end

function deepMap(list, f)
  for k,v in pairs(list) do
    list[k] = f(v, k) or v
  end
  return list
end

function filter(list, f)
  local result = {}
  for i,j in pairs(list) do
    if f(j) then
      result[i] = j
    end
  end
  return result
end

function foldl(list, f, accum)
  for i,j in pairs(list) do
    accum = accum and f(j, accum) or j
  end
  return accum
end

function shallowcopy(table)
  local result = {}
  for i,j in pairs(table) do
    result[i] = j
  end
  return result
end

function rep(f, amount)
  for i=1, amount and amount - 1 or 0 do f() end
  return f()
end