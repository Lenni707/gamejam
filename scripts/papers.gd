extends Sprite2D
var dragging := false

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			# Check ob Maus auf diesem Sprite ist
			if get_rect().has_point(get_local_mouse_position()):
				dragging = true
		else:
			dragging = false
	
	if event is InputEventMouseMotion and dragging:
		# Folge der Maus
		global_position = event.position
