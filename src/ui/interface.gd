extends CanvasLayer

onready var score_format = $VBoxContainer/Score.text

func _process(delta: float) -> void:
	var score = GameState.current_score
	var energy = GameState.energy
	$VBoxContainer/Score.text = score_format % score
	$VBoxContainer/Control/EnergyBar.energy = energy
