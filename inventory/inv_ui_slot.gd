extends Panel

@onready var item_visual : Sprite2D = $CenterContainer/Panel/item
@onready var item_amount_visual : Label = $CenterContainer/Panel/Amount
@onready var right_scale=item_visual.transform.scaled_local(Vector2(0.5,0.5))

func update(item : InvSlot):
	if (!item or item.amount==0):
		item_visual.visible=false
		item_amount_visual.visible=false
	else:
		item_visual.visible=true
		item_visual.transform=right_scale
		item_visual.centered=true
		item_amount_visual.visible=true
		item_visual.texture=item.item.texture
		item_amount_visual.text=str(item.amount)
		
