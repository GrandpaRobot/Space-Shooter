extends TextureRect

@export var fill_color: Vector4 # A Plane can equate to a vec4 inside the shader

func _ready():
	self.material.set_shader_parameter('fill_color', fill_color)
