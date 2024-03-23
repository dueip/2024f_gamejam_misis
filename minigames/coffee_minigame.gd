extends Minigame

var is_in_mingame = false
@onready var bobber = $Fill/Bobber

	
	
	
func _ready():
	$Fill.hide()
	
func get_sprite3d_aabb(sprite3d: Sprite3D) -> AABB:
	return sprite3d.get_aabb()
	
func nextTurn(input: String):
	if not is_in_mingame:
		return
	if (input == combination[0]):
		bobber.position.y += 1
	if (input == combination[1]):
		bobber.position.y -= 1

func _process(delta):
	if not is_in_mingame:
		return
	
	bobber.position.y -= 0.1 * sin(deg_to_rad(get_viewport().get_camera_3d().rotation.y))
	bobber.position.z -= 0.1 * cos(deg_to_rad(get_viewport().get_camera_3d().rotation.z))

func _on_minigame_started(Minigame):
	$Fill.show()
	$Sprite3D.hide()
	

	$Fill.global_rotation = get_viewport().get_camera_3d().rotation 
	is_in_mingame = true
	bobber.get_node("Area3D").collision_layer = 2
	#$Fill.get_node("Area3D").collision_layer= 1
	$Fill.get_node("Area3D").collision_mask = 2



func _on_area_3d_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	endGame(false, "")
