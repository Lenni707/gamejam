extends Control


func _on_texture_button_pressed() -> void: # play
	get_tree().change_scene_to_file("res://Scenes/explaining.tscn")	


func _on_texture_button_2_pressed() -> void: # quit
	get_tree().quit()
