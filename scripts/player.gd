extends CharacterBody2D

const SPEED := 250.0
var current_alarm: Node = null

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	add_to_group("player")

func _physics_process(_delta: float) -> void:
	if ui_locked:
		return
	
	var dir: Vector2 = Input.get_vector("left", "right", "up", "down")

	# movement
	velocity = dir * SPEED
	move_and_slide()

	# animations
	_update_animation(dir)
	
# Funktion check, ob interaktion mit einem Problem ist
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Interagieren"):
		for alarm in get_tree().get_nodes_in_group("alarms"):
			alarm.try_solve()

# Animationen
func _update_animation(dir: Vector2) -> void:
	if ui_locked:
		return   # skip movement entirely
	if dir == Vector2.ZERO:
		# Idle when no input
		if anim.animation != "idle":
			anim.play("idle")
	else:
		# Runninges
		# Flip when moving left
		if dir.x < -0.01 && not dir.y < -0.01:
			anim.play("run")
			anim.flip_h = true
		elif dir.x > 0.01 && not dir.y < -0.01:
			anim.play("run")
			anim.flip_h = false
		if dir.y < -0.01:
			anim.play("run_up")
		
		

var ui_locked: bool = false

func set_ui_lock(locked: bool):
	ui_locked = locked
	if locked:
		velocity = Vector2.ZERO   # stop immediately

func _on_popup_open() -> void:
	set_ui_lock(true)
	
func _on_mini_game_popup_finished(result: Dictionary) -> void:
	set_ui_lock(false)
