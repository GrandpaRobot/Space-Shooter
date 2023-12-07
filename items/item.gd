extends Node2D

@onready var move_component := $MoveComponent as MoveComponent
@onready var flash_component := $FlashComponent as FlashComponent
@onready var scale_component := $ScaleComponent as ScaleComponent
@onready var collision_box_component = $CollisionBoxComponent as CollisionBoxComponent
@onready var visible_on_screen_notifier_2d := $VisibleOnScreenNotifier2D as VisibleOnScreenNotifier2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible_on_screen_notifier_2d.screen_exited.connect(queue_free)
	move_component.velocity = Vector2(0, move_component.move_stats.speed)
	# This hurtbox is the thing that this item ran into (i.e. player/enemy/etc)
	collision_box_component.collided.connect(func(_hurtbox: HurtboxComponent):
		scale_component.tween_scale()
		await flash_component.flash()
		queue_free()
	)

