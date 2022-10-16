extends Button

export(String, FILE, "*.tscn") var next_scene = "res://Level1.tscn"

func _ready():
	connect("button_up", self, "go_to_scene")

func go_to_scene():
	get_tree().change_scene(next_scene)
