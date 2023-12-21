extends Line2D

@export var actor: Node2D

func _ready() -> void:
	self.points[0] = get_viewport_rect().size / 2

func _process(_delta: float) -> void:
	self.points[1] = actor.position
