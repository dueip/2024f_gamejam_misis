extends CharacterBody3D

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
var mouse_sens = 0.3


var speed_multiplyer: float = 1.0 

@onready var dash_timer := $DashTimer
@onready var stamina_bar := $StaminaBar
@onready var camera := $CameraSpring/Camera
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var running_mult: float = 1

func _ready(): 
	seed("Byeworld".hash())
	


var camera_anglev=0
func _input(event):  		
	pass
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Dash
	

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

	move_and_slide()


func _on_dash_timer_timeout():
	speed_multiplyer = base_multiplyer
	dash_timer.stop()
