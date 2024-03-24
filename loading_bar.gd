extends MeshInstance3D

@export var data: BarResource 
@export var ascending: bool = true
@export var has_finished: bool = false

func _process(delta):
	if has_finished:
		return
	# Simulate loading progress
	if ascending:
		data.value += delta * 0.1
		if data.value > data.max_value:
			has_finished = true
	else:
		data.value -= delta * 0.1
		if data.value < data.min_value:
			has_finished = true
		# Update the width of the loading bar
	var new_width = data.max_value * data.value
	self.scale.x = new_width
