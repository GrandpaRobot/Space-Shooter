extends Enemy

func _ready():
	super()
	move_component.velocity.x = [-30, 30].pick_random()
