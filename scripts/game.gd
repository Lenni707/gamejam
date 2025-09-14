extends Node2D

# Alarm control

var alarms = {}

func _ready() -> void:
	# Struct aus Alarms, weitere Alarme hier einfügen
	
	alarms = {
		"Computer1": $alarms/Alarm,
		"Computer2": $alarms/Alarm2,
		"Computer3": $alarms/Alarm3
	}
	for i in alarms.keys():
		trigger_problem(i)
	
func trigger_problem(name):
	if name in alarms:
		alarms[name].trigger_alarm()
		
