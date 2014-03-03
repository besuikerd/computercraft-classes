function saveTable(tbl, path)
  if not path then error("no path specified") end
  if not fs.precedingPathExists(path) then fs.mkPrecedingPath(path) end
  local handle = fs.open(path, "w")
  handle.write(textutils.serialize(tbl))
  handle.close()
end

function loadTable(path)
  if not path then error("no path specified") end
  if not fs.exists(path) then error("unable to load table, file doesn't exist!") end
  local handle = fs.open(path, "r")
  local result = handle.read()
end