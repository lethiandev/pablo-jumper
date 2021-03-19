extends "res://units/base_unit/base_unit.gd"

signal hitted()

func hit() -> void:
	emit_signal("hitted")
