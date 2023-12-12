extends Node2D
class_name PlayerShip

@onready var left_muzzle:= $WeaponsSpriteAnchor/LeftMuzzle as Marker2D
@onready var right_muzzle:= $WeaponsSpriteAnchor/RightMuzzle as Marker2D
@onready var center_forward:= $WeaponsSpriteAnchor/CenterForward as Marker2D

@onready var spawner_component: SpawnerComponent = $WeaponsSpriteAnchor/SpawnerComponent as SpawnerComponent
@onready var slash_spawner_component = $WeaponsSpriteAnchor/SlashSpawnerComponent as SpawnerComponent

@onready var scale_component = $VisualGroup/ScaleComponent as ScaleComponent
@onready var animated_sprite_2d: AnimatedSprite2D = $SpriteAnchor/AnimatedSprite2D
@onready var move_component: MoveComponent = $MovementGroup/MoveComponent as MoveComponent
@onready var left_flame = $SpriteAnchor/LeftFlame
@onready var right_flame = $SpriteAnchor/RightFlame

@onready var ability_group = $AbilityGroup
# TODO - Change this away from relative path?
@onready var ability_bar = $"../WorldUI/AbilityBar"

## TODO - Change this to something other than an array of strings? Maybe this should be an Array[Abilities]?
#@export var abilities: Array[String] = ['Slash', 'Explode']:
	## TODO - Maybe pull this out to a function instead of a setter so it can just take a string and index?
	#set(value):
		#abilities = value
		
@export var abilities: Array[Ability] = []

signal player_died

func _ready() -> void:
	# Connects to signal from UI buttons to determine when ability is cast
	var abilities_buttons = ability_bar.get_children() as Array[AbilityButton]
	for ability_button in abilities_buttons:
		ability_button.cast.connect(cast_ability)

func cast_ability(ability_name: String):
	if(!ability_name): return	
	var ability = ability_group.find_child(ability_name) as Ability
	ability.cast()
	
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
