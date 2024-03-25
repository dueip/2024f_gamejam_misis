extends Minigame

@export var repetitions = 3


var current_repetition = 0
var prev_input: String = ""
var tr: bool = true
func startGame():
	super.startGame()
	%WASD.find_child("FirstButton").letter = combination[0].to_upper()
	%WASD.find_child("SecondButton").letter = combination[1].to_upper()
	%WASD.find_child("FirstButton").findButtonIndexFromLetter()
	%WASD.find_child("SecondButton").findButtonIndexFromLetter()
	
	var tween = get_tree().create_tween()

	tween.tween_callback(%WASD.find_child("FirstButton").highlight).set_delay(button_delay * 2)
	tween.chain()
	tween.tween_callback(%WASD.find_child("SecondButton").highlight).set_delay(button_delay * 2)
	tween.parallel()
	tween.tween_callback(%WASD.find_child("FirstButton").unhighlight).set_delay(button_delay * 2)
	tween.chain()
	tween.tween_callback(%WASD.find_child("SecondButton").unhighlight).set_delay(button_delay * 2)
	tween.set_loops()

func _process(delta):
	pass

func nextTurn(input: String):
	%WASD.highlight_button(input.to_upper(), Color.GREEN)
	#for i in combination:
		#%WASD.highlight_button(i.to_upper(), Color.LIGHT_GOLDENROD)
	var tween = get_tree().create_tween()
	if combination.size() > 2:
		print("Uwu dont do this please")#i love you too
	
	
	
	if prev_input.length() == 0: 
		if input.to_upper() != combination[0].to_upper(): 
			endGame(false, input)
			return
	else:
		if input.to_upper() != combination[1].to_upper():
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
	
	tween.tween_callback(%WASD.unhighlight_button.bind(input.to_upper())).set_delay(button_delay)

func endGame(did_player_win: bool, which_button_was_pressed: String):
	super.endGame(did_player_win, which_button_was_pressed)
	current_repetition=0
	prev_input = ""
	


