os.loadAPI("class")

class("Animal")

function Animal:__construct(movement)
	print("animal created!")
	self.movement = movement
end

function Animal:move()
	print(self.movement)
end

function Animal:toString()
	return "animall"
end

animal = Animal:new("moving animal")
animal:move()

class("Utility")

function Utility:util()
	print("Utility function called!")
end

function Utility:toString()
	return "blablabla"
end

class("Dog"):extends(Animal):include(Utility)

function Dog:bark()
	print(string.format("dog barks like: %s",self.barksound))
end

function Dog:__construct(t)
	self:vars(t)
	print("dog created!")
end

dog = Dog:new({barksound = "woof", movement = "moving dog"})
dog:move()
dog:bark()
dog:util()

print(dog:toString())
