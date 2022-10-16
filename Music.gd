extends Node

onready var ambience_body = preload("res://sound/music/ambienceBODY.ogg")
onready var ambience_head = preload("res://sound/music/ambienceHEAD.ogg")
onready var ambience_player = $"Ambience"
onready var grass_body = preload("res://sound/music/onGrassBODY.ogg")
onready var grass_head = preload("res://sound/music/onGrassHEAD.ogg")
onready var grass_player = $"Grass"
onready var road_body = preload("res://sound/music/onRoadBODY.ogg")
onready var road_head = preload("res://sound/music/onRoadHEAD.ogg")
onready var road_player = $"Road"
onready var grass_steps = [preload("res://sound/steps/grassStep1.mp3"),
						   preload("res://sound/steps/grassStep2.mp3"),
						   preload("res://sound/steps/grassStep3.mp3")]
onready var road_steps = [preload("res://sound/steps/roadStep1.mp3"),
						  preload("res://sound/steps/roadStep2.mp3"),
						  preload("res://sound/steps/roadStep3.mp3")]
onready var endings = [preload("res://sound/womanScream.mp3"),preload("res://sound/manScream.mp3")]
onready var sfx_player = $"SFX"
onready var sfx2_player = $"SFX2"
var music_position = 0
var playing = false
var paused = false
var on_grass = true
var road_transition = 0.0
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	ambience_player.connect("finished", self, "_start_body_loop")
	set_road_volume(0)
	sfx_player.volume_db = linear2db(0.5)
	set_play(true)
	
func _process(delta):	
	if on_grass and road_transition > 0:
		road_transition -= delta
		set_road_volume(road_transition)
	elif !on_grass and road_transition < 1:
		road_transition += delta
		set_road_volume(road_transition)

func _start_body_loop():
	if playing and not paused:
		ambience_player.stream = ambience_body
		ambience_player.play()
		grass_player.stream = grass_body
		grass_player.play()
		road_player.stream = road_body
		road_player.play()

func set_play(button_pressed):
	if(button_pressed):
		playing = true
		ambience_player.stream = ambience_head
		grass_player.stream = grass_head
		road_player.stream = road_head
		if paused:
			set_pause(true)
		else:
			ambience_player.play()
			grass_player.play()
			road_player.play()
	else:
		playing = false
		ambience_player.stop()
		grass_player.stop()
		road_player.stop()
		sfx_player.stop()
		music_position = 0

func set_master_volume(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear2db(value))


func set_pause(button_pressed):
	if button_pressed:
		paused = true
		music_position = ambience_player.get_playback_position()
		ambience_player.stop()
		grass_player.stop()
		road_player.stop()
		sfx_player.stop()
	else:
		paused = false
		if playing:
			ambience_player.play(music_position)
			grass_player.play(music_position)
			road_player.play(music_position)

func set_road_volume(value):
	road_player.volume_db = linear2db(clamp(value,0,1))

func play_step():
	if paused or !playing:
		return
	if sfx_player.playing:
		return
	sfx_player.pitch_scale = rng.randf_range(0.5,2)
	if on_grass:
		sfx_player.stream = grass_steps[rng.randi_range(0, grass_steps.size()-1)]
	else:
		sfx_player.stream = road_steps[rng.randi_range(0, road_steps.size()-1)]
	sfx_player.play()	

func _notification(what: int) -> void:
	match what:
		NOTIFICATION_WM_FOCUS_OUT:
			AudioServer.set_bus_mute(0, true) # 0 = master bus, probably
		NOTIFICATION_WM_FOCUS_IN:
			AudioServer.set_bus_mute(0, false)

func end_level(ending):
	on_grass = true
	if paused or !playing:
		return
	sfx2_player.pitch_scale = rng.randf_range(0.8,1.2)
	sfx2_player.stop()
	sfx2_player.stream = endings[ending]
	sfx2_player.play()
