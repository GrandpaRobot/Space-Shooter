extends TextureButton
 
@onready var progress_bar = $TextureProgressBar as TextureProgressBar
@onready var timer = $Timer as Timer
@onready var time = $MarginContainer/Time as Label
@onready var key = $MarginContainer/Key as Label
 
signal cast(spell_name)
 
var change_key = "":
	set(value):
		change_key = value
		key.text = value
 
		shortcut = Shortcut.new()
		var input_key = InputEventKey.new()
		input_key.keycode = value.unicode_at(0)
 
		shortcut.events = [input_key]
 
func _ready():
	change_key = "1"
	progress_bar.max_value = timer.wait_time
	set_process(false)
 
func _process(_delta):
	time.text = "%3.1f" % timer.time_left
	progress_bar.value = timer.time_left
 
func _on_pressed():
	timer.start()
	disabled = true
	set_process(true)
 
	cast.emit(name)
 
 
func _on_timer_timeout():
	disabled = false
	time.text = ""
	set_process(false)
 
