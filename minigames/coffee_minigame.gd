extends Minigame

var is_in_mingame = false

@export var time_length = 15
@export var begin_speed : float = 0.5
@export var axeleration : float = 0.02
@export var interval : float = 0.3
@export var move_speed : float = 2
	
var speed : float
var direction = 1
@onready var timer= Timer.new()

@onready var default_position_for_bean: Vector3 = $Bean.position
@onready var default_position_for_fill: Vector3 = $Fill.position
func _ready():
	self.set_process(false)
	
func startGame():
	self.set_process(true)
	emit_signal("minigame_started", self)
	for i in get_tree().get_nodes_in_group("Coffee_minigame"):
		i.show()
	$Sprite3D.hide()
	$Camera3D.make_current()
	#super.startGame()
	
	timer.wait_time=time_length
	timer.one_shot=true
	timer.timeout.connect(endGame.bind(true, ""))
	add_child(timer)
	var tween = get_tree().create_tween()
	tween.tween_callback($WASD.find_child("W").highlight).set_delay(0.5)
	tween.chain()
	tween.tween_callback($WASD.find_child("W").unhighlight).set_delay(0.75)
	tween.parallel()
	tween.tween_callback($WASD.find_child("S").highlight).set_delay(0.5)
	tween.chain()
	tween.tween_callback($WASD.find_child("S").unhighlight).set_delay(0.75)
	tween.set_loops()
	$ProgressBar.value = 0
	$Bean.position = default_position_for_bean
	$Fill.position = default_position_for_fill
	var direction_changer = Timer.new()
	direction_changer.wait_time=interval
	direction_changer.one_shot=false
	direction_changer.timeout.connect(change_direction)
	add_child(direction_changer)
	speed=begin_speed
	
	direction_changer.start()
	timer.start()
	

func change_direction():
	if (randi()%2):
		direction*=-1


func nextTurn(adas: String):
	return

func _process(delta):
	
	speed+=axeleration*delta
	$Bean.position.y+=delta*speed*direction
	$ProgressBar.value=1-timer.time_left/time_length
	if Input.is_action_pressed("character_up"):
		$Fill.position.y+=move_speed*delta
	if Input.is_action_pressed("character_back"):
		$Fill.position.y-=move_speed*delta

func endGame(did_player_win: bool, character: String):
	$Camera3D.clear_current()
	for i in get_tree().get_nodes_in_group("Coffee_minigame"):
		i.hide()
	$Sprite3D.show()
	print("did we win:", did_player_win)
	#super.endGame(did_we_win, character)
	var award_or_punishment: CharacterStats = award if did_player_win else punishment
	emit_signal("minigame_ended", did_player_win, award_or_punishment)
	self.set_process(false)
	

func _on_area_3d_area_exited(area):
	endGame(false, "")
