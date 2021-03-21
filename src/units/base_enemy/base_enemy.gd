extends "res://units/base_unit/base_unit.gd"

signal hitted()
signal destroyed()

export(int) var lives: int = 2
export(float) var height: float = 20.0;

func _process(delta: float) -> void:
	# Destroy enemy on fall
	if global_position.y > 720.0:
		if not is_queued_for_deletion():
			destroy()

func hit() -> void:
	emit_signal("hitted")
	internal_hit()
	take_life()
	
	# Play hit sound effect
	if lives > 0:
		$HitStreamPlayer.play()

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

func spawn_wreckage(wreck_scene: PackedScene) -> void:
	var wreck_node = wreck_scene.instance()
	get_parent().add_child(wreck_node)
	wreck_node.transform = transform

func _on_body_entered(body: PhysicsBody2D) -> void:
	if body.is_in_group("player"): hit()
