extends Node2D

@onready var sprite: Sprite2D = $Sprite2D

var active := false

func _ready() -> void:
	# Start des games ist der alarm nicht sichtbar
	sprite.visible = false
	
func trigger_alarm():
	if not active:
		active = true
		sprite.visible = true
		# sound.play()

func stop_alarm():
	if active:
		active = false
		sprite.visible = false
		# sound.stop()
