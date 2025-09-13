extends Node2D

# Alarm control

var alarms = {}

func _ready() -> void:
	# Struct aus Alarms, weitere Alarme hier einfügen
	
	alarms = {
		"Computer1": $alarms/Alarm
	}
	trigger_problem("Computer1")
	
func trigger_problem(name):
	if name in alarms:
		alarms[name].trigger_alarm()
		
