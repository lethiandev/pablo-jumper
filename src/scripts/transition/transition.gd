extends CanvasLayer

signal curtain_closed()
signal curtain_opened()

func _ready() -> void:
	$ColorRect.visible = false

func fade_out() -> void:
	_set_curtain_progress(0.0)
	yield(transit("fade_out"), "completed")

func fade_in() -> void:
	_set_curtain_progress(1.0)
	yield(transit("fade_in"), "completed")

func transit(anim_name: String) -> void:
	get_tree().set_pause(true)
	$ColorRect/AnimationPlayer.play(anim_name)
	$ColorRect.visible = true
	
	# Wait for animation to end
	yield($ColorRect/AnimationPlayer, "animation_finished")

func _on_animation_finished(anim_name: String) -> void:
	if anim_name == "fade_out":
		emit_signal("curtain_closed")
	if anim_name == "fade_in":
		emit_signal("curtain_opened")
		_after_curtain_open()

func _after_curtain_open() -> void:
	get_tree().set_pause(false)
	$ColorRect.visible = false

func _set_curtain_progress(value: float) -> void:
	if $ColorRect.material is ShaderMaterial:
		$ColorRect.material.set_shader_param("progress", value)
