extends Node3D

class_name ItemShop

@onready var sprite : Sprite3D = $Sprite3D
@export var float_loop_time: float = 3
@export var spin_loop_time: float = 2
@export var amplitude : float = 0.5
@export var animation_speed: float = 1

@export var item : InvItem
@export var price : float = 150


var in_shop : bool = false

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



func _input(event):
	if !in_shop:
		return
	if Input.is_action_just_pressed("character_use_item"):
		var stats = preload("res://global_char_stats.tres")
		get_viewport().set_input_as_handled()
		if stats.use_money(price):
			if !stats.inventory.add(item):
				stats.add_money(price)



func _on_shop_area_body_entered(body):
	$OmniLight3D.light_energy*=2
	in_shop=true



func _on_shop_area_body_exited(body):
	$OmniLight3D.light_energy/=2
	in_shop=false
