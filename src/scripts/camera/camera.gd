extends Camera2D

func _process(delta: float) -> void:
	offset = $ShakeEffect.offset

func shake_low() -> void:
	$ShakeEffect.amplitude = 12.0
	$ShakeEffect.shake(0.5, 30.0)
	# Wait for shake effect to end
	yield(_wait(0.5), "completed")

func shake_high() -> void:
	$ShakeEffect.amplitude = 28.0
	$ShakeEffect.shake(0.8, 50.0)
	# Wait for shake effect to end
	yield(_wait(0.8), "completed")

func _wait(time: float) -> void:
	yield(get_tree().create_timer(time), "timeout")
