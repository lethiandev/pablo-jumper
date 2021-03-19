extends Node2D

const SparksScene = preload("res://effects/sparks/sparks.tscn")

var sparks: CPUParticles2D
var timer: SceneTreeTimer

func _ready() -> void:
	# Duplicate material to make blinking unique
	if material is ShaderMaterial:
		material = material.duplicate()

func blink() -> void:
	_spawn_sparks()
	_set_coverage(1.0)
	_start_timer(0.2)

func _spawn_sparks() -> void:
	sparks = SparksScene.instance()
	add_child(sparks)

func _start_timer(time: float) -> void:
	_stop_timer()
	timer = get_tree().create_timer(time, false)
	timer.connect("timeout", self, "_on_blink_timeout")

func _stop_timer() -> void:
	if timer and not timer.is_queued_for_deletion():
		timer.disconnect("timeout", self, "_on_blink_timeout")
		timer.time_left = 0.0

func _on_blink_timeout():
	_set_coverage(0.0)

func _set_coverage(value: float) -> void:
	if material is ShaderMaterial:
		material.set_shader_param("coverage", value)
