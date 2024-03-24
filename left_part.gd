extends Node2D

@export var min_size: int = 4
@export var max_size: int = 8
@export var combination: Array[String] = ["w", "a", "s", "d"]
@export var max_mark: int = 100
@export var cost_of_error: int = 15
var current_mark: int = max_mark
var control_buttons: Array
@onready var controlButton = preload("res://control_buttons.tscn")
var question_index: int = 0

signal minigameWon()

var is_in_the_hole: bool = false

func _ready():
	var number_of_thingies = randi_range(min_size, max_size)
	for i in range(0, number_of_thingies):
		var control_button = controlButton.instantiate()
		control_button.button_name = combination[randi_range(0, combination.size() - 1)].to_upper()
		control_button.position.x += 45 * i
		control_buttons.push_back(control_button)
		add_child(control_button)
		
func _input(event):
	var red_tween = get_tree().create_tween()	
	if event is InputEventKey:
		if event.is_pressed() && not event.is_echo():
			var weirdo: bool = OS.get_keycode_string(event.keycode).to_upper() == control_buttons[question_index].button_name.to_upper()
			if weirdo and is_in_the_hole:
				red_tween.stop()
				for i in range(0, question_index + 1):
					control_buttons[i].highlight(Color.GREEN)
				question_index += 1
			else:
				control_buttons[question_index].highlight(Color.RED)
				#red_tween.tween_callback(control_buttons[question_index].unhighlight).set_delay(0.5)
				current_mark -= cost_of_error
				if current_mark < 0:
					return
		if question_index == control_buttons.size():
			emit_signal("minigameWon")
func _on_entered_the_hole():
	is_in_the_hole = true
	
func _on_exited_the_hole():
	is_in_the_hole = false
	

	
