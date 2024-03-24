extends Sprite2D

class_name ControlButton

@export var letter : String

func eatYoAss():
	var index = calculate_index(letter)
	frame=index
	unhighlight()

func _ready():
	eatYoAss()

func calculate_index( char: String) -> int :
	var res = char.unicode_at(0)
	res-="A".unicode_at(0)
	if res<0:
		return 0
	return res+16

func shake():
	var tween = get_tree().create_tween()
	var start=position
	for i in range(5):
		var angle = randf_range(0,TAU)
		tween.tween_property(self, "position",start+Vector2.from_angle(angle)*2, 0.05)
		tween.tween_property(self, "position",start, 0.05)



func highlight():
	if frame<56:
		frame+=56
	
func unhighlight():
	if frame>=56:
		frame-=56



