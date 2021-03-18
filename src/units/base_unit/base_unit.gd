extends KinematicBody2D

const GRAVITY = Vector2.DOWN * 800.0
const FLOOR_ANGLE = deg2rad(40)

var linear_velocity = Vector2()

func _physics_process(delta: float) -> void:
	# Apply world gravity
	_physics_process_gravity(delta)
	
	# Update body position and velocity
	var lv = move_and_slide(linear_velocity, Vector2.UP, true, 4, FLOOR_ANGLE)
	_physics_process_slide(delta, lv)

# Overridable method by derived classes
func _physics_process_gravity(delta: float) -> void:
	linear_velocity += GRAVITY * delta

# Overridable method by derived classes
func _physics_process_slide(delta: float, slide_lv: Vector2) -> void:
	linear_velocity = slide_lv

# Helper method to bounce on walls
# Should be used in '_physics_process_slide' methods
func get_bounce_velocity(lv: Vector2, margin: float = 0.95) -> Vector2:
	for i in range(get_slide_count()):
		var slide = get_slide_collision(i)
		var ndot = slide.normal.dot(Vector2.RIGHT)
		if abs(ndot) > margin:
			lv.x = -linear_velocity.x * 0.6
	return lv
