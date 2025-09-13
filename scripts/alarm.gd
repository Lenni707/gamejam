extends Node2D

@onready var sprite: Sprite2D = $Sprite2D

var active := false
var player_inside := false

func _ready() -> void:
	# Start des games ist der alarm nicht sichtbar
	sprite.visible = false
	$Area2D.body_entered.connect(_on_body_entered)
	$Area2D.body_exited.connect(_on_body_exited)
	add_to_group("alarms")
	
### ALARM KONTROLLE
func trigger_alarm():
	if not active:
		active = true
		sprite.visible = true
		# sound.play()
		print("Alarm")

func stop_alarm():
	if active:
		active = false
		sprite.visible = false
		# sound.stop()
		print("Alarm stopped")
### ALARM LÖSEN
func _on_body_entered(body):
	if body.is_in_group("player"):
		player_inside = true
		print("player inside")

func _on_body_exited(body):
	if body.is_in_group("player"):
		player_inside = false
		
# Hier ändern was passiert wenn mit alarm interagiert wird
# Scene ändern, etc
func try_solve():
	print("tried solving")
	if active and player_inside:
		stop_alarm()
