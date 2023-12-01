extends ParallaxBackground

@onready var space_layer:ParallaxLayer = %SpaceLayer as ParallaxLayer
@onready var close_star_layer:ParallaxLayer = %CloseStarLayer as ParallaxLayer
@onready var far_star_layer:ParallaxLayer = %FarStarLayer as ParallaxLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	space_layer.motion_offset.y += 2 * delta
	far_star_layer.motion_offset.y += 5 * delta
	close_star_layer.motion_offset.y += 20 * delta
