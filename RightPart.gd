extends Node2D

signal enteredTheHole()
signal exitedTheHole()

@onready var hole = $Hole
@onready var SomeOtherThing = $SomeOtherThing

var is_some_other_thing_in: bool = false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)
	

func _input(event):
	if event is InputEventMouseMotion:
		SomeOtherThing.position += event.relative 
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT && not event.is_echo():
		if is_some_other_thing_in:
			print("Correct!")
		

func _process(delta):
	
	SomeOtherThing.global_position.x = clampf(SomeOtherThing.global_position.x, get_viewport_rect().size.x / 2, get_viewport_rect().size.x);
	SomeOtherThing.global_position.y = clampf(SomeOtherThing.global_position.y, 0, get_viewport_rect().size.y);
	
	SomeOtherThing.position.x += randf_range(-1, 1) * 10
	SomeOtherThing.position.y += randf_range(-1, 1) * 10




func _on_hole_area_area_entered(area):
	is_some_other_thing_in = true
	emit_signal("enteredTheHole")

func _on_hole_area_area_exited(area):
	is_some_other_thing_in = false
	emit_signal("exitedTheHole")
