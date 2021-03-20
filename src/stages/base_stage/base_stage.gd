extends Node

func _ready() -> void:
	_prepare_game()
	_connect_units()
	
	# Start level transition
	Transition.transit_fade_in()

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
	$Camera2D.shake_high()
