extends Control

@onready var final_time: Label = $Label3
@onready var http: HTTPRequest = $HTTPRequest

func _ready() -> void:
	final_time.text = GameState.last_time
	add_child(http)
	http.request_completed.connect(_on_http_request_request_completed)
	send_data()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://Scenes/title_screen.tscn")
	

func send_data() -> void:
	var url := "https://www.okoloki.com/save_scores"
	var headers := ["Content-Type: application/json"]
	var body := {"result": GameState.last_time}
	var json := JSON.stringify(body)
	var err := http.request(url, headers, HTTPClient.METHOD_POST, json)
	if err != OK:
		push_error("HTTPRequest failed to start: %s" % err)

func _on_http_request_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	var text := body.get_string_from_utf8()
	print("HTTP result:", result, " status:", response_code, " body:", text)
