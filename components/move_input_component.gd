class_name MoveInputComponent
extends Node

@export var move_component: MoveComponent

func _input(_event: InputEvent) -> void:
	if(!move_component): return
	var x_axis = Input.get_axis("ui_left", "ui_right")
	var y_axis = Input.get_axis("ui_up", "ui_down")
	move_component.velocity = Vector2(x_axis * move_component.move_stats.speed, y_axis * move_component.move_stats.speed)
