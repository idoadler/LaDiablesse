extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", self, "_on_body_entered")
	connect("body_exited", self, "_on_body_exited")

func _on_body_entered(body):
	if body is Diablesse:
		body.set_area(true)


func _on_body_exited(body):
	if body is Diablesse:
		body.set_area(false)
