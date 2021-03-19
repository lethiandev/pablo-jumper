extends Node

func _ready() -> void:
	randomize()
	Transition.transit_fade_in()
	yield(Transition, "curtain_closed")
