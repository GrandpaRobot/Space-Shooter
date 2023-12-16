extends HBoxContainer

@export var game_stats: GameStats
@onready var score = $Score

func _ready():
	update_score_label(game_stats.score)
	game_stats.score_changed.connect(update_score_label)

func update_score_label(new_score: int):
	score.text = str(new_score)
