extends Sprite2D

var total_frames: int

func _ready():
	total_frames = hframes * vframes
	randomize()
	pick_random_sprite()

func pick_random_sprite():
	var random_frame = randi() % total_frames
	frame = random_frame
