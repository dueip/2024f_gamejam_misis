extends Control

@onready var stats : CharacterStats = preload("res://global_char_stats.tres")


func _ready():
	set_process_input(false)
	set_process_unhandled_input(false)
	set_process(false)
	update_gui("all")
	stats.changed_stat.connect(update_gui)

func update_gui(stat : String):
	if (stat== "all" or stat =="lives"):
		if stats.lives<$Lives.get_children().size():
			for i in range($Lives.get_children().size()-1,stats.lives-1,-1):
				var child = $Lives.get_children()[i]
				$Lives.remove_child(child)
				child.queue_free()
		else:
			for i in range($Lives.get_children().size(),stats.lives):
				var live = TextureRect.new()
				live.texture=load("res://images/grade_book.png")
				$Lives.add_child(live)
				live.expand_mode=TextureRect.EXPAND_IGNORE_SIZE
				live.stretch_mode=TextureRect.STRETCH_KEEP_ASPECT_CENTERED
				live.size=Vector2(96,96)
				live.position=Vector2(32+48*i,16)
	if (stat=="all" or stat=="money"):
		$Money.text="$" + str(stats.money)
	if (stat=="all" or stat=="score" or stat == "score_multiplyer"):
		
		$Score.text="[right][font_size=35][rainbow freq=1 sat=0.6 val=1][shake rate=20.0 level=5 connected=1]Score:\n" + str(stats.score) + "\nX" + str(stats.score_multiplyer) + "[/shake][/rainbow][/font_size][right]"
		

