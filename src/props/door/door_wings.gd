extends Node2D

export var opened: bool = false \
	setget set_opened, is_open

var previous_state = false

func _ready() -> void:
	var init_state = _get_initial_state()
	_tween_doors(init_state)

func _get_initial_state() -> float:
	return 1.0 if opened else 0.0

func set_opened(value: bool) -> void:
	previous_state = opened
	opened = value
	_update_tween()

func is_open() -> bool:
	return opened

func _update_tween() -> void:
	if has_node("Tween") and previous_state != opened:
		var from = 1.0 if previous_state else 0.0
		var to = 0.0 if previous_state else 1.0
		$Tween.interpolate_method(self, "_tween_doors", from, to, 0.2)
		$Tween.call_deferred("start")

func _tween_doors(value: float) -> void:
	$WingLeft.position.x = value * -48.0
	$WingRight.position.x = value * 48.0
