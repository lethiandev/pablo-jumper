extends Node

# Workaround for simulating mouse click on mobile devices
# Allows playing the game on mobile browsers

func _ready() -> void:
	pause_mode = Node.PAUSE_MODE_PROCESS

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.is_pressed():
			Input.action_press("jump")
		else:
			Input.action_release("jump")
