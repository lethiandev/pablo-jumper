extends Node

func _ready() -> void:
	Transition.transit_fade_in()
	yield(Transition, "curtain_closed")
