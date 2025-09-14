extends Sprite2D

var dragging := false

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed and get_rect().has_point(get_local_mouse_position()): # that has to work better but idk how :(
			dragging = true
			$AudioStreamPlayer2D.play()
		else:
			dragging = false

	if event is InputEventMouseMotion and dragging:
		global_position = event.position
	
