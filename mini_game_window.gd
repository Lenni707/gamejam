extends Window
signal finished(result)

func open(data := {}):
	# freeze main game
	get_tree().paused = true
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	popup_centered()

func close_with_result(result):
	hide()
	get_tree().paused = false
	finished.emit(result)
