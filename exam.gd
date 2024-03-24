extends Resource

class_name Exam

enum Spawns {
	RANDOM,
	IT_ROOM,
	LIBRARY
} 

@export var exam_name: String
@export var exam_award: int
@export var exam_time: float
 
@export var exam_max_mark: int
@export var max_questions: int
@export var min_questions: int
@export var error_lose_mark: int
@export var duration: float
@export var preferable_spawn: Spawns = Spawns.RANDOM
@export var possible_spawns: Array[Spawns] = []
@export var excluded_spwans: Array[Spawns] = []
@export var max_wait_time: float = 4
@export var min_wait_time: float = 2
