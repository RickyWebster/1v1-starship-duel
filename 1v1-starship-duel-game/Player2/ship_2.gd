extends CharacterBody2D

var angular_speed = PI
var speed = 0.0
var max_speed = 400.0
var dirft_rotation = rotation


func _process(delta):
	var direction = 0
	if Input.is_action_pressed("p1_left"):
		direction = -1
	if Input.is_action_pressed("p1_right"):
		direction = 1
	
	rotation += angular_speed * direction * delta
	
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("p1_accelorate"):
		if speed < max_speed:
			speed += 10
		velocity = Vector2.LEFT.rotated(rotation) * speed
		dirft_rotation = rotation
		
	else:
		if speed > 0:
			speed -= 3.0
		velocity = Vector2.LEFT.rotated(dirft_rotation)* speed
		
	position += velocity * delta
