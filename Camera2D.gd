extends Camera2D

@onready var tween_x = get_tree().create_tween()
@onready var tween_y = get_tree().create_tween()
@onready var stats = preload("res://global_char_stats.tres")
@onready var final_loop = false

func _ready():
	stats.changed_stat.connect(_on_booze_update2d)
	_on_booze_update2d("booze_lvl")
	
func _on_booze_update2d(stat : String):
	if stat!="booze_lvl":
		return
	var amplitude = Booze.lvls()[stats.booze_lvl]*20
	var animation_speed = 1 +Booze.lvls()[stats.booze_lvl]*0.2
	
	final_loop=true
	tween_x.set_speed_scale(8)
	tween_y.set_speed_scale(2)
	await get_tree().create_timer(0.5).timeout
	final_loop=false
	
	
	tween_x = get_tree().create_tween()
	tween_y = get_tree().create_tween()
	tween_x.loop_finished.connect(finish_x)
	tween_y.loop_finished.connect(finish_y)
	
	tween_x.tween_property(self, "position:x", position.x - amplitude/2, 1).set_trans(tween_x.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween_x.tween_property(self, "position:x", position.x + amplitude, 2).set_trans(tween_x.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	tween_x.tween_property(self, "position:x", position.x, 1).set_trans(tween_x.TRANS_QUAD).set_ease(Tween.EASE_IN)
	tween_y.tween_property(self, "position:y", position.y - amplitude/20, 0.2).set_trans(tween_x.TRANS_QUAD).set_ease(Tween.EASE_IN)
	tween_y.tween_property(self, "position:y", position.y + amplitude/10, 0.4).set_trans(tween_x.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	tween_y.tween_property(self, "position:y", position.y, 0.2).set_trans(tween_x.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween_x.set_loops()
	tween_y.set_loops()
	tween_x.set_speed_scale(animation_speed)
	tween_y.set_speed_scale(animation_speed)


func finish_x(loop_count):
	if final_loop:
		tween_x.kill()
		
func finish_y(loop_count):
	if final_loop:
		tween_y.kill()

