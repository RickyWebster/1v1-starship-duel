extends Node2D

@onready var time = $Timer
@onready var Powerup1 = $Powerup1
@onready var Powerup2 = $Powerup2
@onready var indicator1 = $AbilityIndicators1
@onready var indicator2 = $AbilityIndicators2

var length = 0.06 # Length of cooldown * 10^-2
var linking_indicator = [3, 1, 0, 4, 5, 2]


func _ready():
	indicator1.hide()
	indicator2.hide()


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
	
	if passer.death == true:
		Powerup1.value = 0
		Powerup2.value = 0
		indicator1.hide()
		indicator2.hide()
		passer.what_power1 = 0
		passer.what_power2 = 0
	

func _on_timer_timeout():
	if Powerup1.value <= 99:
		Powerup1.value += 1
		if Powerup1.value == 100:
			power(1)
	else:
		if passer.what_power1 == 0:
			Powerup1.value = 0
			indicator1.hide()

	if Powerup2.value <= 99:
		Powerup2.value += 1
		if Powerup2.value == 100:
			power(2)
	else:
		if passer.what_power2 == 0:
			Powerup2.value = 0
			indicator2.hide()


func power(no):
	var what_power = randi_range(1, 4)
	if no == 1:
		indicator1.show()
		indicator1.frame = linking_indicator[what_power]
	else:
		indicator2.show()
		indicator2.frame = linking_indicator[what_power]
	passer["what_power" + str(no)] = what_power
