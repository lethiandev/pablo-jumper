extends CanvasLayer

onready var score_format = $Score.text

func _process(delta: float) -> void:
	var score = GameState.current_score
	$Score.text = score_format % score
