extends Node2D

const OBSTACLE_MASK = 0x01

var angle: float = 0.0
var distance: float = 0.0

func _process(_delta: float) -> void:
	if is_visible_in_tree():
		update()

func _draw() -> void:
	_draw_trajectory()

func _draw_trajectory() -> void:
	var points = _get_trajectory_points()
	var colors = PoolColorArray()
	var factor = 1.0 / 20.0
	
	for i in range(points.size()):
		var alpha = 0.25 * (1.0 - i * factor)
		var color = Color(0.0, 0.0, 1.0, alpha)
		colors.push_back(color)
	
	draw_polyline_colors(points, colors, 8.0)

func _get_trajectory_points() -> PoolVector2Array:
	var gravity = get_parent().GRAVITY
	var points = JumpMath.get_jump_arc_points(angle, distance, gravity)
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
