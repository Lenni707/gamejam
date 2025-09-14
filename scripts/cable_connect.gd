extends Control
signal finished(success: bool)

var first_selected: TextureButton = null
var pairs = {
	"USB-TEXT": "USB-A-PORT",
	"USB-A-PORT": "USB-TEXT",
	"HDMI-TEXT": "HDMI-PORT",
	"HDMI-PORT": "HDMI-TEXT",
	"LAN-PORT": "LAN-TEXT",
	"LAN-TEXT": "LAN-PORT",
}


func _ready() -> void:
	set_process_unhandled_input(true)
	custom_minimum_size = Vector2(240, 100)  # so it's visible in the popup
	
	add_picture("res://Assets/cable_game/USB-TEXT.png", 25.0, 235.0, 0.39, 0.39, "USB-TEXT")
	add_picture("res://Assets/cable_game/HDMI-Text.png", 150.0, 227.0, 0.42, 0.42, "HDMI-TEXT")
	add_picture("res://Assets/cable_game/LAN-TEXT.png", 280.0, 235.0, 0.39, 0.39,  "LAN-TEXT")
	
	add_picture("res://Assets/cable_game/USB-A-PORT.png", 200.0, 10.0, 1.5, 1.5, "USB-A-PORT")
	add_picture("res://Assets/cable_game/HDMI-PORT.png", 10.0, 75.0, 1.5, 1.5, "HDMI-PORT")
	add_picture("res://Assets/cable_game/LAN-CABLE-PORT.png", 300., 100., 1.5, 1.5, "LAN-PORT")
	
func start(config := {}):
	# init state from config if needed
	queue_redraw()

func _unhandled_input(event):
	if event.is_action_pressed("Interagieren"):
		emit_signal("finished", true)  # or handle logic then decide
		# else queue_redraw()

func add_picture(path: String, x: float, y: float, scale1: float, scal2: float, name: String):
	var img = TextureButton.new()
	img.texture_normal = load(path)
	img.name = name
	# Position und Größe frei bestimmen
	img.position = Vector2(x, y)   # frei platzieren
	img.scale = Vector2(scale1, scal2)      # halb so groß
	
	img.connect("pressed", Callable(self, "_on_item_clicked").bind(img))
	
	add_child(img)
	
func _on_item_clicked(item: TextureButton):
	if first_selected == null:
		first_selected = item
		item.modulate = Color(1, 1, 0) # Ausgewäht gelb makiert
	else:
		if pairs.get(first_selected.name, "") == item.name:
			print("richtig:", first_selected.name, "+", item.name)
			first_selected.modulate = Color(0, 1, 0)
			item.modulate = Color(0, 1, 0)
			# Buttens deaktiviern
			first_selected.disabled = true
			item.disabled = true
		else:
			print("falsch")
			first_selected.modulate = Color(1, 1, 1)  # Reset Farbe
		first_selected = null
	check_if_finished()

func check_if_finished():
	for child in get_children():
		if child is TextureButton and not child.disabled:
			# Es gibt noch Buttons, die nicht richtig verbunden wurden
			return false
	# Alle Buttons sind deaktiviert → fertig
	emit_signal("finished", true)
	print("true")
