extends "res://units/base_unit/base_unit.gd"

signal hitted()
signal destroyed()

export(int) var lives: int = 2
export(float) var height: float = 20.0;

func hit() -> void:
	emit_signal("hitted")
	internal_hit()
	take_life()

func take_life() -> void:
	lives = lives - 1
	if lives <= 0:
		destroy()

func destroy() -> void:
	emit_signal("destroyed")
	internal_destroy()
	queue_free()

func internal_hit() -> void:
	# Overridable by derived classes
	pass

func internal_destroy() -> void:
	# Overridable by derived classes
	pass

func _on_body_entered(body: PhysicsBody2D) -> void:
	if body.is_in_group("player"): hit()
