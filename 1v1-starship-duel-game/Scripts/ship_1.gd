extends CharacterBody2D

signal laser_shot1(laser)

var angular_speed = PI
var speed = 0.0
var max_speed = 400.0
var dirft_rotation = rotation

@onready var muzzle = $Muzzle
var laser_scene = preload("res://Scenes/laser.tscn")


func _process(_delta):
	if Input.is_action_just_pressed("p1_shoot"):
		shoot_laser()
		
	if passer.death == true:
		death()


func _physics_process(delta):
	var direction = 0
	if Input.is_action_pressed("p1_left"):
		direction = -1
	if Input.is_action_pressed("p1_right"):
		direction = 1
	rotation += angular_speed * direction * delta
	
	var local_velocity = Vector2.ZERO
	if Input.is_action_pressed("p1_accelorate"):
		if speed < max_speed:
			speed += 10
		local_velocity = Vector2.LEFT.rotated(rotation) * speed
		dirft_rotation = rotation
	else:
		if speed > 0:
			speed -= 3.0
		local_velocity = Vector2.LEFT.rotated(dirft_rotation)* speed
	position += local_velocity * delta
	

func shoot_laser():
	var las = laser_scene.instantiate()
	las.global_position = muzzle.global_position
	las.rotation = rotation + -PI/2
	emit_signal("laser_shot1", las)
	
func death():
	passer.p1_health = 100
	self.global_position = Vector2(200,250)
	rotation = PI
	speed = 0
