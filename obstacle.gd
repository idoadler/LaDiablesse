extends PathFollow2D
class_name Obstacle

@export var speed:int = 200

var forward:bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if forward:
		progress += delta * speed
		if progress_ratio >= 1:
			forward = false
	else:
		progress -= delta * speed
		if progress_ratio <= 0:
			forward = true
