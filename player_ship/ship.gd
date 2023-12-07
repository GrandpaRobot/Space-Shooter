extends Node2D

@onready var left_muzzle:= $WeaponsSpriteAnchor/LeftMuzzle as Marker2D
@onready var right_muzzle:= $WeaponsSpriteAnchor/RightMuzzle as Marker2D
@onready var center_forward:= $WeaponsSpriteAnchor/CenterForward as Marker2D

@onready var spawner_component: SpawnerComponent = $WeaponsSpriteAnchor/SpawnerComponent as SpawnerComponent
@onready var slash_spawner_component = $WeaponsSpriteAnchor/SlashSpawnerComponent as SpawnerComponent

@onready var fire_rate_timer: Timer = $WeaponsGroup/FireRateTimer
@onready var scale_component = $VisualGroup/ScaleComponent as ScaleComponent
@onready var animated_sprite_2d: AnimatedSprite2D = $SpriteAnchor/AnimatedSprite2D
@onready var move_component: MoveComponent = $MovementGroup/MoveComponent as MoveComponent
@onready var left_flame = $SpriteAnchor/LeftFlame
@onready var right_flame = $SpriteAnchor/RightFlame

@onready var ability_1_lockout_timer := $AbilitiesGroup/Ability1LockoutTimer as Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fire_rate_timer.timeout.connect(fire_lasers)

func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("ui_accept") && ability_1_lockout_timer.is_stopped()): slash()

func fire_lasers() -> void:
	#scale_component.tween_scale()
	spawner_component.spawn(left_muzzle.global_position)
	spawner_component.spawn(right_muzzle.global_position)

func slash() -> void:
	ability_1_lockout_timer.start()
	slash_spawner_component.spawn(center_forward.global_position)
	pass
	
func _process(_delta: float) -> void:
	animate_ship()
	
func animate_ship() -> void:
	if move_component.velocity.x < 0:
		#animated_sprite_2d.play('bank_left')
		left_flame.play("bank_left")
		right_flame.play("bank_left")
	elif move_component.velocity.x > 0:
		#animated_sprite_2d.play('bank_right')
		left_flame.play("bank_right")
		right_flame.play("bank_right")
	else:
		animated_sprite_2d.play("center")
		left_flame.play("center")
		right_flame.play("center")
	
