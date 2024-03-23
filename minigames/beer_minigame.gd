extends Minigame

@export var repetitions = 3
@export var combination: Array[String]
@export var button_delay: float = 0.2
var current_repetition = 0
var prev_input: String = ""

func startGame():
	%WASD.highlight_button(combination[0].to_upper(), Color.LIGHT_GOLDENROD)
	%WASD.show()
	emit_signal("minigame_started", self)
	

func nextTurn(input: String):
	for i in combination:
		%WASD.highlight_button(i.to_upper(), Color.LIGHT_GOLDENROD)
	var tween = get_tree().create_tween()
	if combination.size() > 2:
		print("Uwu dont do this please")#i love you too
	
	
	
	if prev_input.length() == 0: 
		if input != combination[0]: 
			endGame(false, input)
			return
	else:
		if input != combination[1]:
			endGame(false, input)
			return
	if prev_input.length() > 0:
		current_repetition += 1
		prev_input = ""
	else:
		prev_input = input
	if current_repetition == repetitions:
		endGame(true, input)
		return
	%WASD.highlight_button(input.to_upper(), Color.GREEN)
	tween.tween_callback(%WASD.unhighlight_button.bind(input.to_upper())).set_delay(button_delay)

func endGame(did_player_win: bool, which_button_was_pressed: String):
	var tween = get_tree().create_tween()
	if (not did_player_win):
		%WASD.highlight_button(which_button_was_pressed.to_upper(), Color.RED)
		tween.tween_callback(%WASD.unhighlight_button.bind(which_button_was_pressed.to_upper())).set_delay(button_delay)
		tween.finished.connect(_on_tween_finished)
	else:
		%WASD.highlight_button(which_button_was_pressed.to_upper(), Color.GREEN)
		tween.tween_callback(%WASD.unhighlight_button.bind(which_button_was_pressed.to_upper())).set_delay(button_delay)
	tween.finished.connect(_on_tween_finished)
	current_repetition=0
	prev_input = ""
	emit_signal("minigame_ended", did_player_win)

func _on_tween_finished():
	%WASD.hide()
