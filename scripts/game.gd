extends Node2D

#Alarm control
var alarms = {}

func _ready() -> void:
	# TIMER
	check_timer.wait_time = check_interval
	check_timer.start()
	# Struct aus Alarms, weitere Alarme hier einfügen
	alarms = {
		"Computer2": $alarms/Alarm2,
		"Computer3": $alarms/Alarm3
	}

	#for i in alarms.keys():
		#trigger_problem(i)
func trigger_problem(name):
	if name in alarms:
		alarms[name].trigger_alarm()

func get_free_alarms():
	var free_alarms = []
	for alarm in alarms.values():
		if not alarm.active:
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

#Wahrscheinlichkeit steigt linear an
	var  p = min(base_prob + grow_rate * elapsed_time, max_prob)
	print(p)
	if randf() > p:
		trigger_random_alarm_if_free()
