extends Area2D

export(String, FILE, "*.tscn") var next_scene

func _on_Target_body_entered(body):
	if body is Diablesse:
		get_tree().change_scene(next_scene)
