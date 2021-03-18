extends CanvasLayer

signal curtain_closed()
signal curtain_opened()

func _ready() -> void:
	$ColorRect.visible = false

func transit_fade_out() -> void:
	transit("fade_out")

func transit_fade_in() -> void:
	transit("fade_in")

func transit(anim_name: String) -> void:
	get_tree().set_pause(true)
	$ColorRect/AnimationPlayer.play(anim_name)
	$ColorRect.visible = true

func _on_animation_finished(anim_name: String) -> void:
	if anim_name == "fade_out":
		emit_signal("curtain_closed")
		_after_curtain_close()
	if anim_name == "fade_in":
		emit_signal("curtain_opened")
		_after_curtain_open()

func _after_curtain_close() -> void:
	# Workaround for signal not emitted in queue mode
	$ColorRect/AnimationPlayer.play("fade_in")

func _after_curtain_open() -> void:
	get_tree().set_pause(false)
	$ColorRect.visible = false
