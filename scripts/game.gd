extends Node2D

@onready var counter: Label = $Counter


#Alarm control
var alarms = {}

func _ready() -> void:
	check_timer.wait_time = check_interval
	check_timer.start()
	
	alarms = {
		"Computer1": $alarms/Computer1,
		"Computer2": $alarms/Computer2,
		"Computer4":$alarms/Computer5,
		"Computer5":$alarms/Computer6,
		"Computer6":$alarms/Computer7,
		"Computer8":$alarms/Computer9,
		"Computer9":$alarms/Computer10,
		"Computer10":$alarms/Computer11,
		"Computer11":$alarms/Computer12,
		"Printer1": $alarms/Printer1,
		"Printer2": $alarms/Printer3,
		"Printer3": $alarms/Printer4,
		"Printer4": $alarms/Printer2,
	}
	# spawns the alarms
	#for i in alarms.keys():
		#trigger_problem(i)

func _process(delta: float) -> void:
	counter.text = "Active errors: " + str(get_ative_alarms().size()) + "/7"
	if get_ative_alarms().size() > 7:
		get_tree().change_scene_to_file("res://Scenes/death_screen.tscn")
		
func trigger_problem(name):
	if name in alarms:
		alarms[name].trigger_alarm()

func get_free_alarms():
	var free_alarms = []
	for alarm in alarms.values():
		if not alarm.active:
			free_alarms.append(alarm)
	return free_alarms
	
func get_ative_alarms():
	var free_alarms = []
	for alarm in alarms.values():
		if alarm.active:
			free_alarms.append(alarm)
	return free_alarms

func trigger_random_alarm_if_free():
	var free_alarms = get_free_alarms()
	if free_alarms.size() > 0:
		var idx = randi_range(0, free_alarms.size()-1)
		var choosen = free_alarms[idx]
		choosen.trigger_alarm()


@export var check_interval: float = 5.0
@export var base_prob: float = 0.05
@export var grow_rate: float = 0.001
@export var max_prob: float = 0.3

var elapsed_time := 0.0

@onready var check_timer: Timer = $CheckTimer


func _on_check_timer_timeout() -> void:
	elapsed_time += check_interval

	var  p = min(base_prob + grow_rate * elapsed_time, max_prob)
	print(p)
	if randf() < p:
		trigger_random_alarm_if_free()

# Escape menu
@export var escape_menu_scene: PackedScene
var escape_menu_instance: Control = null
var paused := false

#func _unhandled_input(event):
	#if event.is_action_pressed("ui_cancel"):
		#if not paused:
			#show_pause_menu()
		#else:
			#hide_pause_menu()
#
#func show_pause_menu():
	#if escape_menu_scene:
		#escape_menu_instance = escape_menu_scene.instantiate()
		#get_tree().root.add_child(escape_menu_instance)  # Overlay 
		#paused = true
		#get_tree().paused = true  # Spiel pausieren
#
#func hide_pause_menu():
	#if escape_menu_instance:
		#escape_menu_instance.queue_free()
		#escape_menu_instance = null
	#paused = false
	## Spiel startet
	#get_tree().paused = false


func _on_time(time: String) -> void:
	pass # Replace with function body.
