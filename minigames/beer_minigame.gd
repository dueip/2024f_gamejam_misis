extends Minigame

@export var repetitions = 3
@export var combination: Array[String]

var current_repetition = 0
var prev_input: String = ""

func startGame():
	emit_signal("minigame_started", self)

func nextTurn(input: String):
	print(input)
	
	if prev_input.length() == 0: 
		if input != combination[0]: 
			endGame(false)
			return
	else:
		if input != combination[1]:
			endGame(false)
			return
	if prev_input.length() > 0:
		current_repetition += 1
		prev_input = ""
	else:
		prev_input = input
	if current_repetition == repetitions:
		endGame(true)
		return
	
