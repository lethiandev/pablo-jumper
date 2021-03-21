extends Area2D

func _on_body_entered(body: PhysicsBody2D) -> void:
	if body and body.has_method("destroy"):
		body.destroy()
