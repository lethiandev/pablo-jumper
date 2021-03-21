extends Node

export(String, FILE, "*.tscn") var start_stage

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		yield(Transition.fade_out(), "completed")
		get_tree().change_scene(start_stage)

func _ready():
	GameState.reset_state()
