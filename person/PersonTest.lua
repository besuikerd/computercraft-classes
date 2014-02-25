--load the classes api
--os.loadAPI("classes")

--import Student class
os.loadAPI("classes")

import "person.Student"

local student = Student:new("Piet", "Piraat")

student:study()
student:greet()
student:think()
student:beat()
