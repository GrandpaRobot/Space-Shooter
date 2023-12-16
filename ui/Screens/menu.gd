extends Control

@onready var space_background = $SpaceBackground
@onready var v_box_container = $VBoxContainer
@onready var title_label = $VBoxContainer/TitleLabel
@onready var start_label = $VBoxContainer/StartLabel

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		await fade_out_menu()


func fade_out_menu():
	tween_fade_out(title_label, 1.5)
	tween_fade_out(start_label, 1.5)
	var tween = tween_move_down(v_box_container, 40, 2.0)
	tween.finished.connect(func():
		SceneSwitcher.change_scene('res://world.tscn', {
			"space_layer": space_background.space_layer.motion_offset.y,
			"far_star_layer": space_background.far_star_layer.motion_offset.y,
			"close_star_layer": space_background.close_star_layer.motion_offset.y
		})
	)

func tween_fade_out(label: Label, time: float):
	var tween = get_tree().create_tween()\
	.tween_property(label, "modulate", Color(title_label.modulate.r, title_label.modulate.g, title_label.modulate.b, 0), time)\
	.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)

func tween_move_down(container: VBoxContainer, amount: int, time: float):
	var tween = get_tree().create_tween()\
	.tween_property(container, "position", Vector2(container.position.x, container.position.y + amount), time)\
	.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	return tween
