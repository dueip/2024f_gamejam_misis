extends Control

@export var stats : CharacterStats


func _ready():
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
	if (stat=="all" or stat=="score"):
		$Score.text="Score:\n" + str(stats.score)


