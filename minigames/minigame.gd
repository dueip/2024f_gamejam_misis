extends Node3D
class_name Minigame

signal minigame_started(Minigame)
signal minigame_ended

@export var award: int
@export var buff: int
@export var cost: int

func startGame():
	emit_signal("minigame_started", self)
	
	
func play():
	pass
	
func endGame():
	emit_signal("minigame_ended")
	
