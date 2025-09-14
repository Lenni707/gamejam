extends TextureButton

@onready var tween = create_tween()

func _ready() -> void:
	pivot_offset = size / 2

func _on_mouse_entered() -> void:
	tween.kill()
	tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.2, 1.2), 0.2)



func _on_mouse_exited() -> void:
	tween.kill()
	tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1, 1), 0.2)
