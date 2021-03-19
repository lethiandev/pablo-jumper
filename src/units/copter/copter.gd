extends "res://units/base_enemy/base_enemy.gd"

var ticks = 0.0

func _physics_process(delta: float) -> void:
	._physics_process(delta)
	
	# Vertical movement
	linear_velocity.y += cos(ticks)
	ticks += 2.0 * delta

# Disable gravity acceleration
func _physics_process_gravity(delta: float) -> void:
	pass
