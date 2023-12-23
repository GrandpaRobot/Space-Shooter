extends Node2D

@export var radius = 50

var line_width = 2
var circle_color = Color(1, 0, 0)  # Red color

func _draw():
    var adjusted_radius = radius / scale.x  # Adjust radius based on scale
    # Draw outer circle
    draw_circle(Vector2(), adjusted_radius + line_width, circle_color)
    # Draw inner circle to create the line effect
    draw_circle(Vector2(), adjusted_radius, Color(0, 0, 0, 0))  # Transparent color for inner circle

# func _process(delta):
#     update()  # Redraw to adjust for scale changes