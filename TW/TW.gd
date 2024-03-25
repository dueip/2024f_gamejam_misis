extends Area3D

class_name TW

@export var tw_name: String
@export var award: int 
@export var minigame: Minigame
@export var animation_speed: float = 1
@export var animation_loop_time: float = 1
@onready var player : Character = get_tree().get_first_node_in_group("Player")
var change_sign: int = 1


func create_tw_at(where_at: Vector3, new_tw_name: String, new_award: int) -> TW:
	self.position = where_at
	self.tw_name = new_tw_name
	self.award = new_award
	
	return self
	
func _ready():
	var sprite: Sprite3D = minigame.get_node("Sprite3D") 
	var tween = get_tree().create_tween()
	var vector_first = sprite.position
	var vector_final = Vector3(sprite.position.x, sprite.position.y + 1, sprite.position.z)
	tween.tween_property(sprite, "position", vector_final, animation_loop_time / 2).set_trans(tween.TRANS_SINE)
	tween.tween_property(sprite, "position", vector_first, animation_loop_time / 2).set_trans(tween.TRANS_SINE)
	tween.set_speed_scale(animation_speed)
	tween.set_loops()
	
	
	
func _on_mouse_entered():
	pass
	



func _on_mouse_exited():
	pass


func _on_tree_exited():
	player.current_minigame = null
	player.current_minigame_focused = null


func _on_body_entered(body):
	if body is Character:
		player.current_minigame_focused = minigame
		minigame.minigame_started.connect(player.on_minigame_started)
		minigame.minigame_ended.connect(player._on_minigame_ended)
		


func _on_body_exited(body):
	player.current_minigame_focused = null
