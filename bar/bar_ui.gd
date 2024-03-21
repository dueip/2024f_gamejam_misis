extends ProgressBar

@export var resource : BarResource 

func _ready():
	min_value=resource.min_value
	max_value=resource.max_value
	value=resource.value
	resource.updated.connect(update_value)
	
func update_value():
	value=resource.value
	
