extends Node2D

@onready var visible_on_screen_notifier_2d:VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var scale_component: ScaleComponent = $ScaleComponent as ScaleComponent
@onready var flash_component: FlashComponent = $FlashComponent as FlashComponent
@onready var hitbox_component: HitboxComponent = $HitboxComponent as HitboxComponent
@onready var movement_component: MoveComponent = $MoveComponent as MoveComponent

var velocity:Vector2 = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	scale_component.tween_scale()
	flash_component.flash()
	visible_on_screen_notifier_2d.screen_exited.connect(queue_free)
	hitbox_component.hit_hurtbox.connect(queue_free.unbind(1))	
	movement_component.velocity = velocity