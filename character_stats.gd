extends Resource

class_name CharacterStats

@export var inventory : Inv
@export var stamina : BarResource
@export var lives : int = 3
@export var money : int = 200
@export var score : int = 0
@export var score_multiplyer : float = 1
@export var booze_lvl : int =0
@export var smoke_lvl : int =0


signal changed_stats
signal changed_stat(stat : String)

#static func get_global_stats() -> CharacterStats:
#	return preload("res://global_char_stats.tres")

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

func add_score(amount : int): #amount could be <0
	if score/1000 > (score+amount*score_multiplyer)/1000:
		inventory.add(InvItem.get_item("grade_book"))
	score+=amount*score_multiplyer
	emit_signal("changed_stats")
	emit_signal("changed_stat", "score")
	
	
func get_live():
	lives+=1
	emit_signal("changed_stats")
	emit_signal("changed_stat", "lives")
	
	
func lose_live() -> bool :
	if (lives>0):
		lives-=1
	emit_signal("changed_stats")
	emit_signal("changed_stat", "lives")
	return lives<=0
	

func up_booze() -> bool:
	booze_lvl+=1
	emit_signal("changed_stats")
	emit_signal("changed_stat", "booze_lvl")
	return booze_lvl>=4
	
func down_booze():
	if (booze_lvl>0):
		booze_lvl-=1
	emit_signal("changed_stats")
	emit_signal("changed_stat", "booze_lvl")

func up_smoke() -> bool:
	smoke_lvl+=1
	emit_signal("changed_stats")
	emit_signal("changed_stat", "smoke_lvl")
	return smoke_lvl>=4
	
func down_smoke()  :
	if (smoke_lvl>0):
		smoke_lvl-=1
	emit_signal("changed_stats")
	emit_signal("changed_stat", "smoke_lvl")
	


