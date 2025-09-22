extends Control

@onready var final_time: Label = $Label3

func _process(delta: float) -> void:
	final_time.text = GameState.last_time
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://Scenes/title_screen.tscn")
	
func send_scores():
	var http = HTTPRequest.new()
	add_child(http)
	
	var survival_time = GameState.last_time
	
	var json_data = JSON.stringify({
		"survival_time": survival_time
	})
	
	var headers = ["Content-Type: application/json"]
	
	http.request("https://localhost:8000/api/save-score", headers, HTTPClient.METHOD_POST, json_data)
