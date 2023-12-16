extends Ability

@onready var timer = $DisappearTimer
@onready var collision_shape_2d = $HitboxComponent/CollisionShape2D
@onready var polygon_2d = $Polygon2D

var initial_global_position

func _ready():
	initial_global_position = polygon_2d.global_position
	await timer.timeout
	queue_free()

func _physics_process(_delta):
	polygon_2d.global_position = initial_global_position
	polygon_2d.scale = polygon_2d.scale * 1.05
	collision_shape_2d.scale = collision_shape_2d.scale * 1.05
	collision_shape_2d.global_position = initial_global_position
	
