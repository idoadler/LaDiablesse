extends PathFollow2D
class_name Obstacle

export var speed:int = 200
onready var sprite = $"KinematicBody2D/Sprite"

var chase:bool = false
var forward:bool = true
var turn_time = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	turn_time += delta
	if turn_time > 0.3*200/speed:
		sprite.scale.x = -sprite.scale.x
		turn_time = 0
	if !chase:
		if forward:
			offset += delta * speed
			if unit_offset >= 1:
				forward = false
		else:
			offset -= delta * speed
			if unit_offset <= 0:
				forward = true
