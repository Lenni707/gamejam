extends Control
signal finished(success: bool)
signal game_end(success: bool)

func _ready():
	set_process_unhandled_input(true)
	custom_minimum_size = Vector2(400, 300)  # so it's visible in the popup
	$TextureRect/Area2D.connect("game_end", Callable(self, "_on_game_end"))


func start(config := {}):
	# init state from config if needed
	queue_redraw()
	
#func _process(delta: float) -> void:
	#if 
	


func _on_game_end(success: bool) -> void:
	print("sdajf")
	emit_signal("finished", true)
