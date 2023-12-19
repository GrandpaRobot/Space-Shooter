extends Control

const Util = preload("res://utility/tweens.gd")
const world = preload("res://levels/space/world.tscn")

@onready var space_background = $SpaceBackground
@onready var label_container = $VBoxContainer
@onready var title_label = $VBoxContainer/TitleLabel
@onready var start_label = $VBoxContainer/StartLabel

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		await fade_out_menu()

func fade_out_menu():
	# Fades labels out
	Util.tween_fade_out(get_tree().create_tween(), title_label, 1.5)
	Util.tween_fade_out(get_tree().create_tween(), start_label, 1.5)
	# Lowers labels
	var tween = get_tree().create_tween()\
		.tween_property(label_container, 'position', Vector2(label_container.global_position.x, label_container.global_position.y + 40), 2.0)
	# When tween is finished, change scene
	tween.finished.connect(func():
		SceneSwitcher.change_scene(world, {
			"space_layer": space_background.space_layer.motion_offset.y,
			"far_star_layer": space_background.far_star_layer.motion_offset.y,
			"close_star_layer": space_background.close_star_layer.motion_offset.y
		})
	)
