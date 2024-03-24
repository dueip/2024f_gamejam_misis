extends Control



func highlight_button(name : String, color: Color):
	var child = find_child(name,false)
	if  child!=null:
		child.highlight()

func unhighlight_button(name : String, color: Color = Color(0.745, 0.745, 0.745)):
	var child = find_child(name,false)
	if  child!=null:
		child.unhighlight()

func unhighlight_all(color: Color = Color(0.745, 0.745, 0.745)):
	for child_button in get_children():
			child_button.unhighlight()

func _input(event):
	return
	if event is InputEventKey:
			if event.pressed:
				highlight_button(OS.get_keycode_string(event.keycode), Color(0.874, 0.941, 0.996))
			else:
				unhighlight_button(OS.get_keycode_string(event.keycode), Color(0.745, 0.745, 0.745))
