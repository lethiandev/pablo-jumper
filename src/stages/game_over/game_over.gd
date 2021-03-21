extends Node

export(String, FILE, "*.tscn") var menu_stage

func _ready() -> void:
	Interface.hide()
	Transition.fade_in()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		yield(Transition.fade_out(), "completed")
		get_tree().change_scene(menu_stage)
		Transition.fade_in()
