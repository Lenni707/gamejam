extends Control

@onready var final_time: Label = $Label3

func _process(delta: float) -> void:
	final_time.text = GameState.last_time
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://Scenes/title_screen.tscn")
	
