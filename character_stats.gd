extends Resource

class_name CharacterStats

var inventory : Inv
var stamina : BarResource
@export var lives : int = 3
@export var money : int = 200
@export var score : int = 0
@export var score_multiplyer : float = 1
@export var booze_lvl : int =0
@export var smoke_lvl : int =0


signal changed_stats
signal changed_stat(stat : String)
signal died

	
#static func get_global_stats() -> CharacterStats:
#	return preload("res://global_char_stats.tres")

func _init():
	stamina=preload("res://stamina_resource.tres")
	inventory=preload("res://inventory/global_inventory.tres")
	stamina.updated.connect(check_stamina)

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
	if lives>=4:
		emit_signal("died")
	return lives<=0
	

func up_booze() -> bool:
	booze_lvl+=1
	emit_signal("changed_stats")
	emit_signal("changed_stat", "booze_lvl")
	if booze_lvl>=4:
		emit_signal("died")
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
	if smoke_lvl>=4:
		emit_signal("died")
	return smoke_lvl>=4
	
func down_smoke()  :
	if (smoke_lvl>0):
		smoke_lvl-=1
	emit_signal("changed_stats")
	emit_signal("changed_stat", "smoke_lvl")

func check_stamina():
	if stamina.value<=stamina.min_value:
		emit_signal("died")
		




