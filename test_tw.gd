extends Node3D


@onready var SceneManager = $SceneManager


func _input(event):
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_RIGHT:
		SceneManager.change_scene("res://exam_minigame.tscn")
