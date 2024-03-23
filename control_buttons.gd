extends Control

@export var button_name: String
@onready var text_label: RichTextLabel = $ColorRect/RichTextLabel

func _ready():
	text_label.push_color(Color(255,255,255))
	text_label.push_outline_color(Color(0,0,0))
	text_label.push_outline_size(10)
	text_label.append_text("[center]")
	text_label.append_text(button_name)
	text_label.pop()	
	text_label.pop()
	text_label.pop()
	text_label.pop()
