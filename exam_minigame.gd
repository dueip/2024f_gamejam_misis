extends Node2D

@onready var right_part = $RightPart
@onready var left_part = $Bilet

func _ready():
	left_part.connect("minigameWon", _on_minigame_won)
	right_part.connect("enteredTheHole", left_part._on_entered_the_hole)
	right_part.connect("exitedTheHole", left_part._on_exited_the_hole)

func _on_minigame_won():
	print("we won!")
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().get_first_node_in_group("SceneManager").revertScene()
