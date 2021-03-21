extends Node2D

export var opened: bool = false \
	setget set_opened, is_open

func _ready() -> void:
	var initial = _get_to_value()
	_tween_doors(initial)

func set_opened(value: bool) -> void:
	opened = value
	
	# Animate doors only when in scene tree
	if is_inside_tree():
		_update_tween()

func is_open() -> bool:
	return opened

func _update_tween() -> void:
	var from = _get_from_value()
	var to = _get_to_value()
	$Tween.interpolate_method(self, "_tween_doors", from, to, 0.2)
	$Tween.start()

func _tween_doors(value: float) -> void:
	$WingLeft.position.x = value * -48.0
	$WingRight.position.x = value * 48.0

func _get_from_value() -> float:
	return 0.0 if opened else 1.0

func _get_to_value() -> float:
	return 1.0 if opened else 0.0
