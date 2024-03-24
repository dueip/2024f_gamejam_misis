extends Node3D


@export var exams: Exams
var is_mouse_in: bool = false
var current_exam: Exam = null
var exam_minigame = preload("res://exam_minigame.tscn")
var exam_instance
func _ready():
	$LoadingBar.data = BarResource.new()
	$ExamQueue.wait_time = exams.padding()
	$ExamQueue.start()
	$ExamQueue.one_shot = true
	$Area3D.monitoring = false
	$LoadingBar.data.value = 0
	$LoadingBar.data.max_value = $ExamQueue.wait_time
	$LoadingBar.has_finished = false
	print($LoadingBar.data.max_value)



func _input(event):
	if $Area3D.monitoring && event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT && is_mouse_in && event.is_pressed():
		var SceneManager = get_tree().get_first_node_in_group("SceneManager")
		SceneManager.chane_scene_to_instance(exam_instance)

func _on_area_3d_mouse_entered():
	is_mouse_in = true

func _on_minigame_won():
	self.hide()
	var SceneManager = get_tree().get_first_node_in_group("SceneManager")
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().get_first_node_in_group("SceneManager").revertScene()
	current_exam = null
	is_mouse_in = false
	$Area3D.monitoring = false
	queue_free()

	
func _on_area_3d_mouse_exited():
	is_mouse_in = false


func _on_waiting_for_new_exam_timeout():
	var new_exam: Exam = Exam.new()
	new_exam.exam_name = "IT"
	new_exam.min_wait_time = 8
	new_exam.max_wait_time = 10
	exams.append_possible_exams(new_exam)

	


func _on_exam_queue_timeout():
	self.show()
	current_exam = exams.get_random_exam()
	exam_instance = exam_minigame.instantiate()
	exam_instance.spawning_place = self
	$Label3D.text = current_exam.exam_name
	$Area3D.monitoring = true
