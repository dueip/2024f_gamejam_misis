extends Node3D
class_name Minigame

signal minigame_started(Minigame)
signal minigame_ended(bool)

@export var button_delay: float = 0.2
@export var award: int
@export var buff: int
@export var cost: int

@export var combination: Array[String]


func startGame():
	%WASD.show()
	%WASD.highlight_button(combination[0].to_upper(), Color.LIGHT_GOLDENROD)
	emit_signal("minigame_started", self)
	
	
func nextTurn(input: String):
	endGame(false, "")
	
func endGame(did_player_win: bool, which_button_was_pressed: String):
	emit_signal("minigame_ended", did_player_win)
