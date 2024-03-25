extends Node3D


@export var items : Array[InvItem]
@export var map_size : Vector2
@export var map_center : Vector2
@export var min_time : int
@export var max_time : int
@export var time_to_live : int = 20
@onready var rand_timer : Timer = Timer.new()
var test_collosion = preload("res://item_generaion/test_collision.tscn")
var item_scene = preload("res://Item3D.tscn")




func rand_wait_time():
	return randi()%(max_time-min_time+1)+min_time

func _ready():
	add_child(rand_timer)
	rand_timer.wait_time=rand_wait_time()
	rand_timer.one_shot=true
	rand_timer.start()
	rand_timer.timeout.connect(spawn_item)
	rand_timer.timeout.connect(restart_timer)
	
func spawn_item():
	var test_instance=test_collosion.instantiate()
	var child_item = item_scene.instantiate()
	var stop = false
	var pos : Vector3
	while !stop:
		pos = Vector3(randf_range(-map_size.x/2,map_size.x/2),3.5,randf_range(-map_size.y/2,map_size.y/2))
		pos.x+=map_center.x
		pos.z+=map_center.y
		test_instance.position=pos
		add_child(test_instance)
		await get_tree().create_timer(0.3).timeout
		stop=(!test_instance.has_overlapping_areas() and !test_instance.has_overlapping_bodies())
		remove_child(test_instance)
	child_item.position=pos
	child_item.position.y=0.5
	child_item.time_to_live=time_to_live
	child_item.scale= Vector3(0.5,0.5,0.5)
	if !items.is_empty():
		child_item.item=items[randi()%items.size()]
	add_child(child_item)
	test_instance.queue_free()
	
func restart_timer():
	rand_timer.wait_time=rand_wait_time()
	rand_timer.start()

