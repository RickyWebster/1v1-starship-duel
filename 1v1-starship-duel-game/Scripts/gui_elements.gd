extends Node2D
var p1_health = 100
var p2_health = 100

func _process(_delta):
	var Healthbar1 = $Healthbar1
	p1_health = passer.p1_health
	Healthbar1.value = p1_health	
	
	var Healthbar2 = $Healthbar2
	p2_health = passer.p2_health
	Healthbar2.value = p2_health	
