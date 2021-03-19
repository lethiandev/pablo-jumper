extends Node2D

const GRAVITY = Vector2.DOWN * 1800.0
const ROTATION = 0.05

var linear_velocity = Vector2()
var angular_velocity = 0.0

func _ready() -> void:
	linear_velocity += Vector2.UP * rand_range(-100, 500)
	linear_velocity += Vector2.RIGHT * rand_range(-300, 300)
	angular_velocity = rand_range(-PI, PI) * 0.02
	
	# Enqueue delayed actions
	_enqueue_destroy()

func _process(delta: float) -> void:
	linear_velocity += GRAVITY * delta
	rotate(angular_velocity)
	
	# Update position
	position += linear_velocity * delta

func _enqueue_destroy() -> void:
	var timer = get_tree().create_timer(5.0)
	timer.connect("timeout", self, "queue_free")
