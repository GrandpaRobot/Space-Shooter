extends Ability

@onready var timer = $DisappearTimer

func _ready():
	await timer.timeout
	queue_free()
