extends Label

@onready var stopclock: Label = $"."

var elapsed := 0.0
var running := true


func _process(delta: float) -> void:
	if running:
		elapsed += delta
		stopclock.text = format_time(elapsed)

func format_time(seconds: float) -> String:
	var mins = int(seconds) / 60
	var secs = int(seconds) % 60
	return "%02d:%02d" % [mins, secs]
