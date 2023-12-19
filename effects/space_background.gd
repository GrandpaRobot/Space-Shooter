extends ParallaxBackground

@onready var space_layer:ParallaxLayer = %SpaceLayer as ParallaxLayer
@onready var close_star_layer:ParallaxLayer = %CloseStarLayer as ParallaxLayer
@onready var far_star_layer:ParallaxLayer = %FarStarLayer as ParallaxLayer

func _ready():
	var space_layer_param = SceneSwitcher.get_param("space_layer")
	var far_star_param = SceneSwitcher.get_param("far_star_layer")
	var close_star_param = SceneSwitcher.get_param("close_star_layer")
	space_layer.motion_offset.y = space_layer_param if space_layer_param != null else 0
	close_star_layer.motion_offset.y = close_star_param if close_star_param != null else 0
	far_star_layer.motion_offset.y = far_star_param if far_star_param != null else 0

func _process(delta):
	space_layer.motion_offset.y += 2 * delta
	far_star_layer.motion_offset.y += 5 * delta
	close_star_layer.motion_offset.y += 20 * delta
