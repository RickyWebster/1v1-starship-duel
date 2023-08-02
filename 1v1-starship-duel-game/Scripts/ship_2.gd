extends CharacterBody2D

signal laser_shot(laser)

var angular_speed = PI
var speed = 0.0
var max_speed = 400.0
var dirft_rotation = rotation

@onready var muzzle = $Muzzle
var laser_scene = preload("res://Scenes/laser.tscn")
var shoot_cd = false
var fire_rate = 0.2

func _process(_delta):
	if Input.is_action_pressed("p2_shoot"):
		if !shoot_cd:
			shoot_cd = true
			shoot_laser()
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
	

func shoot_laser():
	var las = laser_scene.instantiate()
	las.global_position = muzzle.global_position
	las.rotation = rotation + -PI/2
	emit_signal("laser_shot", las)


func death():
	passer.p2_health = 100
	self.global_position = Vector2(2004,548)
	rotation = 0
	speed = 0
