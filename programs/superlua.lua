--[[
  lua shell that can execute programs as functions, for example:
  
  ls("some/path/to/something") is equal to "ls some/path/to/something" in the regular cc shell
  
--]]

setmetatable(_G, {
  __index = function(table, key)
    return function(...)
      shell.run(tostring(key).." "..(foldl({...}, function(f, s) return (tostring(f) or "").." "..(tostring(s) or "") end) or ""))
    end
  end
})


lua() --also a function now! =)