extends CharacterBody2D

signal laser_shot2(laser)

var angular_speed = 1.4 * PI
var speed = 0.0
var max_speed = 200.0
var dirft_rotation = rotation
var powered = false
var count = 0

@onready var muzzle = $Muzzle
var laser_scene = preload("res://Scenes/laser.tscn")
var shoot_cd = false
var fire_rate = 0.2


func _process(_delta):
	if passer.what_power2 != 0 and Input.is_action_pressed("p2_power"):
		if !powered:
			powered = true
			passer.colour2 = 1
			
	if powered == true and Input.is_action_pressed("p2_shoot") and count == 0 and passer.what_power2 == 1:
		power_up()
		count += 1
	
	if Input.is_action_pressed("p2_shoot"):
		if !shoot_cd:
			shoot_cd = true
			if powered == true and passer.what_power2 != 1:
				if passer.what_power2 == 2:
					shoot_laser(10)
					shoot_laser(0)
					shoot_laser(-10)
					count += 1
					if count >= 8:
						reset()
				elif passer.what_power2 == 3:
					for i in range(8):
						if i != 4:
							shoot_laser(i * 45)
					count += 1
					if count >= 4:
						reset()
			else:
				shoot_laser(0)
			await get_tree().create_timer(fire_rate).timeout
			shoot_cd = false
			
	if passer.death == true:
		death()


func _physics_process(delta):
	var direction = 0
	if Input.is_action_pressed("p2_left"):
		direction = -1
	if Input.is_action_pressed("p2_right"):
		direction = 1
	rotation += angular_speed * direction * delta
	
	velocity = Vector2.ZERO
	if Input.is_action_pressed("p2_accelorate"):
		if speed < max_speed:
			speed += 10
		velocity = Vector2.LEFT.rotated(rotation) * speed
		dirft_rotation = rotation
	else:
		if speed > 0:
			speed -= 3.0
		velocity = Vector2.LEFT.rotated(dirft_rotation)* speed
		
	move_and_slide()
	

func shoot_laser(offset):
	var las = laser_scene.instantiate()
	las.global_position = muzzle.global_position
	las.rotation = rotation + -PI/2 + deg_to_rad(offset)
	emit_signal("laser_shot2", las)


func death():
	passer.p2_health = 100
	self.global_position = Vector2(960,324)
	rotation = deg_to_rad(15)
	speed = 0


func power_up():
	passer.colour2 = 1
	fire_rate = 0.1
	await get_tree().create_timer(2).timeout
	fire_rate = 0.2
	reset()


func reset():
	powered = false
	passer.what_power2 = 0
	passer.colour2 = 0
	count = 0
