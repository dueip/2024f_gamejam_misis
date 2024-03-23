extends Control

@export var button_name: String
@onready var text_label: RichTextLabel = $Panel/RichTextLabel
@onready var stylebox : StyleBox

func _ready():
	stylebox=StyleBoxFlat.new()
	stylebox.set_corner_radius_all(3)
	stylebox.set_border_width_all(3)
	stylebox.border_color=Color(0,0,0)
	$Panel["theme_override_styles/panel"]=stylebox
	unhighlight()


func unhighlight(color: Color = Color(0.745, 0.745, 0.745)):
	stylebox.bg_color=color
	text_label.clear()
	text_label.push_color(Color(255,255,255))
	text_label.push_outline_color(Color(0,0,0))
	text_label.push_outline_size(4)
	text_label.push_font_size(16)
	text_label.append_text("[center]")
	text_label.append_text(button_name)
	text_label.pop()
	text_label.pop()
	text_label.pop()
	text_label.pop()
	text_label.pop()
	
func highlight(color: Color = Color(0.874, 0.941, 0.996) ):
	stylebox.bg_color=color
	text_label.clear()
	text_label.push_color(Color(255,255,255))
	text_label.push_outline_color(Color(0,0,0))
	text_label.push_outline_size(8)
	text_label.append_text("[center]")
	text_label.push_font_size(17)
	text_label.append_text(button_name)
	text_label.pop()
	text_label.pop()
	text_label.pop()
	text_label.pop()
	text_label.pop()	
	



