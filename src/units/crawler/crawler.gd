extends "res://units/base_enemy/base_enemy.gd"

export(float) var speed: float = 40.0
export(float) var direction: float = 1.0

func _physics_process(delta: float) -> void:
	._physics_process(delta)
	
	# Bounce crawler on the wall
	if test_move(transform, Vector2(1.0, 0.0)):
		direction = -1.0
	if test_move(transform, Vector2(-1.0, 0.0)):
		direction = 1.0
	
	# Move crawler horizontally
	if is_on_floor():
		linear_velocity.x = speed * direction
		direction = _get_edge_direction()
	
	# Animate crawler
	$RoombaSkin/AnimationTree["parameters/wheels/blend_position"] = direction

func _get_edge_direction() -> float:
	var offset = Vector2(0.0, 2.0)
	var shape = $CollisionShape2D.shape
	if shape is RectangleShape2D:
		var size0 = shape.extents
		var size1 = Vector2(-size0.x, size0.y)
		if not _test_collision(size0 + offset): return -abs(direction)
		if not _test_collision(size1 + offset): return abs(direction)
	return direction

func _test_collision(offset: Vector2) -> bool:
	var space = get_world_2d().get_direct_space_state()
	var point = global_position + offset
	var layer_mask = Constants.COLLISION_MASK_OBSTACLES
	var result = space.intersect_point(point, 1, [self], layer_mask)
	return not result.empty()
