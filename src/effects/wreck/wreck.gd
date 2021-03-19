extends Node2D

func _ready() -> void:
	var timer = get_tree().create_timer(3.0)
	timer.connect("timeout", self, "queue_free")
	
	# Blink wreck parts
	$WreckParts.blink()
