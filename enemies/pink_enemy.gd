extends Enemy
class_name PinkEnemy

@onready var states = $States
@onready var move_down_state = $States/MoveDownState
@onready var move_side_state = $States/MoveSideState
@onready var paused_state = $States/PausedState

@onready var move_side_component = $States/MoveSideState/MoveSideComponent

func _ready() -> void:
	super()
	for state in states.get_children():
		state.disable()

	move_side_component.velocity.x = [-20, 20].pick_random()

	move_down_state.state_finished.connect(move_side_state.enable)
	move_side_state.state_finished.connect(paused_state.enable)
	paused_state.state_finished.connect(move_down_state.enable)

	move_down_state.enable()
