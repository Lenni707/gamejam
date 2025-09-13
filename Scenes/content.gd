extends Control
signal finished(success: bool)

var progress := 0

func _ready():
	set_process_unhandled_input(true)    # receive unhandled input
	custom_minimum_size = Vector2(200, 40)  # ensure visible size

func start(config := {}):
	progress = 0
	queue_redraw()   # Godot 4.x (update() in 3.x)

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		progress += 20
		if progress >= 100:
			emit_signal("finished", true)
		queue_redraw()

func _draw():
	# background
	draw_rect(Rect2(Vector2.ZERO, size), Color(0.15, 0.15, 0.15))
	# progress bar
	var bar_width := size.x * (progress / 100.0)
	draw_rect(Rect2(Vector2.ZERO, Vector2(bar_width, size.y)), Color(0.2, 0.8, 0.2))
	# text
	var font := ThemeDB.fallback_font
	var font_size := ThemeDB.fallback_font_size
	draw_string(font, Vector2(10, 20), "%d%%" % progress, HORIZONTAL_ALIGNMENT_LEFT, -1.0, font_size)
