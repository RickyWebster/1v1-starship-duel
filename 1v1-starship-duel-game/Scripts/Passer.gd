extends Node2D

var p1_health = 100
var p2_health = 100
var death = false
var what_power1 = 0
var what_power2 = 0
var colour1 = 0
var colour2 = 0
var hit = false
var hit_name

func _process(_delta):
	if p1_health <= 0:
		death = true
		print("ORANGE WINS!")
	if p2_health <= 0:
		death = true
		print("BLUE WINS!")
	if p1_health == 100 and p2_health == 100:
		death = false
