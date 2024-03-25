extends Panel

func _ready():
	get_node("Button").pressed.connect(_on_Button_pressed)
	add_to_group("enemies")
	# группу можно оповестить о событии
	
func _on_Button_pressed():
	get_node("Label").text = "WHAT"
	
