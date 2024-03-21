extends Resource

class_name InvItem

@export var name : String = ""
@export var texture : Texture2D

static func get_item(path_name : String) -> InvItem:
	return load("res://inventory/items/" + path_name + ".tres")
