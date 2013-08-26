--load the classes api
os.loadAPI("classes")
force_load(true)

--import Student class
import("person.Student")

local student = Student:new("Piet", "Piraat")

student:study()
student:greet()
student:think()
student:beat()
