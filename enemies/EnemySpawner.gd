extends Node2D

@export var GreenEnemyScene: PackedScene
@onready var green_enemy_timer = $Timer
@onready var spawner_component:= $SpawnerComponent as SpawnerComponent

var margin = 8
var screen_width = ProjectSettings.get_setting("display/window/size/viewport_width")

# Called when the node enters the scene tree for the first time.
func _ready():
	green_enemy_timer.timeout.connect(handle_spawn.bind(GreenEnemyScene, green_enemy_timer))

func handle_spawn(enemy_scene: PackedScene, timer: Timer) -> void:
	spawner_component.scene = enemy_scene
	spawner_component.spawn(Vector2(randf_range(margin, screen_width - margin), -16))
	timer.start()
	
