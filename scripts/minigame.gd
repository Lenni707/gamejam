extends Control

func _ready():
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	# setup minigame state

func _unhandled_input(e):
	if e.is_action_pressed("ui_cancel"):
		owner.close_with_result({"success": false})
