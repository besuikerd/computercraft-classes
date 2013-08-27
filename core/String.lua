class "String"

function String:__construct(s)
	self.s = s
end

function String:upper()
	return string.upper(self.s)
end

function String:lower()
	return string.lower(self.s)
end

function String:upperFirst()
	return string.gsub("^%1", string.upper)
end

function String:toString()
	return self.s
end

function String:split(d,p)
	local t = {}, 
	ll = 0
	if(#self.s == 1) then return {self.s} end
		while true do
			l=string.find(self.s,d,ll,true) -- find the next d in the string
			if l~=nil then -- if "not not" found then..
			table.insert(t, string.sub(self.s,ll,l-1)) -- Save it in our array.
			ll=l+1 -- save just after where we found it for searching next time.
		else
			table.insert(t, string.sub(self.s,ll)) -- Save what's left in our array.
			break -- Break at end, as it should be, according to the lua manual.
		end
	end
	return t
end

for i, j in ipairs(explode(" ", "arg1 arg2 arg3 arg4")) do
	print(j)
end
