extends Resource

class_name Exams

@export var max_possible_exams: int = 5
@export var all_possible_exams: Array[Exam]
var padding_: float = 1

func _ready():
	pass

func append_possible_exams(exam: Exam) -> void:
	all_possible_exams.append(exam)
	
func get_random_exam() -> Exam:
	seed(Time.get_ticks_usec()) 
	var exam =  all_possible_exams.pick_random()
	print(exam.exam_name)
	return exam
	
func padding() -> float:
	padding_ += 5
	return padding_ - 5

func get_max_exams() -> int:
	return max_possible_exams 
