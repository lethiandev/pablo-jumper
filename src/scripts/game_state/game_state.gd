extends Node

const START_ENERGY = 3
const START_LIVES = 4

var current_score: int = 0
var previous_score: int = 0
var best_score: int = 0
var energy: int = START_ENERGY
var lives: int = START_LIVES

func _ready() -> void:
	reset_state()

func reset_state() -> void:
	current_score = 0
	previous_score = 0
	energy = START_ENERGY
	lives = START_LIVES

func revert_state() -> void:
	current_score = previous_score
	energy = START_ENERGY

func advance_state() -> void:
	previous_score = current_score

func add_score(score: int) -> void:
	current_score += score
	
	# Store best score so far
	if best_score < current_score:
		best_score = current_score

func take_energy() -> int:
	energy = max(0, energy - 1)
	return energy

func take_life() -> int:
	lives = max(0, lives - 1)
	return lives
