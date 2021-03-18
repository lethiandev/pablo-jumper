extends Object
class_name JumpMath

static func get_jump_arc_points(angle: float, speed: float, gravity: Vector2, iterations: int = 20, delta: float = 0.1) -> PoolVector2Array:
	var velocity = get_jump_velocity(angle, speed)
	var points = PoolVector2Array([Vector2()])
	
	for i in range(1, iterations + 1):
		var t = delta * i
		var g = gravity.length()
		var posx = velocity.x * t
		var posy = velocity.y * t + 0.5 * g * t * t
		points.push_back(Vector2(posx, posy))
	
	return points

static func get_jump_velocity(angle: float, speed: float) -> Vector2:
	var normal = Vector2(cos(angle), -sin(angle))
	return normal * speed

static func get_arc_points(angle: float, distance: float, gravity: Vector2, iterations: int = 10) -> PoolVector2Array:
	var points = PoolVector2Array()
	var gravity_scalar = gravity.length()
	var speed = get_jump_speed(angle, distance, gravity)
	var delta = 1.0 / iterations
	
	for i in range(iterations + 1):
		var x = i * delta * distance
		var t = x / (speed * cos(angle))
		var y0 = gravity_scalar * (t * t) * 0.5
		var y1 = speed * sin(angle) * t
		points.push_back(Vector2(x, y0 - y1))
	
	return points

static func get_jump_speed(angle: float, distance: float, gravity: Vector2) -> float:
	var gravity_scalar = gravity.length()
	var speedx = distance * sqrt(gravity_scalar * (1.0 / cos(angle)))
	var speedy = sqrt(2.0 * distance * sin(angle))
	return speedx / speedy

static func get_jump_angle(tick: float, min_angle: float, max_angle: float) -> float:
	var factor0 = fmod(tick, 2.0)
	var factor1 = min(1.0, factor0) - max(0.0, factor0 - 1.0)
	return min_angle + (max_angle - min_angle) * factor1
