extends Node
class_name MovementLockComponent

@export var actor: Node2D
@export var radial_center: Vector2
@export var max_distance: float

func _ready():
		# Initialize the center point, can be any Vector2
	if(!radial_center): radial_center = actor.get_viewport_rect().size / 2

func _process(_delta):
	# Calculate the distance from the center point
	var distance = actor.position.distance_to(radial_center)
	# If the distance is greater than the max distance, clamp it
	if distance > max_distance:
		# Calculate the direction from the center to the player
		var direction = (actor.position - radial_center).normalized()
		# Set the new position at the edge of the allowed radius
		actor.position = radial_center + direction * max_distance
