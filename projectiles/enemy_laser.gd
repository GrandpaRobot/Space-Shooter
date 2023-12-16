extends Node2D
class_name EnemyLaser

@onready var visible_on_screen_notifier_2d:VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var hitbox_component: HitboxComponent = $HitboxComponent as HitboxComponent
@onready var move_component = $MoveComponent as MoveComponent

@export var velocity: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	# TODO - Temporary, maybe? This was for setting up my laser spawners
	move_component.velocity = velocity
	visible_on_screen_notifier_2d.screen_exited.connect(queue_free)
	hitbox_component.hit_hurtbox.connect(queue_free.unbind(1))	
