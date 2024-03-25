extends Resource

class_name Inv

signal updated
signal updated_slot(action,item_name)
signal failed_update_slot(action)

@export var slots : Array[InvSlot]


func add(item : InvItem) -> bool:
	var itemslots=slots.filter(func(slot) : return slot.item==item and slot.amount<slot.capacity)
	if !itemslots.is_empty():
		itemslots[0].amount+=1
		emit_signal("updated_slot", "add", item.name)
		emit_signal("updated")
		return 1
	else:
		var emptyslots=slots.filter(func(slot) : return slot==null or slot.item==null or (slot.amount==0 and slot.clear_if_empty==true))
		if !emptyslots.is_empty():
			emptyslots[0].amount=1
			emptyslots[0].item=item
			emit_signal("updated_slot", "add", item.name)
			emit_signal("updated")
			return 1
		else:
			emit_signal("failed_update_slot","add")
			return 0

func use(item : InvItem) -> bool:
	var itemslots=slots.filter(func(slot) : return slot.item==item && slot.amount>0)
	if !itemslots.is_empty():
		itemslots[0].amount-=1
		emit_signal("updated_slot", "use", item.name)
		emit_signal("updated")
		return 1
	else:
		emit_signal("failed_update_slot","use")
		return 0

func use_index(index : int) -> bool:
	if (index < 0 or index>=slots.size()):
		emit_signal("failed_update_slot","use")
		return false
	if slots[index]==null:
		emit_signal("failed_update_slot","use")
		return false
	if slots[index].amount<=0:
		emit_signal("failed_update_slot","use")
		return false
	slots[index].amount-=1
	emit_signal("updated_slot", "use", slots[index].item.name)
	emit_signal("updated")
	
	
	return true
