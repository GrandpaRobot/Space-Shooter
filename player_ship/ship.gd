extends Node2D
class_name PlayerShip

@onready var left_muzzle:= $WeaponsSpriteAnchor/LeftMuzzle as Marker2D
@onready var right_muzzle:= $WeaponsSpriteAnchor/RightMuzzle as Marker2D
@onready var center_forward:= $WeaponsSpriteAnchor/CenterForward as Marker2D

@onready var spawner_component: SpawnerComponent = $WeaponsSpriteAnchor/LaserSpawnerComponent as SpawnerComponent

@onready var scale_component = $VisualGroup/ScaleComponent as ScaleComponent
@onready var animated_sprite_2d: AnimatedSprite2D = $SpriteAnchor/AnimatedSprite2D
@onready var move_component: MoveComponent = $MovementGroup/MoveComponent as MoveComponent
@onready var left_flame = $SpriteAnchor/LeftFlame
@onready var right_flame = $SpriteAnchor/RightFlame

@export var ability_bar: AbilityBar
@export var abilities: Array[AbilityData]

signal player_died
signal player_moved

func _ready() -> void:
	# Connects to signal from UI buttons to determine when ability is cast
	var abilities_buttons = ability_bar.get_children() as Array[AbilityButton]
	for ability_button in abilities_buttons:
		ability_button.used.connect(cast_ability)

func cast_ability(ability: AbilityData):
	if(!ability): return
	if(ability.scene):
		var instance = ability.scene.instantiate()
		center_forward.add_child(instance)
	if(ability.ability_script):
		ability.ability_script.cast(self)

func fire_lasers() -> void:
	scale_component.tween_scale()
	spawner_component.spawn(left_muzzle.global_position)
	spawner_component.spawn(right_muzzle.global_position)

func _process(_delta: float) -> void:
	animate_ship()

func animate_ship() -> void:
	if move_component.velocity.x < 0:
		animated_sprite_2d.play('bank_left')
		left_flame.play("bank_left")
		right_flame.play("bank_left")
	elif move_component.velocity.x > 0:
		animated_sprite_2d.play('bank_right')
		left_flame.play("bank_right")
		right_flame.play("bank_right")
	else:
		animated_sprite_2d.play("center")
		left_flame.play("center")
		right_flame.play("center")

func _on_tree_exiting():
	emit_signal('player_died')
