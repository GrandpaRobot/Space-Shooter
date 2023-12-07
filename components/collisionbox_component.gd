# Give the component a class name so it can be instanced as a custom node
class_name CollisionBoxComponent
extends Area2D

# Create a signal for when this collision box is hit by a hitbox
signal collided(hitbox)

func _ready():
	# Connect on area entered to our hurtbox entered function
	area_entered.connect(_on_collision)

func _on_collision(hurtbox: HurtboxComponent):
	# Make sure the area we are overlapping is a hurtbox
	if not hurtbox is HurtboxComponent: return
	# Have the hurtbox signal out that it was hit
	collided.emit(hurtbox)
	
