extends Node2D

@onready var sprite: Sprite2D = $Sprite2D
var active := false
var player_inside := false
var current_game: Node = null

@export var starts_active := false
@export var ui_node_path: NodePath = ^"game/UI"
@export var game_scene: PackedScene   # set per alarm in the editor

signal popup_open

func _ready() -> void:
	sprite.visible = false
	$Area2D.body_entered.connect(_on_body_entered)
	$Area2D.body_exited.connect(_on_body_exited)
	add_to_group("alarms")
	if starts_active:
		trigger_alarm()
	print("[Alarm:", name, "] sprite node =", sprite)

func trigger_alarm():
	if !active:
		active = true
		sprite.visible = true

func stop_alarm():
	print("[Alarm:", name, "] stop_alarm called. active=", active)
	if active:
		active = false
		sprite.visible = false

func _on_body_entered(body):
	if body.is_in_group("player"):
		print("inside")
		player_inside = true
		body.current_alarm = self

func _on_body_exited(body):
	if body.is_in_group("player"):
		player_inside = false
		body.current_alarm = null

func try_solve():
	if active and player_inside and game_scene:
		print("yes")
		active = false
		emit_signal("popup_open")
		
		var game := game_scene.instantiate()
		current_game = game
		var ui_root: Node = get_tree().root.get_node("game/UI")
		
		var center := ui_root.get_node("CenterContainer")
		center.add_child(game)

		
		# 3) lock/unlock player automatically
		var player := get_tree().get_first_node_in_group("player")
		if player and player.has_method("set_ui_lock"):
			player.set_ui_lock(true)
			game.finished.connect(func(_res): player.set_ui_lock(false))

		# 4) let this alarm react to result
		game.finished.connect(func(success: bool):
			_on_minigame_finished(success)
)

		# 5) show
		#game.open_centered()

func _on_minigame_finished(success: bool):
	if success:
		print("SHIT")
		stop_alarm()
	if current_game:
		current_game.queue_free()
		current_game = null
	# else: failed/canceled — do whatever you want
