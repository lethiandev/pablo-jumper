extends TextureRect

export var energy: int = 3 \
	setget set_energy, get_energy

func set_energy(value: int) -> void:
	$Sprite.frame = value
	energy = value

func get_energy() -> int:
	return energy
