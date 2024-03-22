extends Area3D

class_name TW

@export var tw_name: String
@export var award: int 
@export var minigame: Minigame


func create_tw_at(where_at: Vector3, new_tw_name: String, new_award: int) -> TW:
	self.position = where_at
	self.tw_name = new_tw_name
	self.award = new_award
	minigame.instance()
	return self
	

	

	


func _on_mouse_entered():
	minigame.startGame()
	minigame.play()
