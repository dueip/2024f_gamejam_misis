extends Node

var current_scene = null
var prev_scene = null

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)

func switch_visibily_ui():
	print("here")
	var ui = get_tree().get_nodes_in_group("UI")
	for n in ui:
		n.visible=!n.visible

func chane_scene_to_instance(instance):
	# Hide the current scene
	current_scene.hide()
	current_scene.process_mode = PROCESS_MODE_DISABLED
	
	# Load the new scene
	var new_scene = (instance)
	switch_visibily_ui()
	# Add the new scene to the root
	get_tree().get_root().add_child(new_scene)
	
	# Set the new scene as the current scene
	prev_scene = current_scene
	current_scene = new_scene

func change_scene_baked(baked: Resource):
	# Hide the current scene
	current_scene.hide()
	current_scene.process_mode = PROCESS_MODE_DISABLED
	
	# Load the new scene
	var new_scene = (baked).instantiate()
	switch_visibily_ui()
	# Add the new scene to the root
	get_tree().get_root().add_child(new_scene)
	
	# Set the new scene as the current scene
	prev_scene = current_scene
	current_scene = new_scene

func change_scene(path: String):
	# Hide the current scene
	current_scene.hide()
	current_scene.process_mode = PROCESS_MODE_DISABLED
	
	# Load the new scene
	var new_scene = load(path).instantiate()
	switch_visibily_ui()
	# Add the new scene to the root
	get_tree().get_root().add_child(new_scene)
	
	# Set the new scene as the current scene
	prev_scene = current_scene
	current_scene = new_scene

func revertScene():
	# Ensure the previous scene is enabled and visible
	prev_scene.show()
	prev_scene.process_mode = PROCESS_MODE_ALWAYS
	switch_visibily_ui()
	# Optionally, hide the current scene
	current_scene.hide()
	current_scene.process_mode = PROCESS_MODE_DISABLED
	current_scene.queue_free()
	# Swap the scenes
	var swap_scene = prev_scene
	prev_scene = current_scene
	current_scene = swap_scene
