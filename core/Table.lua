function table.immutable(obj)
  local metatable = {
    __index = function(proxy,k)
      local v = obj[k]
      if type(v) == 'table' then
        v = table.immutable(v)
      end
      return v
    end,
    __newindex = function(proxy,k,v)
      error("object is immutable")
    end
  }
  return setmetatable({}, metatable)
end