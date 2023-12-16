extends ParallaxBackground

@onready var space_layer:ParallaxLayer = %SpaceLayer as ParallaxLayer
@onready var close_star_layer:ParallaxLayer = %CloseStarLayer as ParallaxLayer
@onready var far_star_layer:ParallaxLayer = %FarStarLayer as ParallaxLayer

func _process(delta):
	space_layer.motion_offset.y += 2 * delta
	far_star_layer.motion_offset.y += 5 * delta
	close_star_layer.motion_offset.y += 20 * delta
