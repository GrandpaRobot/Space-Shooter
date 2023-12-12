extends Node2D

@onready var stats_component:= $StatsComponents/HealthStatsComponent as StatsComponent
@onready var move_component:=  $StateComponents/MoveComponent as MoveComponent
@onready var flash_component: =  $VisualComponents/FlashComponent as FlashComponent
@onready var shake_component:= $VisualComponents/ShakeComponent as ShakeComponent
@onready var scale_component:= $VisualComponents/ScaleComponent as ScaleComponent
@onready var visible_on_screen_notifier_2d:= $VisibleOnScreenNotifier2D as VisibleOnScreenNotifier2D
@onready var hitbox_component:= $HitboxComponent as HitboxComponent
@onready var hurtbox_component:= $HurtboxComponent as HurtboxComponent
@onready var destroyed_component:=  $StateComponents/DestroyedComponent as DestroyedComponent
@onready var score_component = $ScoreComponent as ScoreComponent

func _ready() -> void:
	# When enemy leaves screen, destroy from memory
	visible_on_screen_notifier_2d.screen_exited.connect(queue_free)
	# Visual changes for getting hurt
	hurtbox_component.hurt.connect(func(_hitbox: HitboxComponent):
		scale_component.tween_scale()
		flash_component.flash()
		shake_component.tween_shake()
	)
	# On enemy death...
	stats_component.no_health.connect(func():
		# Add to score
		score_component.adjust_score()
		# Destroy from memory
		queue_free()
	)
	hitbox_component.hit_hurtbox.connect(destroyed_component.destroy.unbind(1))
	# Move downard
	move_component.velocity = Vector2(0, move_component.move_stats.speed)
