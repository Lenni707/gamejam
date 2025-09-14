extends Control
signal finished(success: bool)

func _ready():
	set_process_unhandled_input(true)
	custom_minimum_size = Vector2(400, 300)  # so it's visible in the popup

func start(config := {}):
	# init state from config if needed
	queue_redraw()

func _unhandled_input(event):
	if event.is_action_pressed("Interagieren"):
		emit_signal("finished", true)  # or handle logic then decide

func _draw():
	# draw your game here (optional)
	draw_rect(Rect2(Vector2.ZERO, size), Color(0.12, 0.12, 0.14))
