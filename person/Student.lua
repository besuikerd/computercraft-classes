import "person.Person"
import "person.Brain"
import "person.Heart"

class "Student" 
:extends(Person)
:include(Brain, Heart)

function Student:study()
	print("I am studying")
end
