extends CanvasLayer

onready var score_format = $Container/Score.text

func _process(delta: float) -> void:
	var score = GameState.current_score
	var energy = GameState.energy
	$Container/Score.text = score_format % score
	$Container/EnergyBar.energy = energy
