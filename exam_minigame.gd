extends Node2D

@onready var right_part = $RightPart
@onready var left_part = $Bilet

func _ready():
	right_part.connect("enteredTheHole", left_part._on_entered_the_hole)
	right_part.connect("exitedTheHole", left_part._on_exited_the_hole)
