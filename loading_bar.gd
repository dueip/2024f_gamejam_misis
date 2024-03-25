extends MeshInstance3D

signal finished()

@export var data: BarResource 
@export var ascending: bool = true

var has_finished: bool = true


# 6 = 100
# 0 = 0
#

func _ready():
	var remeber_base_scale_x: float = self.scale.x


func _process(delta):
	if has_finished:
		return
	# Simulate loading progress
	if ascending:
		data.value += delta
		if data.value >= data.max_value:
			emit_signal("finished")
	else:
		data.value -= delta
		if data.value <= data.min_value:
			emit_signal("finished")
		# Update the width of the loading bar
	var new_width = data.value
	self.scale.x = new_width / data.max_value


func _on_finished():
	has_finished = true
	hide()
