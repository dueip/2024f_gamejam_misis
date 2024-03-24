extends Node3D


@export var exams: Exams
@export var exam_countdown_wait: int = 10
var is_mouse_in: bool = false
var current_exam: Exam = null
var exam_minigame = preload("res://exam_minigame.tscn")
var exam_instance
@onready var global_char_stats : CharacterStats = preload("res://global_char_stats.tres")

func start_exam_queue(wait_time: float):
	$ExamQueue.wait_time = wait_time
	$ExamQueue.start()
	$ExamQueue.one_shot = true
	$Area3D.monitoring = false
	$LoadingBar.data.value = 0
	$LoadingBar.data.max_value = $ExamQueue.wait_time
	$LoadingBar.has_finished = false

var mutex: bool = false

func _ready():
	$LoadingBar.data = BarResource.new() 
	start_exam_queue(exams.padding())




func _input(event):
	if mutex:
		return
	if $Area3D.monitoring && event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT && is_mouse_in && event.is_pressed():
		mutex = true
		var SceneManager = get_tree().get_first_node_in_group("SceneManager")
		SceneManager.chane_scene_to_instance(exam_instance)
		$ExamCountdown.stop()

func _on_area_3d_mouse_entered():
	is_mouse_in = true

func return_to_prev_scene() -> void:
	mutex = false
	var SceneManager = get_tree().get_first_node_in_group("SceneManager")
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().get_first_node_in_group("SceneManager").revertScene()
	exams.number_of_currently_active_exams -= 1
	current_exam = null
	is_mouse_in = false
	self.hide()
	$Area3D.monitoring = false

func _on_minigame_won():
	return_to_prev_scene()
	# Add award
	global_char_stats.add_money($ExamCountdown.time_left * global_char_stats.lives)
	global_char_stats.add_score(global_char_stats.lives / 3 * $ExamCountdown.time_left)
	queue_free()

func _on_minigame_lost():
	# Do not add any award :(
	return_to_prev_scene()
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
	if exams.number_of_currently_active_exams < exams.get_max_exams():
		self.show()
		exams.number_of_currently_active_exams += 1
		current_exam = exams.get_random_exam()
		exam_instance = exam_minigame.instantiate()
		exam_instance.spawning_place = self
		$Label3D.text = current_exam.exam_name
		$Area3D.monitoring = true
		$ExamCountdown.wait_time = exam_countdown_wait
		$ExamCountdown.start()
		$LoadingBar.data.value = exam_countdown_wait
		$LoadingBar.data.max_value = exam_countdown_wait
		$LoadingBar.data.min_value = 0
		$LoadingBar.has_finished = false
		$LoadingBar.ascending = false
		$LoadingBar.show()
	else:
		start_exam_queue(exam_countdown_wait)
	


func _on_exam_countdown_timeout():
	exams.number_of_currently_active_exams -= 1
	queue_free()
