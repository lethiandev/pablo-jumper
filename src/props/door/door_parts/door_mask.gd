extends Sprite

func _ready() -> void:
	texture = _get_viewport_texture()

func _get_viewport_texture() -> ViewportTexture:
	var viewport_texture = $Viewport.get_texture()
	viewport_texture.flags |= Texture.FLAG_FILTER
	return viewport_texture
