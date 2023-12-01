extends Node2D

@onready var left_muzzle: Marker2D = $LeftMuzzle
@onready var right_muzzle: Marker2D = $RightMuzzle
@onready var spawner_component: SpawnerComponent = $SpawnerComponent as SpawnerComponent
@onready var fire_rate_timer: Timer = $FireRateTimer
@onready var scale_component = $ScaleComponent as ScaleComponent
@onready var animated_sprite_2d: AnimatedSprite2D = $Anchor/AnimatedSprite2D
@onready var move_component: MoveComponent = $MoveComponent as MoveComponent
@onready var left_flame = $Anchor/LeftFlame
@onready var right_flame = $Anchor/RightFlame

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fire_rate_timer.timeout.connect(fire_lasers)
	pass # Replace with function body.

func fire_lasers() -> void:
	scale_component.tween_scale()
	spawner_component.spawn(left_muzzle.global_position)
	spawner_component.spawn(right_muzzle.global_position)

func _process(delta: float) -> void:
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
	
