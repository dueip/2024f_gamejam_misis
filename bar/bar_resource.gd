extends Resource

class_name BarResource

signal updated
signal updated_value(new_value)

@export var value : float = 100
@export var min_value : float = 0
@export var max_value : float = 100


static func createResourceBar (path_name : String) -> BarResource:
	var new_bar = BarResource.new()
	new_bar.value=100
	new_bar.min_value=0
	new_bar.max_value=100
	ResourceSaver.save(new_bar, "res://bar/bars/" + path_name + ".tres")
	return new_bar
	
static func getResourceBar (path_name : String) -> BarResource:
	var new_bar = load("res://bar/bars/" + path_name + ".tres")
	return new_bar

func loseStamina(how_much: int):
	value=value-how_much
	emit_signal("updated")
	emit_signal("updated_value",value)
	
	
func gainStamina(how_much: int):
	value=value+how_much
	emit_signal("updated")
	emit_signal("updated_value",value)
