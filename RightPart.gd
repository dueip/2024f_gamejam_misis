extends Node2D

signal enteredTheHole()
signal exitedTheHole()

@onready var hole = $Hole
@onready var SomeOtherThing = $SomeOtherThing
@onready var speed : Vector2 = Vector2(0,0)
var is_some_other_thing_in: bool = false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)
	

var prev_pos : Vector2


func _input(event):
	if event is InputEventMouseMotion:
		SomeOtherThing.position += (event.position-prev_pos)
		print(get_viewport().get_mouse_position())
		Input.warp_mouse(Vector2(100,100))
		prev_pos=get_viewport().get_mouse_position()
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT && not event.is_echo():
		if is_some_other_thing_in:
			print("Correct!")
		

func _process(delta):
	
	SomeOtherThing.position += speed * delta
	SomeOtherThing.global_position.x = clampf(SomeOtherThing.global_position.x, get_viewport_rect().size.x / 2, get_viewport_rect().size.x);
	SomeOtherThing.global_position.y = clampf(SomeOtherThing.global_position.y, 0, get_viewport_rect().size.y);
func _physics_process(delta):
	var stats = preload("res://global_char_stats.tres")
	var mult = Booze.lvls()[stats.booze_lvl]
	if speed.length()>275 + mult*25:
		speed/=10
	speed.x += randfn(0,30)*(1+ mult)
	speed.x += randfn(0,30)*(1+ mult)
	speed.y += randfn(0,30)*(1+ mult)
	speed.y += randfn(0,30)*(1+ mult)




func _on_hole_area_area_entered(area):
	is_some_other_thing_in = true
	emit_signal("enteredTheHole")

func _on_hole_area_area_exited(area):
	is_some_other_thing_in = false
	emit_signal("exitedTheHole")
