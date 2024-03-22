extends Panel

@onready var item_visual : TextureRect = $Item
@onready var item_amount_visual : Label = $Item/Amount


func update(item : InvSlot):
	if (!item or (item.amount==0 and item.clear_if_empty==true)):
		item_visual.visible=false
		item_amount_visual.visible=false
	else:
		item_visual.visible=true
		if (item.capacity>1):
			item_amount_visual.visible=true
		else:
			item_amount_visual.visible=false
		item_visual.texture=item.item.texture
		item_amount_visual.text=str(item.amount)
		tooltip_text=item.item.name
		
