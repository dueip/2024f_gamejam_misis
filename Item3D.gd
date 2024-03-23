extends Node3D

class_name Item3D

@export var spin_speed : float 
@onready var sprite : Sprite3D = $Sprite3D
@export var float_loop_time: float = 3
@export var spin_loop_time: float = 2
@export var amplitude : float = 0.5
@export var animation_speed: float = 1

@export var item : InvItem

func _ready():
	$Sprite3D.texture=item.texture
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


#func _process(delta):
	#$Sprite3D.rotate_y(delta*spin_speed)


func _on_area_3d_body_entered(body):
	if body is Character:
		if(body.stats.inventory.add(item)):
			queue_free()
