function string.upperFirst(s)
	return string.gsub("^%1", string.upper)
end

function string.split(self, inSplitPattern, outResults)
  if not outResults then
    outResults = { }
  end
  local theStart = 1
  local theSplitStart, theSplitEnd = string.find( self, inSplitPattern, 
theStart )
  while theSplitStart do
    table.insert( outResults, string.sub( self, theStart, theSplitStart-1 ) )
    theStart = theSplitEnd + 1
    theSplitStart, theSplitEnd = string.find( self, inSplitPattern, theStart )
  end
  table.insert( outResults, string.sub( self, theStart ) )
  return outResults
end

string.join = function(list, glue)
	return foldl(list, function(x, acc) return tostring(acc)..glue..tostring(x) end)
end
