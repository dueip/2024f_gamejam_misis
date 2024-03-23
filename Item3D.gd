extends Node3D

class_name Item3D

@onready var sprite : Sprite3D = $Sprite3D
@export var float_loop_time: float = 3
@export var spin_loop_time: float = 2
@export var amplitude : float = 0.5
@export var animation_speed: float = 1
@export var time_to_live : float = 30

@export var item : InvItem

func _ready():
	$Sprite3D.texture=item.texture
	
	var timer : Timer = Timer.new()
	add_child(timer)
	timer.wait_time=time_to_live
	timer.one_shot=true
	timer.start()
	timer.timeout.connect(destroy_item)
	
	var tween_float = get_tree().create_tween()
	var tween_spin = get_tree().create_tween()
	var vector_first = sprite.position
	var vector_final = Vector3(sprite.position.x, sprite.position.y + amplitude, sprite.position.z)
	var rotation_begin = sprite.rotation
	var rotation_end = Vector3(sprite.rotation.x, sprite.rotation.y + TAU, sprite.rotation.z)
	
	tween_float.tween_property(sprite, "position", vector_final, float_loop_time / 2).set_trans(tween_float.TRANS_SINE)
	tween_float.tween_property(sprite, "position", vector_first, float_loop_time / 2).set_trans(tween_float.TRANS_SINE)
	tween_float.set_speed_scale(animation_speed)
	tween_float.set_loops()
		
	tween_spin.tween_property(sprite, "rotation", rotation_end, spin_loop_time)
	tween_spin.tween_property(sprite, "rotation", rotation_begin, 0)
	tween_spin.set_speed_scale(animation_speed)
	tween_spin.set_loops()





func _on_area_3d_body_entered(body):
	if body is Character:
		if(body.stats.inventory.add(item)):
			destroy_item()

func destroy_item():
	var tween_scale = get_tree().create_tween()
	tween_scale.tween_property(sprite, "scale", Vector3(0,0,0), 0.5).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	await get_tree().create_timer(0.5).timeout
	queue_free()
