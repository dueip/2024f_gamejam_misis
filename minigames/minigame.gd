extends Node3D
class_name Minigame

signal minigame_started(Minigame)
# if the first argument is true, then the 2nd one returns an award
# Otherwise, it returns the punishment
signal minigame_ended(bool, CharacterStats)

@export var button_delay: float = 0.2
@export var award: CharacterStats
@export var award_stamina_percent: float = 0
@export var punishment: CharacterStats
@export var buff: int
@export var cost: int

@export var combination: Array[String]


func startGame():
	# 2000 - 100 
	# x - 50
	# 2000 / x = 100 / 50
	# x / 2000 = 50 / 100
	# x = 50 * 20000 / 100
	award.stamina.value = award_stamina_percent  * get_tree().get_first_node_in_group("Player").stats.stamina.max_value / 100
	%WASD.show()
	#%WASD.highlight_button(combination[0].to_upper(), Color.LIGHT_GOLDENROD)
	emit_signal("minigame_started", self)
	
	
func nextTurn(input: String):
	endGame(false, "")
	
func endGame(did_player_win: bool, which_button_was_pressed: String):
	%WASD.unhighlight_all()
	%WASD.hide()
	var award_or_punishment: CharacterStats = award if did_player_win else punishment
	emit_signal("minigame_ended", did_player_win, award_or_punishment)
	

