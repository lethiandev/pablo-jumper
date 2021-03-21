extends Node

export(String, FILE, "*.tscn") var next_stage: String

func _ready() -> void:
	_prepare_game()
	_connect_units()
	
	# Show interface controls
	Interface.show()
	
	# Start level transition
	Transition.fade_in()

func _prepare_game() -> void:
	randomize()

func _connect_units() -> void:
	var enemies = get_tree().get_nodes_in_group("enemy")
	var players = get_tree().get_nodes_in_group("player")
	
	# Connect enemy signals
	for enemy in enemies:
		_connect_enemy(enemy)
	
	# Connect player signals
	for player in players:
		_connect_player(player)

func _connect_enemy(enemy: Node) -> void:
	enemy.connect("hitted", $Camera2D, "shake_low")
	enemy.connect("destroyed", $Camera2D, "shake_low")

func _connect_player(player: Node) -> void:
	player.connect("hitted", self, "_on_player_hitted", [player])
	player.connect("destroyed", self, "_on_player_destroyed", [player])

func _on_player_hitted(player: Node) -> void:
	$Camera2D.shake_low()

func _on_player_destroyed(player: Node) -> void:
	yield($Camera2D.shake_high(), "completed")
	
	# Take life and do restart or game over
	if GameState.take_life() <= 0:
		_stage_game_over()
	else:
		_stage_restart()

func _on_door_entered(door: Node, body: Node) -> void:
	if body.is_in_group("player"):
		body.freeze()
		yield(door.open(), "completed")
		yield(get_tree().create_timer(0.2), "timeout")
		GameState.add_score(500)
		_stage_advance()

func _stage_restart() -> void:
	yield(Transition.fade_out(), "completed")
	get_tree().reload_current_scene()
	GameState.revert_state()

func _stage_advance() -> void:
	yield(Transition.fade_out(), "completed")
	get_tree().change_scene(next_stage)
	GameState.advance_state()

func _stage_game_over() -> void:
	yield(Transition.fade_out(), "completed")
	get_tree().change_scene("res://stages/game_over/game_over.tscn")
