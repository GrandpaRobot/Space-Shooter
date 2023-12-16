extends GPUParticles2D

@export var velocity: Vector2
const SHIELD_HIT = preload("res://effects/shield_hit.tres")

func _ready():
	SHIELD_HIT.set_direction(Vector3(-velocity.x, -velocity.y, 0))
	self.process_material = SHIELD_HIT
	self.emitting = true
