extends Node2D

const DotTexture = preload("./trajectory_dot.png")

const COLOR = Color(1.0, 1.0, 1.0)
const OBSTACLE_MASK = 0x01

var angle: float = 0.0
var distance: float = 0.0
var iterations: int = 20

func _process(_delta: float) -> void:
	if is_visible_in_tree():
		update()

func _draw() -> void:
	_draw_trajectory()

func _draw_trajectory() -> void:
	var points = _get_trajectory_points()
	var colors = PoolColorArray()
	var factor = 1.0 / iterations
	
	for i in range(1, points.size()):
		var alpha = 1.0 - i * factor
		var point = points[i] - DotTexture.get_size() * 0.5
		var color = COLOR
		color.a = alpha
		draw_texture(DotTexture, point, color)

func _get_trajectory_points() -> PoolVector2Array:
	var gravity = get_parent().GRAVITY
	var points = JumpMath.get_jump_arc_points(angle, distance, gravity, iterations, 1.0 / 18.0)
	var space = get_world_2d().get_direct_space_state()
	
	for i in range(points.size() - 1):
		var p0 = global_position + points[i]
		var p1 = global_position + points[i + 1]
		var result = space.intersect_ray(p0, p1, [get_parent()], OBSTACLE_MASK)
		if not result.empty():
			var pos = result["position"]
			points[i + 1] = pos - global_position
			points.resize(i + 2)
			break
	
	return points
