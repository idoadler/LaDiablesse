extends Area2D


func _on_Target_body_entered(body):
	if body is Diablesse:
		get_tree().reload_current_scene()
