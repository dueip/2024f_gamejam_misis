extends Resource

class_name CharacterStats

@export var inventory : Inv
@export var lives : int = 3
@export var stamina : BarResource
@export var score : int =0 

signal changed_stats
