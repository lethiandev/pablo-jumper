extends TextureRect

func _process(delta: float) -> void:
	var lives = max(0, GameState.lives - 1)
	rect_min_size.x = 60.0 * lives
