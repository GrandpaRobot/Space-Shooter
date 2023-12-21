extends Node2D

@export var GreenEnemyScene: PackedScene
@export var YellowEnemyScene: PackedScene
@export var PinkEnemyScene: PackedScene
@onready var enemy_timer = $Timer
@onready var spawner_component:= $SpawnerComponent as SpawnerComponent

@export var stop_spawning = false

var margin = 8
var screen_width = ProjectSettings.get_setting("display/window/size/viewport_width")

# Called when the node enters the scene tree for the first time.
func _ready():
	enemy_timer.timeout.connect(handle_spawn.bind(enemy_timer))

func handle_spawn(timer: Timer) -> void:
	var which_enemy = randf()
	if(randf() > .8):
		spawner_component.scene = PinkEnemyScene
	elif(which_enemy > .6):
		spawner_component.scene = YellowEnemyScene
	else:
		spawner_component.scene = GreenEnemyScene
	if(!stop_spawning):
		spawner_component.spawn(Vector2(randf_range(margin, screen_width - margin), -16))
	timer.start()

