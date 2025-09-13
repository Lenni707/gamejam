extends Node2D

@onready var sprite: Sprite2D = $Sprite2D

var active := false
var player_inside := false

var MiniGamePopup := preload("res://Scenes/mini_game_popup.tscn")

signal popup_open

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
	if active and player_inside:
		emit_signal("popup_open")  # optional
		# 1) instance popup
		var popup = MiniGamePopup.instantiate()
		# 2) add under UI CanvasLayer (adjust path to your actual names)
		var ui_root: Node = get_tree().root.get_node("game/UI")
		ui_root.add_child(popup)
		# 3) react to minigame finishing
		popup.finished.connect(_on_minigame_finished)
		# 4) show it, centered & clamped
		popup.popup_centered_clamped()
# optional: stop alarm now (or after success)
# stop_alarm()

func _on_minigame_finished(result: Dictionary):
		if result.success:
			stop_alarm()
			print("Alarm solved via minigame.")
		else:
			print("Minigame failed/canceled.")
