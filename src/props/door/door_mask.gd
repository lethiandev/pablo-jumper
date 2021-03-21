extends Sprite

func _ready() -> void:
	texture = _get_viewport_texture()

func _get_viewport_texture() -> ViewportTexture:
	return $Viewport.get_texture()
