extends Camera3D

@onready var tween_x = get_tree().create_tween()
@onready var tween_y = get_tree().create_tween()
@onready var tween_z = get_tree().create_tween()
@onready var stats = preload("res://global_char_stats.tres")
@onready var final_loop = false

func _ready():
	stats.changed_stat.connect(_on_booze_update)
	
func _on_booze_update(stat : String):
	if stat!="booze_lvl":
		return
	var amplitude = Booze.lvls()[stats.booze_lvl]
	var animation_speed = 1 +Booze.lvls()[stats.booze_lvl]*0.2
	
	final_loop=true
	tween_x.set_speed_scale(8)
	tween_y.set_speed_scale(2)
	tween_z.set_speed_scale(2)
	await get_tree().create_timer(0.5).timeout
	final_loop=false
	
	
	tween_x = get_tree().create_tween()
	tween_y = get_tree().create_tween()
	tween_z = get_tree().create_tween()
	tween_x.loop_finished.connect(finish_x)
	tween_y.loop_finished.connect(finish_y)
	tween_z.loop_finished.connect(finish_z)
	
	tween_x.tween_property(self, "position:x", position.x - amplitude/2, 1).set_trans(tween_x.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween_x.tween_property(self, "position:x", position.x + amplitude, 2).set_trans(tween_x.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	tween_x.tween_property(self, "position:x", position.x, 1).set_trans(tween_x.TRANS_QUAD).set_ease(Tween.EASE_IN)
	tween_y.tween_property(self, "position:y", position.y - amplitude/20*cos(rotation.x), 0.2).set_trans(tween_x.TRANS_QUAD).set_ease(Tween.EASE_IN)
	tween_y.tween_property(self, "position:y", position.y + amplitude/10*cos(rotation.x), 0.4).set_trans(tween_x.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	tween_y.tween_property(self, "position:y", position.y, 0.2).set_trans(tween_x.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween_z.tween_property(self, "position:z", position.z - amplitude/20*sin(rotation.x),  0.2).set_trans(tween_x.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween_z.tween_property(self, "position:z", position.z + amplitude/10*sin(rotation.x), 0.4).set_trans(tween_x.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	tween_z.tween_property(self, "position:z", position.z, 0.2).set_trans(tween_x.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween_x.set_loops()
	tween_y.set_loops()
	tween_z.set_loops()	
	tween_x.set_speed_scale(animation_speed)
	tween_y.set_speed_scale(animation_speed)
	tween_z.set_speed_scale(animation_speed)
	
	


func finish_x(loop_count):
	if final_loop:
		tween_x.kill()
		
func finish_y(loop_count):
	if final_loop:
		tween_y.kill()

func finish_z(loop_count):
	if final_loop:
		tween_z.kill()
		
func move_to_the_point(point : Vector3, time : float):
	var ray = project_ray_normal(get_viewport().get_visible_rect().size/2)
	var middle_point= Plane(ray,global_position).project(point)
	
	var dist_first= middle_point.distance_to(global_position)
	var dist_second= middle_point.distance_to(point)
	var t_first=time*dist_first/(dist_first+dist_second)
	var t_second=time*dist_second/(dist_first+dist_second)
	var tween = get_tree().create_tween()
	var start=global_position
	tween.tween_callback(get_parent().find_child("Character").switch_freeze)
	tween.tween_property(self, "position", middle_point, t_first)
	tween.tween_property(self, "position", point, t_second).set_trans(tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position", start, 0.01)
	tween.tween_callback(get_parent().find_child("Character").switch_freeze)
	
