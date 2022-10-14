extends CharacterBody2D
class_name Diablesse

const SPEED = 150.0
const JUMP_VELOCITY = -400.0

var speed_modifier = 1.0
var speed = 250

#func get_input():
#	# Detect up/down/left/right keystate and only move when pressed.
#	velocity = Vector2()
#	if Input.is_action_pressed('ui_right'):
#		velocity.x += 1
#	if Input.is_action_pressed('ui_left'):
#		velocity.x -= 1
#	if Input.is_action_pressed('ui_down'):
#		velocity.y += 1
#	if Input.is_action_pressed('ui_up'):
#		velocity.y -= 1
#	velocity = velocity.normalized() * speed
#
#func _physics_process(delta):
#	get_input()
#	move_and_collide(velocity * delta)


func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if direction:
		velocity = direction * SPEED * speed_modifier
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)
	move_and_slide()

func set_area(woods:bool):
	if woods:
		speed_modifier = 0.3
	else:
		speed_modifier = 1
