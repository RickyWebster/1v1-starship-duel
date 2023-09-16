extends Control


func _ready():
	$CheckButton.button_pressed = passer.auto_play
	$Score_display/Score1.text = str(passer.score[0])
	$Score_display/Score2.text = str(passer.score[1])


func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/World.tscn")


func _on_reset_button_pressed():
	passer.score = [0, 0]
	$Score_display/Score1.text = str(passer.score[0])
	$Score_display/Score2.text = str(passer.score[1])


func _on_quit_button_pressed():
	get_tree().quit()


func _on_check_button_toggled(button_pressed):
	passer.auto_play = button_pressed
	$CheckButton.button_pressed = passer.auto_play


func _on_auto_button_pressed():
	var curren_auto: bool
	if passer.auto_play:
		curren_auto = false
	else:
		curren_auto = true
	_on_check_button_toggled(curren_auto)
