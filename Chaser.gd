extends KinematicBody2D
class_name Chaser

onready var obstacle:Obstacle# = $"../MovingObstacle"
onready var demon:Diablesse = $"../../../Diablesse"
onready var music = $"/root/Music"
var chasing = false

# Called when the node enters the scene tree for the first time.
func _ready():
	obstacle = get_parent()

func _process(delta):
	var dist = global_position.distance_to(demon.global_position)
	if chasing:
		if dist > demon.seen_distance:
			chasing = false
		else:
			var velocity = global_position.direction_to(demon.global_position) * obstacle.speed
			velocity = move_and_slide(velocity)
			if dist < 50:
				music.end_level(0)
				get_tree().reload_current_scene()
	else:
		if dist < demon.seen_distance:
			chasing = true
			obstacle.chase = true
		else:
			if position.distance_to(Vector2.ZERO) > 5:
				var velocity = position.direction_to(Vector2.ZERO) * obstacle.speed * delta
				position += velocity
			elif position.distance_to(Vector2.ZERO) > 3:
				position = Vector2.ZERO
				obstacle.chase = false
