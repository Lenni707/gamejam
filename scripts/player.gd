extends CharacterBody2D

const SPEED := 250.0
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(_delta: float) -> void:
	var dir: Vector2 = Input.get_vector("left", "right", "up", "down")

	# movement
	velocity = dir * SPEED
	move_and_slide()

	# animations
	_update_animation(dir)


func _update_animation(dir: Vector2) -> void:
	if dir == Vector2.ZERO:
		# Idle when no input
		if anim.animation != "idle":
			anim.play("idle")
	else:
		# Running
		if anim.animation != "run":
			anim.play("run")
		
		# Flip when moving left
		if dir.x < -0.01:
			anim.flip_h = true
		elif dir.x > 0.01:
			anim.flip_h = false
