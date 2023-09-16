extends Control


func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/World.tscn")


func _on_reset_button_pressed():
	pass # Replace with function body.


func _on_quit_button_pressed():
	get_tree().quit()


func _on_check_button_toggled(button_pressed):
	pass
