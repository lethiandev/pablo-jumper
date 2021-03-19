extends "res://units/base_enemy/base_enemy.gd"

export var time_wait: float = 3.0
export var direction: float = 1.0
export var preparing: bool = false

var time_left: float = 0.0
var prepare_time: float = 0.0

func _ready() -> void:
	time_left = time_wait

func _process(delta: float) -> void:
	$PabloSkin/AnimationTree["parameters/conditions/is_landed"] = is_on_floor()
	$PabloSkin/AnimationTree["parameters/conditions/is_jumping"] = not is_on_floor()
	$PabloSkin/AnimationTree["parameters/conditions/is_preparing"] = preparing
	$PabloSkin.scale.x = sign(-direction)

func _physics_process(delta: float) -> void:
	# Perform jump after prepare
	if prepare_time > 1.0:
		prepare_time = 0.0
		preparing = false
		jump()
	
	# Wait -> Prepare -> Jump loop
	if preparing:
		prepare_time += delta
	elif time_left > 0.0:
		time_left -= delta
	else:
		time_left = time_wait
		preparing = true

func _physics_process_slide(delta: float, lv: Vector2) -> void:
	if is_on_wall():
		lv = get_bounce_velocity(lv)
		direction = sign(lv.x)
	if is_on_floor():
		lv = Vector2(0.0, 0.0)
	linear_velocity = lv

func jump() -> void:
	var n = Vector2(direction, -4.0).normalized()
	linear_velocity = n * 800.0

func hit() -> void:
	$PabloSkin.blink()
