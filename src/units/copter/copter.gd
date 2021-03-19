extends "res://units/base_enemy/base_enemy.gd"

export var min_amplitude: float = 50.0
export var max_amplitude: float = -50.0
export var direction: float = 1.0

const WreckScene = preload("res://units/copter/wreck/headcopter_wreck.tscn")

const ACCELERATION = 200.0
const MAX_SPEED = 50.0

var original_position = Vector2()

func _ready():
	original_position = global_position

func _physics_process(delta: float) -> void:
	# Movement direction based on amplitude
	var yrel = global_position.y - original_position.y
	if yrel > min_amplitude: direction = -1.0
	if yrel < max_amplitude: direction = 1.0
	
	# Vertical movement
	linear_velocity.y += ACCELERATION * direction * delta
	linear_velocity.y = clamp(linear_velocity.y, -MAX_SPEED, MAX_SPEED)

func _physics_process_gravity(delta: float) -> void:
	# Override gravity acceleration by none
	pass

func internal_hit() -> void:
	$HeadcopterSkin.blink()

func internal_destroy() -> void:
	spawn_wreckage(WreckScene)
