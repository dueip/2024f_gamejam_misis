extends Control



func highlight_button(name : String):
	var child = find_child(name,false)
	if  child!=null:
		child.highlight()

func shake_button(name : String):
	var child = find_child(name,false)
	if  child!=null:
		child.shake()

func unhighlight_button(name : String):
	var child = find_child(name,false)
	if  child!=null:
		child.unhighlight()

func unhighlight_all(color: Color = Color(0.745, 0.745, 0.745)):
	for child_button in get_children():
		if child_button is ControlButton:
			child_button.unhighlight()

func _input(event):
	return
	if event is InputEventKey:
			if event.pressed:
				highlight_button(OS.get_keycode_string(event.keycode))
			else:
				unhighlight_button(OS.get_keycode_string(event.keycode))
