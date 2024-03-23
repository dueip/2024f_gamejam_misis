extends Node3D
class_name Minigame

signal minigame_started(Minigame)
signal minigame_ended(bool)

@export var award: int
@export var buff: int
@export var cost: int


func startGame():
	emit_signal("minigame_started", self)
	
	
func play(input: String):
	print("helloworld")
	
func endGame(did_player_win: bool):
	emit_signal("minigame_ended", did_player_win)
	
