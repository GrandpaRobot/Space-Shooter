extends TextureRect



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.material.set_shader_parameter("node_size", self.size)

