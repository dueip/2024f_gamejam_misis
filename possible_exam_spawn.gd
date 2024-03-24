extends Node3D


@export var exams: Exams
var is_mouse_in: bool = false
var current_exam: Exam = null
var exam_minigame = preload("res://exam_minigame.tscn")
var exam_instance
func _ready():
	$ExamQueue.wait_time = exams.padding()
	$ExamQueue.start()
	$Area3D.monitoring = false



func _input(event):
	if $Area3D.monitoring && event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT:
		
		var SceneManager = get_tree().get_first_node_in_group("SceneManager")
		SceneManager.chane_scene_to_instance(exam_instance)

func _on_area_3d_mouse_entered():
	is_mouse_in = true

func _on_minigame_won():
	var SceneManager = get_tree().get_first_node_in_group("SceneManager")
	print("we won!")
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().get_first_node_in_group("SceneManager").revertScene()


func _on_area_3d_mouse_exited():
	is_mouse_in = false


func _on_waiting_for_new_exam_timeout():
	
	$Area3D.monitoring = true
	$Label3D.text = current_exam.exam_name	
	var new_exam: Exam = Exam.new()
	new_exam.exam_name = "IT"
	new_exam.min_wait_time = 8
	new_exam.max_wait_time = 10
	exams.append_possible_exams(new_exam)


func _on_exam_queue_timeout():
	
	current_exam = exams.get_random_exam()
	exam_instance = exam_minigame.instantiate()
	exam_instance.spawning_place = self
	$WaitingForNewExam.wait_time = randf_range(current_exam.min_wait_time, current_exam.max_wait_time)
	$WaitingForNewExam.start()
