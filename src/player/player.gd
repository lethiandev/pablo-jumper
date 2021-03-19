extends "res://units/base_unit/base_unit.gd"

signal hitted()

const MIN_DISTANCE = 200.0
const MAX_DISTANCE = 1200.0
const MIN_ANGLE = deg2rad(10)
const MAX_ANGLE = deg2rad(170)

var idle_tick: float = 0.0
var jump_distance: float = 0.0
var jump_angle: float = 0.0

func _physics_process(delta: float) -> void:
	# Process state machines
	if is_on_floor():
		_process_state_idle(delta)
		idle_tick = idle_tick + delta
	else:
		_process_state_jumping(delta)
	
	# Update animation tree
	$RobotSkin/AnimationTree["parameters/conditions/on_floor"] = is_on_floor()
	$RobotSkin/AnimationTree["parameters/conditions/in_air"] = not is_on_floor()
	$RobotSkin/AnimationTree["parameters/airborne/blend_position"] = linear_velocity.y * 0.01

func _physics_process_slide(delta: float, lv: Vector2) -> void:
	if is_on_wall():  lv = get_bounce_velocity(lv)
	if is_on_floor(): lv = Vector2(0.0, lv.y)
	linear_velocity = lv

func _process_state_idle(delta: float) -> void:
	$Angle.visible = true
	$Trajectory.visible = false
	
	if Input.is_action_just_released("jump"):
		jump(jump_angle, jump_distance)
		jump_distance = 0.0
		$Angle.visible = false
	
	if Input.is_action_just_pressed("jump"):
		# Rotate skin facing on jump direction
		var face = -1.0 if jump_angle > PI * 0.5 else 1.0
		$RobotSkin.scale.x = face
	
	if Input.is_action_pressed("jump"):
		jump_distance += 800 * delta
		jump_distance = clamp(jump_distance, MIN_DISTANCE, MAX_DISTANCE)
		$Trajectory.visible = true
		$Trajectory.distance = jump_distance
		$Trajectory.angle = jump_angle
	else:
		jump_angle = JumpMath.get_jump_angle(idle_tick, MIN_ANGLE, MAX_ANGLE)
		$Angle.rotation = -jump_angle
	
	# Update jump prepare animation
	var preparing = Input.is_action_pressed("jump")
	$RobotSkin/AnimationTree["parameters/conditions/prepare"] = preparing

func _process_state_jumping(delta: float) -> void:
	$Angle.visible = false
	$Trajectory.visible = false

func jump(angle: float, distance: float) -> void:
	if is_on_floor():
		_perform_jump(angle, distance)

func _perform_jump(angle: float, distance: float) -> void:
	var speed = JumpMath.get_jump_velocity(angle, distance)
	linear_velocity = speed
	idle_tick = 0.0 if angle < PI * 0.5 else 1.0

func _on_body_entered(body: PhysicsBody2D) -> void:
	# Handle stomp on enemies
	if body.is_in_group("enemy"):
		if _is_stomping(body):
			var bounced = linear_velocity.y * -0.85
			linear_velocity.y = min(-600.0, bounced)
			body.hit()
		else:
			_hit()

func _is_stomping(enemy: PhysicsBody2D) -> bool:
	var dpos = global_position - last_global_position
	var player_y = global_position.y + 40.0 - dpos.y
	var enemy_y = enemy.global_position.y - enemy.height
	return player_y < enemy_y and dpos.y > 0.0

func _hit() -> void:
	$RobotSkin.blink()
	emit_signal("hitted")
