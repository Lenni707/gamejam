extends PopupPanel
signal finished(result: Dictionary)

@onready var content: Control = $MarginContainer/Content


func _ready():
	# When GameArea finishes, translate to our finished(result) for the parent
	content.finished.connect(_on_game_finished)

func _on_game_finished(success: bool):
	emit_signal("finished", {"success": success})
	queue_free()  # close & clean up
