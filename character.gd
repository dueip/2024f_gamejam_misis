extends CharacterBody3D

class_name Character


@onready
var stats: CharacterStats = preload("res://global_char_stats.tres")
@export
var SPEED = 5.0
@export
var base_multiplyer: float = 1.0
@export 
var dash_multiplyer: float = 5.0 
@export
var MIN_DASH_TIME: float = 0.3
@export
var MAX_DASH_TIME: float = 0.5
@export 
var RUNNING_SPEED_MULT: float = 1.5
@export 
var stamina: BarResource
@export 
var stamina_lose: StaminaLoseResource
@export
var mouse_sens: float = 0.05


var current_minigame_focused: Minigame = null

var current_minigame: Minigame = null

var is_in_minigame: bool = false

var can_input: bool = true

var speed_multiplyer: float = 1.0 

@onready var dash_timer := $DashTimer
@onready var stamina_bar := $StaminaBar

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var running_mult: float = 1



var slow_down_value_percents: float = 0



func restoreFromSlowingDown():
	slowDown(0)

func slowDown(value_in_percents: float):
	slow_down_value_percents = value_in_percents



func calculatePositionToLookAt(point: Vector2, current_position: Vector3, camera: Camera3D) -> Vector3:
	var normal = camera.project_ray_normal(point)
	var eye_height= $Body/Цилиндр_002.position.y
	var C = (current_position.y+eye_height-camera.position.y)/ normal.y
	var point_to_look_at : Vector3 = (camera.position)
	point_to_look_at.x+=C*normal.x
	point_to_look_at.z+=C*normal.z
	point_to_look_at.y= current_position.y
	return point_to_look_at
	

func _ready():
	# var minigames: Minigame = get_tree().find_
	seed("Byeworld".hash())
	Input.warp_mouse(Vector2(self.position.x, self.position.y))
	#print(stats.inventory.slots[0].amount)
	#print(stats.inventory.slots[1].amount)
	stats.inventory.updated_slot.connect(_on_item_used)
	
	#Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)
	
func handle_minigame_input(input_event: InputEventKey):
	if can_input:
		current_minigame.nextTurn(OS.get_keycode_string(input_event.keycode))

func _input(event):
	if is_in_minigame:
		if event is InputEventKey and not event.is_echo() and Input.is_key_pressed(event.keycode):
			handle_minigame_input(event)
		return
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT && current_minigame_focused:
			current_minigame_focused.startGame()
		
			
	if Input.is_action_just_pressed("character_use_item") or Input.is_action_just_pressed("character_drop_item"):
		print("trying")
		stats.inventory.use_index(0)
	
func _process(delta):
	$Body.look_at(calculatePositionToLookAt(get_viewport().get_mouse_position(), self.position, get_viewport().get_camera_3d()))
	$Body.rotate_y(deg_to_rad(180))
	
	if is_in_minigame:
		return
	
func _physics_process(delta):
	if is_in_minigame:
		return
	var is_running: bool = Input.is_action_pressed("character_run")
	if is_running:
		running_mult = RUNNING_SPEED_MULT
		
	else:
		running_mult = 1
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("character_right", "character_left", 
	"character_back", "character_up")
	
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED * speed_multiplyer * running_mult
		velocity.z = direction.z * SPEED * speed_multiplyer * running_mult
		if not is_running:
			stamina.lose(stamina_lose.stamina_lose_on_walk)
		else: 
			stamina.lose(stamina_lose.stamina_lose_on_sprint)
			
		if Input.is_action_just_pressed("character_dash") and dash_timer.is_stopped():
			speed_multiplyer = dash_multiplyer
			# Начинаем таймер, который находится между этими переменными
			dash_timer.start(randf_range(MIN_DASH_TIME, MAX_DASH_TIME))
			stamina.lose(stamina_lose.stamina_lose_on_dash)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * speed_multiplyer * running_mult)
		velocity.z = move_toward(velocity.z, 0, SPEED * speed_multiplyer * running_mult)
	velocity -= velocity * slow_down_value_percents / 100
	move_and_slide()


func _on_dash_timer_timeout():
	speed_multiplyer = base_multiplyer
	dash_timer.stop()

func on_minigame_started(minigame: Minigame):
	print("Minigame Started")
	current_minigame = minigame
	is_in_minigame = true

func _on_minigame_ended(did_player_win: bool):
	if did_player_win:
		print("Player won!")
	else:
		print("Player lost!")
	
	current_minigame = null
	is_in_minigame = false

func _on_item_used(action : String,item_name : String):
	if (action!="use"):
		return
	if !Input.is_action_just_pressed("character_use_item"):
		return
	if item_name=="Сидр":
		stats.up_booze()
		stats.stamina.gain(30)
	if item_name=="Вейп":
		stats.up_smoke()
		stats.stamina.gain(30)
	if item_name=="Кофе":
		stats.down_booze()
		stats.stamina.gain(50)
		


	
