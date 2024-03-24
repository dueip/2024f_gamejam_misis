extends Node2D

@onready var right_part = $RightPart
@onready var left_part = $Bilet
@export var exam_max_questions: int = 4
var spawning_place: Node3D

func _ready():
	left_part.connect("minigameWon", spawning_place._on_minigame_won)
	left_part.connect("minigameWon", _on_minigame_won)
	right_part.connect("enteredTheHole", left_part._on_entered_the_hole)
	right_part.connect("exitedTheHole", left_part._on_exited_the_hole)

func _on_minigame_won():
	pass

