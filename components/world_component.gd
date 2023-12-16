class_name WorldComponent
extends Node

@onready var player = $"../Ship"

func _ready():
	player.connect("player_died", game_over)

func game_over():
	# I don't know why, was getting a weird error when closing the game
	if(!get_tree()): return
	await get_tree().create_timer(2.0).timeout
	get_tree().change_scene_to_file('res://ui/Screens/game_over.tscn')
