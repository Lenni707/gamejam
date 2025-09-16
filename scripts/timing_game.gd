extends Control
signal finished(success: bool)

var spawn_interval := 0.7
var note_speed := 350.0
var note_size := Vector2(16, 16)

var tex_up    := preload("res://Assets/timing_game/key_up.png")
var tex_down  := preload("res://Assets/timing_game/key_down.png")
var tex_left  := preload("res://Assets/timing_game/key_left.png")
var tex_right := preload("res://Assets/timing_game/key_right.png")

@onready var notes_root: Control = $Notes
@onready var spawn_point: Control = $SpawnPoint
@onready var hitframe: Control = $Hitframe
@onready var timer: Timer = $Timer
@onready var label: Label = $Counter

var rng := RandomNumberGenerator.new()
var counter := 0

func _ready() -> void:
	set_process_unhandled_input(true)
	custom_minimum_size = Vector2(400, 300)
		# spawn loop
	rng.randomize()
	timer.wait_time = spawn_interval
	timer.timeout.connect(_spawn_note)
	timer.start()
	set_process(true)

func start(config := {}):
	queue_redraw()

func _unhandled_input(event):

	# test: arrow keys remove note if overlapping hitframe
	if event.is_action_pressed("ui_left"):
		_check_hit("left")
	if event.is_action_pressed("ui_right"):
		_check_hit("right")
	if event.is_action_pressed("ui_up"):
		_check_hit("up")
	if event.is_action_pressed("ui_down"):
		_check_hit("down")

func _spawn_note() -> void:
	var tex_pool = {
		"up": tex_up,
		"down": tex_down,
		"left": tex_left,
		"right": tex_right
	}

	var keys = tex_pool.keys()
	var arrow = keys[rng.randi_range(0, keys.size() - 1)]
	var t := TextureRect.new()
	t.texture = tex_pool[arrow]
	t.size = note_size                     
	t.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	t.set_meta("arrow", arrow)

	t.position = spawn_point.position
	notes_root.add_child(t)

	timer.start()

func _process(delta: float) -> void:
	label.text = str(counter) + "/5"
	if counter < 0:
		counter = 0
	if counter == 5:
		emit_signal("finished", true)
	for n in notes_root.get_children():
		if n is Control:
			n.position.x -= note_speed * delta
			if (n.global_position.x + n.size.x) < 0.0:
				counter -= 1
				n.queue_free()

func _check_hit(arrow: String) -> void:
	for n in notes_root.get_children():
		if n.get_meta("arrow") == arrow and _overlaps_hitframe(n):
			print("Hit:", arrow)
			counter += 1
			n.queue_free()
			return
	counter -= 1

func _overlaps_hitframe(note: Control) -> bool:
	return note.get_global_rect().intersects(hitframe.get_global_rect())
