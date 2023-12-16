extends TextureButton
class_name AbilityButton

@onready var progress_bar = $TextureProgressBar as TextureProgressBar
@onready var timer = $Timer as Timer
@onready var time = $MarginContainer/Time as Label
@onready var key = $MarginContainer/Key as Label

var ability: AbilityData

signal used()

var cooldown:
	# Needs a setter to set both ability and texture cooldown
	set(value):
		timer.wait_time = value
		progress_bar.max_value = value

# TODO - Make this customizable
var change_key = "":
	set(value):
		change_key = value
		key.text = value
		shortcut = Shortcut.new()
		var input_key = InputEventKey.new()
		input_key.keycode = value.unicode_at(0)
		shortcut.events = [input_key]

func _ready():
	# We don't need to run _process until the ability is used and cooldown is active. Save some processing power and no timer runs
	set_process(false)

func _process(_delta):
	time.text = "%3.1f" % timer.time_left
	progress_bar.value = timer.time_left

func _on_pressed():
	timer.start()
	disabled = true
	# Now we need to run _process for timer tickdown
	set_process(true)
	used.emit(ability)

func _on_timer_timeout():
	disabled = false
	time.text = ""
	# Stop _process again
	set_process(false)
