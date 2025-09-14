extends PopupPanel
signal finished(result: Dictionary)

@onready var content: Control = $MarginContainer/Content

func load_game(game_scene: PackedScene, config: Dictionary = {}) -> void:
	# clear previous content
	for c in content.get_children():
		c.queue_free()

	var game_area: Node = game_scene.instantiate()
	content.add_child(game_area)

	# the minigame must emit `finished(bool)` and support `start(config)`
	game_area.finished.connect(_on_game_finished)
	if game_area.has_method("start"):
		game_area.start(config)

func open_centered() -> void:
	popup_centered_clamped()

func _on_game_finished(success: bool) -> void:
	emit_signal("finished", true)
	queue_free()
