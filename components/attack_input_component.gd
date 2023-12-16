class_name AttackInputComponent
extends Node

@export var actor: Node2D
@export var fire_rate_timer: Timer
	
func _physics_process(_delta):
	if(Input.is_action_pressed("fire") && fire_rate_timer.is_stopped()):
		# TODO type-safe this. Either change ship to not Node2D or account for non-player ships here?
		actor.fire_lasers()
		fire_rate_timer.start()
