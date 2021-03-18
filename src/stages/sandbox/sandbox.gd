extends Node

func _ready() -> void:
	Transition.transit()
	yield(Transition, "curtain_closed")
