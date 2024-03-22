extends Control

@export var stats : CharacterStats


func _ready():
	for i in range(0,stats.lives):
		var live = TextureRect.new()
		live.texture=load("res://images/grade_book.png")
		add_child(live)
		live.expand_mode=TextureRect.EXPAND_IGNORE_SIZE
		live.stretch_mode=TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		live.size=Vector2(96,96)
		live.position=Vector2(32+48*i,16)
	$Money.text="$" + str(stats.inventory.money)
	$Score.text="Score:\n" + str(stats.score)
	stats.changed_stats.connect(update_gui)

func update_gui():
	$Money.text="$" + str(stats.inventory.money)
	$Score.text="Score:\n" + str(stats.score)
