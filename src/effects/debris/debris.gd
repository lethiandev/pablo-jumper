extends Node2D

func _ready() -> void:
	for child in get_children():
		_start_emitting(child)

func _start_emitting(node: Node) -> void:
	if node is CPUParticles2D:
		node.emitting = true
