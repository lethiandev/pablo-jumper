extends CPUParticles2D

func _ready():
	# Autostart emitting
	emitting = true
	
	# Autoremove sparks' nodes
	var timer = get_tree().create_timer(1.0)
	timer.connect("timeout", self, "queue_free")
