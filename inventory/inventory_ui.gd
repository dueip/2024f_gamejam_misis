extends Control

@onready var inv_size : int = 2

var ui_slots : Array[Node]
@onready var inv : Inv = preload("res://inventory/global_inventory.tres")

func _ready():
	inv.updated.connect(update_slots)
	var slot=preload("res://inventory/inv_ui_slot.tscn")
	for i in range(0,inv_size):
		var new_child_node = slot.instantiate()
		new_child_node.set_position(Vector2(144*i,0))
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
