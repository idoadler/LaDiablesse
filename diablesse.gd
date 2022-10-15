extends KinematicBody2D
class_name Diablesse

const SPEED = 150.0
const JUMP_VELOCITY = -400.0

onready var music:Music = $"../Music"

var speed_modifier = 1.0
var speed = 250
var velocity = Vector2()
var step_time = 0.0

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if direction:
		velocity = direction * SPEED * speed_modifier
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)
	move_and_slide(velocity)
	if velocity.length() > 1:
		step_time += delta
		if step_time > 30 / velocity.length():
			music.play_step()
			step_time = 0
	else:
		step_time = 1

func set_area(woods:bool):
	music.on_grass = woods
	if woods:
		speed_modifier = 0.3
	else:
		speed_modifier = 1
