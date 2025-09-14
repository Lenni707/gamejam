extends Control
signal finished(success: bool)

func _ready():
	set_process_unhandled_input(true)
	custom_minimum_size = Vector2(400, 300)  # so it's visible in the popup

func start(config := {}):
	# init state from config if needed
	queue_redraw()
