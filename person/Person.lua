class("Person")

function Person:__construct(name, surname)
	self.name = name
	self.surname = surname
end

function Person:greet()
	print(string.format("Hello I am a person and my name is %s %s", tostring(self.name), tostring(self.surname)))
end

function Person:toString()
	return string.format("Person[name=%s, surname=%s]")
end
