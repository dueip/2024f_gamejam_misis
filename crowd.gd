extends Node3D

@export var number: int = 5

@export var people : Array[PackedScene]

var people_spawned : Array[Node3D]
var tween: Tween
func _ready():
	for i in range(0, number):
		var person : Node3D = people[randi_range(0, people.size() - 1)].instantiate()
		self.add_child(person)
		person.position.x += person.scale.x * 2 * i
		people_spawned.push_back(person)
		
		
	for pers in people_spawned:
		tween = get_tree().create_tween()
		var position_old = pers.position
		var position_new = Vector3(position_old.x, position_old.y + 1, position_old.z)
		tween.tween_property(pers, "position", position_new, 0.2)
		tween.tween_property(pers, "position", position_old, 0.2)
		tween.tween_interval(randf_range(1, 5))
		tween.set_loops()
	tween.finished.connect(_on_tween_finished)
	
		
var is_tween_finished = true	
func _process(delta):
	pass
	
func _on_tween_finished():
	is_tween_finished = true
	
