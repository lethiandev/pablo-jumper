extends Node2D

export var opened: bool = false \
	setget set_opened, is_open

func open() -> void:
	set_opened(true)

func close() -> void:
	set_opened(false)

func set_opened(value: bool) -> void:
	$DoorMask/Viewport/DoorWings.opened = value

func is_open() -> bool:
	return $DoorMask/Viewport/DoorWings.opened
