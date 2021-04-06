extends CanvasLayer

onready var score_format = $Container/VBoxContainer/Score.text
onready var best_format = $Container/VBoxContainer/BestScore.text

func _process(delta: float) -> void:
	var score = GameState.current_score
	var best_score = GameState.best_score
	var energy = GameState.energy
	
	$Container/VBoxContainer/Score.text = score_format % score
	$Container/VBoxContainer/BestScore.text = best_format % best_score
	$Container/EnergyBar.energy = energy

func show() -> void:
	$Container.show()

func hide() -> void:
	$Container.hide()
