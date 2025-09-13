extends CharacterBody2D

const SPEED := 150.0

func _physics_process(delta: float) -> void:
	# Get a normalized input vector from your mapped actions.
	# Order: left, right, up, down
	var dir: Vector2 = Input.get_vector("left", "right", "up", "down")

	# Set velocity based on direction and speed
	velocity = dir * SPEED

	# Move using built-in collision response
	move_and_slide()
