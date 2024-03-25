extends Area3D

var is_body_in: bool = false

func _process(delta):
	if not is_body_in:
		return
	var a: Character = get_tree().get_first_node_in_group("Player") as Character
	a.stats.stamina.gain(a.stamina_lose.stamina_lose_on_sprint)

func _on_body_entered(body):
	if body is Character:
		is_body_in = true
		var tween = get_tree().create_tween()
		tween.tween_callback($SpotLight3D.show).set_delay(0.1)
		


func _on_body_exited(body):
	if body is Character:
		is_body_in = false
		$SpotLight3D.hide()
