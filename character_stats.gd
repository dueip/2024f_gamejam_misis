extends Resource

class_name CharacterStats

@export var inventory : Inv
@export var stamina : BarResource
@export var lives : int = 3
@export var money : int = 200
@export var score : int = 0
@export var score_multiplyer : float = 1

signal changed_stats
signal changed_stat(stat : String)

func add_money(amount: int): #amount must be >=0
	money+=amount
	emit_signal("changed_stats")
	emit_signal("changed_stat", "money")
	

func use_money(amount: int) -> bool: #amount must be >=0
	if money>=amount:
		money-=amount
		emit_signal("changed_stats")
		emit_signal("changed_stat", "money")
		return true
	else:
		return false

func change_score(amount : int): #amount could be <0
	score+=amount*score_multiplyer
	emit_signal("changed_stats")
	emit_signal("changed_stat", "score")
	
	
func get_live():
	lives+=1
	emit_signal("changed_stats")
	emit_signal("changed_stat", "lives")
	
	
func lose_live() -> bool :
	lives-=1
	emit_signal("changed_stats")
	emit_signal("changed_stat", "lives")
	return lives==0


