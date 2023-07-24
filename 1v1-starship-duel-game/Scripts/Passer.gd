extends Node2D

var p1_health = 100
var p2_health = 100
var death = false

func _process(_delta):
	if p1_health <= 0 or p2_health <= 0:
		death = true
	if p1_health == 100 and p2_health == 100:
		death = false
