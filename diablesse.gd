extends KinematicBody2D
class_name Diablesse

const SPEED = 250.0
const JUMP_VELOCITY = -400.0
export var SEEN_DISTANCES = [50.0, 80.0, 140.0, 200.0]
const SEEN_REFERENCE = 230.0

onready var music = $"/root/Music"
onready var light = $"Light2D"

var seen_distance = 230
var speed_modifier = 1.0
var velocity = Vector2()
var step_time = 0.0
var woods = false

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if direction:
		velocity = direction * SPEED * speed_modifier
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)
	velocity = move_and_slide(velocity)
	if velocity.length() > 1:
		step_time += delta
		if step_time > 50 / velocity.length():
			music.play_step()
			step_time = 0
	else:
		step_time = 1
	update_distance()

var last_dist = -1

func update_distance():
	var dist = 0
	if !woods:
		dist += 2
	if velocity.length() > 1:
		dist += 1
	if dist != last_dist:
		last_dist = dist
		seen_distance = SEEN_DISTANCES[dist]
		light.texture_scale = seen_distance / SEEN_REFERENCE	

func set_area(grass:bool):
	woods=grass
	music.on_grass = woods
	if woods:
		speed_modifier = 0.6
	else:
		speed_modifier = 1
	update_distance()
