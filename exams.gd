extends Resource

class_name Exams

@export var max_possible_exams: int = 5
@export var all_possible_exams: Array[Exam]
var padding_: float = 1

func append_possible_exams(exam: Exam) -> void:
	all_possible_exams.append(exam)
	
func get_random_exam() -> Exam:
	return all_possible_exams.pick_random()
	
func padding() -> float:
	padding_ += 5
	return padding_ - 5

func get_max_exams() -> int:
	return max_possible_exams 
