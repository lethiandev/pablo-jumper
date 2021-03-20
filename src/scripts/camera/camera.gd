extends Camera2D

func _process(delta: float) -> void:
	offset = $ShakeEffect.offset

func shake_low() -> void:
	$ShakeEffect.amplitude = 12.0
	$ShakeEffect.shake(0.5, 30.0)

func shake_high() -> void:
	$ShakeEffect.amplitude = 28.0
	$ShakeEffect.shake(0.8, 50.0)
