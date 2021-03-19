extends "res://units/base_unit/base_unit.gd"

export(float) var height: float = 20.0;

func hit() -> void:
	pass

func kill(delay: float) -> void:
	dispose(delay)
	freeze()

func freeze() -> void:
	set_process(false)
	set_physics_process(false)
	set_collision_mask(0x0)
	set_collision_layer(0x0)

func dispose(delay: float) -> void:
	var timer = get_tree().create_timer(delay)
	timer.connect("timeout", self, "queue_free")

func _on_body_entered(body: PhysicsBody2D) -> void:
	if body.is_in_group("player"): hit()
