extends Node2D

var p1_health = 100
var p2_health = 100
var death = false
var what_power1 = 0
var what_power2 = 0
var colour1 = 0
var colour2 = 0
var player_hit = [false, 'what_ship']
var score = [0, 0]
var auto_play = false
var mute_sounds = false

func _process(_delta):
	var death_count = death
	if p1_health <= 0:
		death = true
		score[1] += 1
	if p2_health <= 0:
		death = true
		score[0] += 1
	if p1_health == 100 and p2_health == 100:
		death = false
		if auto_play == false and death_count != death:
			get_tree().change_scene_to_file("res://Scenes/menu.tscn")
	if Input.is_action_just_pressed("Escape"):
		get_tree().change_scene_to_file("res://Scenes/menu.tscn")
