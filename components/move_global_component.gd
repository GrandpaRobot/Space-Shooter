extends Node
class_name MoveGlobal

@export var actor: Node2D
@export var move_stats: MoveStats

func _ready():
	if(!actor.isFishing): set_process(false)

func _process(delta: float) -> void:
	var target_position = actor.get_viewport_rect().size / 2
	var direction = (target_position - actor.global_position).normalized()
	actor.position += direction * move_stats.speed * delta
