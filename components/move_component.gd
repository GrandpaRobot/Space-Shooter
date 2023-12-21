class_name MoveComponent
extends Node

@export var actor: Node2D
@export var velocity: Vector2
@export var move_stats: MoveStats

func _process(delta: float) -> void:
	# TODO - I think this is wrong, because it allows for diagonal movement to be faster than horizontal/vertical movement?
	actor.translate(velocity * delta)
