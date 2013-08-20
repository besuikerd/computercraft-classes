class("Person")

function Person:__construct(name, surname)
	self.name = name
	self.surname = surname
end

function Person:greet()
	print("Hello I am a person")
end

function Person:toString()
	return string.format("Person[name=%s, surname=%s]")
end
