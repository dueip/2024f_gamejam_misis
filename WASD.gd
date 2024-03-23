extends Control



func highlight_button(name : String):
	var child = find_child(name,false)
	if  child!=null:
		child.highlight()

func unhighlight_button(name : String):
	var child = find_child(name,false)
	if  child!=null:
		child.unhighlight()
	
func _input(event):
	if event is InputEventKey:
			if event.pressed:
				highlight_button(OS.get_keycode_string(event.keycode))
			else:
				unhighlight_button(OS.get_keycode_string(event.keycode))
