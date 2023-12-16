extends Node2D

@export var GreenEnemyScene: PackedScene
@export var YellowEnemyScene: PackedScene
@onready var enemy_timer = $Timer
@onready var spawner_component:= $SpawnerComponent as SpawnerComponent

@export var stop_spawning = false

var margin = 8
var screen_width = ProjectSettings.get_setting("display/window/size/viewport_width")

# Called when the node enters the scene tree for the first time.
func _ready():
	enemy_timer.timeout.connect(handle_spawn.bind(enemy_timer))

func handle_spawn(timer: Timer) -> void:
	if(randf() > .7):
		spawner_component.scene = YellowEnemyScene
	else:
		spawner_component.scene = GreenEnemyScene
	# NOTE CRITICAL - Get rid of the 16s in the x-axis. Meant to be "safe places" for debugging. Also maybe remove stop_spawning as well
	if(!stop_spawning):
		spawner_component.spawn(Vector2(randf_range(margin + 16, screen_width - margin - 16 ), -16))
	timer.start()

