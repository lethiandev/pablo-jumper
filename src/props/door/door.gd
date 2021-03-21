extends Node2D

signal body_entered(body)

export var opened: bool = false \
	setget set_opened, is_open
export var locked: bool = false \
	setget set_locked, is_locked

func _process(delta: float) -> void:
	# Close door automatically on lock
	if is_locked() and is_open():
		close()
	
	# Update door light
	var light_frame = 0 if is_locked() else 1
	$Light.frame = light_frame

func open() -> void:
	set_opened(true)

func close() -> void:
	set_opened(false)

func lock() -> void:
	locked = true

func unlock() -> void:
	locked = false

func set_opened(value: bool) -> void:
	# Delegate door close/open state
	var interact = value and not is_locked()
	$DoorMask/Viewport/DoorWings.set_opened(interact)

func is_open() -> bool:
	# Delegate door close/open state
	return  $DoorMask/Viewport/DoorWings.is_open()

func set_locked(value: bool) -> void:
	$Observable.monitoring = not value
	locked = value

func is_locked() -> bool:
	return locked

func _on_body_entered(body):
	emit_signal("body_entered", body)
