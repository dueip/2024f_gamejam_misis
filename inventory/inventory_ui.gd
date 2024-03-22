extends Control

@export var inv_size : int = 2
@export var inv : Inv
var ui_slots : Array[Node]


func _ready():
	inv.slots.resize(inv_size)
	inv.updated.connect(update_slots)
	var slot=preload("res://inventory/inv_ui_slot.tscn")
	for i in range(0,inv_size):
		var new_child_node = slot.instantiate()
		new_child_node.set_position(Vector2(128*i,0))
		add_child(new_child_node)
		
	ui_slots = get_children()
	update_slots()
func update_slots():
	for i in range(0,inv_size):
		ui_slots[i].update(inv.slots[i])
		
func open():
	visible=true
	
func close():
	visible=false
