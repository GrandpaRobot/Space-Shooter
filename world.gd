extends Node2D

@onready var space_background = $SpaceBackground


func _ready():
	space_background.space_layer.motion_offset.y= SceneSwitcher.get_param("space_layer")
	space_background.far_star_layer.motion_offset.y = SceneSwitcher.get_param("far_star_layer")
	space_background.close_star_layer.motion_offset.y = SceneSwitcher.get_param("close_star_layer")
