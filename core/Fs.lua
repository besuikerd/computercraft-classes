function fs.precedingPath(p)
  local s, e = string.find(p, "/[^/]+$")
  if s and e then
    return string.sub(p, 1, s)
  end
end

function fs.precedingPathExists(p)
  return fs.exists(fs.precedingPath(p))
end

function fs.mkPrecedingPath(path)
  local p = fs.precedingPath(path)
  if p then
    fs.makeDir(p)
  end
end