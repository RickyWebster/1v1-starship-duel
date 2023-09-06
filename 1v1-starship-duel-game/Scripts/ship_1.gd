extends CharacterBody2D

signal laser_shot1(laser)

var angular_speed = 1.4 * PI
var speed = 0.0
var _direction := Vector2(-1, 0)
var max_speed = 200.0
var dirft_rotation = rotation
var _collision:KinematicCollision2D
var not_paralised = true

@onready var muzzle = $Muzzle
var laser_scene = preload("res://Scenes/laser.tscn")
var shoot_cd = false
var fire_rate = 0.2
var powered = false
var count = 0


func _process(_delta):
	if passer.what_power1 != 0 and Input.is_action_pressed("p1_power"):
		if !powered:
			powered = true
			passer.colour1 = 1
			
	if powered == true and Input.is_action_pressed("p1_shoot") and count == 0 and passer.what_power1 == 1:
		power_up()
		count += 1
	
	if Input.is_action_pressed("p1_shoot"):
		if !shoot_cd:
			shoot_cd = true
			if powered == true and passer.what_power1 != 1:
				if passer.what_power1 == 2:
					shoot_laser(10)
					shoot_laser(0)
					shoot_laser(-10)
					count += 1
					if count >= 8:
						reset()
				elif passer.what_power1 == 3:
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
	if Input.is_action_pressed("p1_left"):
		direction = -1
	if Input.is_action_pressed("p1_right"):
		direction = 1
	rotation += angular_speed * direction * delta
	
	if not_paralised:
		if Input.is_action_pressed("p1_accelorate"):
			if speed < max_speed:
				speed += 10
			dirft_rotation = rotation
		else:
			if speed > 0:
				speed -= 3.0
			
	_direction = _direction.normalized()
	velocity = speed * _direction.rotated(rotation) * delta
	_collision = move_and_collide(velocity)
	if _collision:
		if _collision.get_collider().name in ["space_rock", "space_rock2", "space_rock3"]:
			if _direction == Vector2(-1, 0):
				_direction = _direction.bounce(_collision.get_normal())
			else:
				_direction = Vector2(1, 0)
			not_paralised = false
			speed = max_speed
			for i in range (10):
				if speed > 0:
					speed -= 4.4444 * i
				await get_tree().create_timer(0.1).timeout
			not_paralised = true
			speed = 0
			_direction = Vector2(-1, 0)


func shoot_laser(offset):
	var las = laser_scene.instantiate()
	las.global_position = muzzle.global_position
	las.rotation = rotation + -PI/2 + deg_to_rad(offset)
	emit_signal("laser_shot1", las)
	
	
func death():
	passer.p1_health = 100
	self.global_position = Vector2(192,324)
	rotation = deg_to_rad(160)
	speed = 0
	
	
func power_up():
	passer.colour1 = 1
	fire_rate = 0.1
	await get_tree().create_timer(2).timeout
	fire_rate = 0.2
	reset()


func reset():
	powered = false
	passer.what_power1 = 0
	passer.colour1 = 0
	count = 0

func _on_space_rock_hit(body):
	if body == 'Ship1':
		passer.p1_health -= 25
