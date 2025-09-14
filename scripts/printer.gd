extends Area2D
signal finished(success: bool)

func _ready() -> void:
	connect("area_entered", Callable(self, "_"))
	connect("area_exited", Callable(self, "_on_area_exited"))

var counter := 0
func _on_area_entered(area: Area2D) -> void:
	counter += 1
	
func _on_area_exited(area: Area2D):
	counter -= 1
	print("Objekt rausgegangen! Aktuell im Ziel:", counter)
	
func _process(delta: float) -> void:
	if counter == 5:
		print("finished")
		emit_signal("finished", true)
