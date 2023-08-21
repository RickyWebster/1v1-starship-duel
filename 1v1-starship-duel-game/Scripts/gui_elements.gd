extends Node2D

@onready var time = $Timer
@onready var Powerup1 = $Powerup1
@onready var Powerup2 = $Powerup2

var length = 0.06 # Length of cooldown * 10^-2
var rng = RandomNumberGenerator.new()


func _process(_delta):
	time.wait_time = length 
	var Healthbar1 = $Healthbar1
	Healthbar1.value = passer.p1_health
	var Healthbar2 = $Healthbar2
	Healthbar2.value = passer.p2_health
	
	if passer.colour1 == 1:
		Powerup1.set_modulate(Color8(194,38,0))
	else:
		Powerup1.set_modulate(Color8(194,149,0))
	if passer.colour2 == 1:
		Powerup2.set_modulate(Color8(194,38,0))
	else:
		Powerup2.set_modulate(Color8(194,149,0))
		

func _on_timer_timeout():
	if Powerup1.value <= 99:
		Powerup1.value += 1
		if Powerup1.value == 100:
			power(1)
	else:
		if passer.what_power1 == 0:
			Powerup1.value = 0

	if Powerup2.value <= 99:
		Powerup2.value += 1
		if Powerup2.value == 100:
			power(2)
	else:
		if passer.what_power2 == 0:
			Powerup2.value = 0


func power(no):
	var what_power = rng.randi_range(1, 3)
	passer["what_power" + str(no)] = what_power
	print(what_power)
