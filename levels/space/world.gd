extends Node2D

@onready var space_background = $SpaceBackground
@onready var player_ship = $Ship
@onready var ui = $WorldUI

func _ready():
	ui.visible = false
	var tween = get_tree().create_tween()\
		.tween_property(player_ship.move_component, "velocity", Vector2(player_ship.move_component.velocity.x, player_ship.move_component.velocity.y + -150), 1.0)\
		.set_trans(Tween.TRANS_LINEAR)\
		.set_ease(Tween.EASE_IN_OUT)

	tween.finished.connect(func():
		ui.visible = true
		player_ship.move_component.velocity.y = 0
	)
