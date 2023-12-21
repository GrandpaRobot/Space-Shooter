extends Node2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var right_flame = $RightFlame
@onready var left_flame = $LeftFlame

enum ThrusterScale {DIM, NORMAL, BRIGHT}

func scale_thrusters(fire_state: ThrusterScale):
	if(fire_state == ThrusterScale.DIM):
		left_flame.scale.y = .2
		right_flame.scale.y = .2
		# NOTE - Water Wake Stuff
		# var normalized_vec2 = Vector2((self.global_position.x - 1) / 480, (self.global_position.y - 20) / 270)
		# water.material.set_shader_parameter('normalized_player_position', normalized_vec2)
		# water.material.set_shader_parameter('y_stretch_factor', .3)
		# water.material.set_shader_parameter('wake_clip_threshold', .5)
		# water.material.set_shader_parameter('falloff_range', -.25)
		# water.material.set_shader_parameter('scale_size', 2)
	elif(fire_state == ThrusterScale.NORMAL):
		left_flame.scale.y = .5
		right_flame.scale.y = .5
		# NOTE - Water Wake Stuff
		# var normalized_vec2 = Vector2((self.global_position.x - 1) / 480, (self.global_position.y + 2) / 270)
		# water.material.set_shader_parameter('normalized_player_position', normalized_vec2)
		# water.material.set_shader_parameter('y_stretch_factor', 1.5)
		# water.material.set_shader_parameter('wake_clip_threshold', 0)
		# water.material.set_shader_parameter('falloff_range', -.25)
		# water.material.set_shader_parameter('scale_size', 3.0)
		# water.material.set_shader_parameter('scroll1', Vector2(-.05, -.01))
		# water.material.set_shader_parameter('scroll2', Vector2(.05, -.04))
	elif(fire_state == ThrusterScale.BRIGHT):
		left_flame.scale.y = 1
		right_flame.scale.y = 1
		# NOTE - Water Wake Stuff
		# var normalized_vec2 = Vector2((self.global_position.x - 1) / 480, (self.global_position.y + 30) / 270)
		# water.material.set_shader_parameter('normalized_player_position', normalized_vec2)
		# water.material.set_shader_parameter('y_stretch_factor', -.3)
		# water.material.set_shader_parameter('wake_clip_threshold', .5)
		# water.material.set_shader_parameter('falloff_range', -.25)
		# water.material.set_shader_parameter('scale_size', 2)
		# water.material.set_shader_parameter('scroll1', Vector2(-.05, -.04))
		# water.material.set_shader_parameter('scroll2', Vector2(.05, -.2))

func animate_ship(velocity_x: float, velocity_y: float) -> void:
	if velocity_x < 0:
		animated_sprite_2d.play('bank_left')
		left_flame.play("bank_left")
		right_flame.play("bank_left")
	elif velocity_x > 0:
		animated_sprite_2d.play('bank_right')
		left_flame.play("bank_right")
		right_flame.play("bank_right")
	else:
		animated_sprite_2d.play("center")
		left_flame.play("center")
		right_flame.play("center")
	# Moving forward
	# TODO - fix this so it isn't reliant on velocity in the y, but as a normal to the ship direction (so if moving "forward" but towards bottom of screen, flame is Bright)
	if velocity_y < 0:
		scale_thrusters(ThrusterScale.BRIGHT)
	# Moving backward
	elif velocity_y > 0:
		scale_thrusters(ThrusterScale.DIM)
	# Not moving
	else:
		scale_thrusters(ThrusterScale.NORMAL)
