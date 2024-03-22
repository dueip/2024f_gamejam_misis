extends Area3D

class_name TW

@export var tw_name: String
@export var award: int 
@export var minigame: Minigame
@export var animation_speed: float = 1
@export var animation_loop_time: float = 1
@onready var sprite: Sprite3D = $Sprite3D
@onready var animation_timer: Timer = $AnimationTimer

var change_sign: int = 1


func create_tw_at(where_at: Vector3, new_tw_name: String, new_award: int) -> TW:
	self.position = where_at
	self.tw_name = new_tw_name
	self.award = new_award
	minigame.instance()
	return self
	
func _ready():
	var tween = get_tree().create_tween()
	var vector_first = sprite.position
	var vector_final = Vector3(sprite.position.x, sprite.position.y + 1, sprite.position.z)
	tween.tween_property(sprite, "position", vector_final, animation_loop_time / 2).set_trans(tween.TRANS_SINE)
	tween.tween_property(sprite, "position", vector_first, animation_loop_time / 2).set_trans(tween.TRANS_SINE)
	tween.set_speed_scale(animation_speed)
	tween.set_loops()
func animateSprite(seed): 
	
	sprite.position.y += animation_speed * exp(0.001 * seed) * change_sign 
	if (animation_timer.is_stopped()):
		animation_timer.start(animation_loop_time)

func _process(delta):
	pass
	#animateSprite(delta)
	
func _on_mouse_entered():
	minigame.startGame()
	minigame.play()


func _on_animation_timer_timeout():
	if change_sign == -1:
		change_sign = 1
	else:
		change_sign = -1
	
