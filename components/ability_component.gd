class_name AbilityComponent
extends Node

@export var ability_name: String = "~~~"
@export var cooldown: float = 200.0
@export var image: Texture2D = preload("res://assets/wave-strike.png")
@export var origin_place: Vector2

func get_info() -> AbilityComponent:
	return self

func activate():
	#slash_spawner_component.spawn(center_forward.global_position)
	pass
