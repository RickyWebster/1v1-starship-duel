extends CharacterBody2D

signal laser_shot2(laser)
signal show_death(pos)

var angular_speed = 2 * PI
var speed = 0.0
var _direction := Vector2(-1, 0)
var max_speed = 200.0
var dirft_rotation = rotation
var _collision:KinematicCollision2D
var not_paralised = true

@onready var muzzle = $Muzzle
@onready var sprite = $Sprite2D
@onready var shoot_audio = $ShootAudio
@onready var hurt_audio = $HurtAudio
@onready var explode_audio = $ExplodeAudio
var hit_texture = preload("res://Assets/Ships/Ship1_Hit.png")
var norm_texture = preload("res://Assets/Ships/Ship1.png")
var laser_scene = preload("res://Scenes/laser.tscn")
var shoot_cd = false
var fire_rate = 0.2
var powered = false
var count = 0
var last_health = passer.p2_health
var dead = false

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
		
	if last_health != passer.p2_health:
		last_health = passer.p2_health
		sprite.texture = hit_texture
		if passer.mute_sounds:
			hurt_audio.play()
		await get_tree().create_timer(0.13).timeout
		sprite.texture = norm_texture
	last_health = passer.p2_health


func _physics_process(delta):
	var direction = 0
	if Input.is_action_pressed("p2_left"):
		direction = -1
	if Input.is_action_pressed("p2_right"):
		direction = 1
	rotation += angular_speed * direction * delta
	
	if not_paralised:
		if Input.is_action_pressed("p2_accelorate"):
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
		if "space_rock" in str(_collision.get_collider().name):
			if _direction == Vector2(-1, 0):
				_direction = _direction.bounce(_collision.get_normal())
			else:
				_direction = Vector2(1, 0)
			not_paralised = false
			speed = max_speed
			for i in range (10):
				if speed > 0:
					speed -= 4.4444 * i
				else: 
					break
				await get_tree().create_timer(0.1).timeout
			not_paralised = true
			speed = 0
			_direction = Vector2(-1, 0)


func shoot_laser(offset):
	if dead != true:
		if passer.mute_sounds:
			shoot_audio.play()
		var las = laser_scene.instantiate()
		las.global_position = muzzle.global_position
		las.rotation = rotation + -PI/2 + deg_to_rad(offset)
		emit_signal("laser_shot2", las)
	
	
func death():
	if passer.p2_health <= 0:
		passer.p2_health = 99
		emit_signal("show_death", global_position)
		if passer.mute_sounds:
			explode_audio.play()
		self.hide()
		dead = true
	passer.p2_health = 99
	await get_tree().create_timer(2).timeout
	dead = false
	speed = 0
	reset()
	passer.p2_health = 100
	self.show()
	self.global_position = Vector2(960,324)
	rotation = deg_to_rad(20)
	
	
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
	fire_rate = 0.2
