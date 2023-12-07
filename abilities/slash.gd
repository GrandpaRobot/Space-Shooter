extends Node2D

@onready var timer = $DisappearTimer


# Called when the node enters the scene tree for the first time.
func _ready():
	await timer.timeout
	queue_free()
