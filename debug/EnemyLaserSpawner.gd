extends Node2D
class_name EnemyLaserSpawner


@onready var timer = $Timer
@onready var spawner_component:= $SpawnerComponent as SpawnerComponent

@export var delay: int
@export var velocity: Vector2

const ENEMY_LASER = preload("res://projectiles/enemy-laser.tscn")

func _ready():
	spawner_component.scene = ENEMY_LASER
	await get_tree().create_timer(delay).timeout
	handle_spawn()
	timer.timeout.connect(handle_spawn)

func handle_spawn() -> void:
	spawner_component.spawn(self.global_position,get_tree().current_scene, velocity)
	timer.start()

