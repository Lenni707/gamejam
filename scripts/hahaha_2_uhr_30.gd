extends Control
signal finished(success: bool)

@onready var spacebar_upcharger_outline: TextureRect = $TextureRect/TextureRect
@onready var spacebar_upcharger: TextureRect       = $TextureRect/TextureRect2
@onready var space: TextureButton                   = $TextureRect/space

var progress := 0.0          # 0..1
var increment := 0.07  # how much each press adds
var drain_per_sec := 0.2    # how fast it drains
var fired := false           # to emit finished once

func _ready() -> void:
	set_process(true)
	custom_minimum_size = Vector2(400, 300)
	space.grab_focus()
	_update_bar()

func _process(delta: float) -> void:
	# only drain here
	progress -= drain_per_sec * delta
	progress = clamp(progress, 0.0, 1.0)
	_update_bar()

	if progress >= 0.975 and not fired:
		fired = true
		emit_signal("finished", true)
	elif progress < 1.0:
		fired = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		progress += increment
		progress = clamp(progress, 0.0, 1.0)
		_update_bar()

func _update_bar() -> void:
	var w := spacebar_upcharger_outline.size.x
	var h := spacebar_upcharger_outline.size.y
	spacebar_upcharger.position = spacebar_upcharger_outline.position
	spacebar_upcharger.size = Vector2(w * progress, h)

func _draw() -> void:
	draw_rect(Rect2(Vector2.ZERO, size), Color(0.12, 0.12, 0.14))
