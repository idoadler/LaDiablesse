extends Area2D

onready var music = $"/root/Music"

export(String, FILE, "*.tscn") var next_scene

func _on_Target_body_entered(body):
	if body is Diablesse:
		music.end_level(1)
		get_tree().change_scene(next_scene)
