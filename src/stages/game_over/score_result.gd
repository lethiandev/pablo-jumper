extends Label

onready var text_format = text

func _process(delta: float) -> void:
	var score = GameState.current_score
	var best = GameState.best_score
	
	text = text_format % [score, best]
