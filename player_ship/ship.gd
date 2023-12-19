extends Node2D
class_name PlayerShip

@onready var left_muzzle:= $WeaponsSpriteAnchor/LeftMuzzle as Marker2D
@onready var right_muzzle:= $WeaponsSpriteAnchor/RightMuzzle as Marker2D
@onready var center_forward:= $WeaponsSpriteAnchor/CenterForward as Marker2D

@onready var spawner_component: SpawnerComponent = $WeaponsSpriteAnchor/LaserSpawnerComponent as SpawnerComponent

@onready var scale_component = $VisualGroup/ScaleComponent as ScaleComponent
@onready var move_component: MoveComponent = $MovementGroup/MoveComponent as MoveComponent

@onready var ship_sprite: Node2D = $Sprite

@export var ability_bar: AbilityBar
@export var abilities: Array[AbilityData]

signal player_died
signal player_moved

func _ready() -> void:
	# Connects to signal from UI buttons to determine when ability is cast
	if(ability_bar):
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
	ship_sprite.animate_ship(move_component.velocity.x, move_component.velocity.y)

func _on_tree_exiting():
	emit_signal('player_died')
