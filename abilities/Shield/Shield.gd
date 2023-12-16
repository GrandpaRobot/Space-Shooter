extends Ability

@onready var timer = $DisappearTimer
@onready var sprite = $Sprite2D
@onready var collision_shape_2d = $HurtboxComponent/CollisionShape2D
@onready var hurtbox_component = $HurtboxComponent
@onready var clear_damage_timer = $ClearDamageTimer as Timer
@onready var shield_hit_spawner_component = $ShieldHitSpawnerComponent as SpawnerComponent

# TODO - Don't hardcode this to 10.5
var expanded_scale = Vector2(10.5 * 1.04, 10.5 * 1.04)
# TODO - Don't hardcode this to 10.5
var contracted_scale = Vector2(10.5 * 0.96, 10.5 * 0.96)

@export var pulse_duration = 1.0  # Duration of one pulse cycle in seconds
var elapsed_time = 0.0  # Tracks the elapsed time in the pulse cycle

var expanded = false
var hit_angles: Array[float]

func _ready():
	hurtbox_component.hurt.connect(func(hitbox_component: HitboxComponent):
			if(hit_angles.size() >= 5):
				hit_angles = hit_angles.slice(0, 4)
			hit_angles.push_front(self.global_position.angle_to_point(hitbox_component.global_position))
			var particle_hit_direction = ( self.global_position - hitbox_component.global_position ).normalized()
			clear_damage_timer.start()
			sprite.material.set_shader_parameter('hit_angle', hit_angles)
			shield_hit_spawner_component.spawn(hitbox_component.global_position, self, Vector2(particle_hit_direction))
	)
	await timer.timeout
	queue_free()

func _process(delta):
	elapsed_time += delta
	# Calculate the interpolation factor (ranging from 0 to 1 and back)
	var time_osc = sin(elapsed_time / pulse_duration * PI)
	# Interpolate between the contracted and expanded scales
	var current_scale = contracted_scale.lerp(expanded_scale, time_osc)
	# Apply the calculated scale to the sprite and collision shape
	sprite.scale = current_scale
	# TODO - Don't hardcode this to 10.5
	collision_shape_2d.scale = current_scale / 10.5

# Clears old shield damage
func _on_clear_damage_timer_timeout():
	hit_angles = hit_angles.slice(0, hit_angles.size() - 1)
	sprite.material.set_shader_parameter('hit_angle', hit_angles)
