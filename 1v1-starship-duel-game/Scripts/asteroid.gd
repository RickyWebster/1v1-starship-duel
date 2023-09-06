extends RigidBody2D

signal hit(body)
enum AsteroidNo{NO1L, NO2L, NO3L, NO4S, NO5S, NO6S}
@export var WhatAsteroid = AsteroidNo.NO1L
@onready var sprite = $Sprite2D
@onready var cshape1 = $CShape1
@onready var cshape2 = $CShape2

var speed: float
var target_position: Vector2
var start_postition: Vector2
var _velocity: Vector2
var radius = 100
var rotation_direction: int


func _ready():
	get_points()
	
	
func match_size():
	WhatAsteroid = AsteroidNo.keys()[randi() % AsteroidNo.size()]
	#WhatAsteroid = 'NO1L'
	match WhatAsteroid:
		'NO1L':
			speed = randi_range(50,100)
			sprite.texture = preload("res://Assets/Asteroids/NO1L.png")
			cshape1.shape = preload("res://Resources/no1l_circle_shape_2d.tres")
			cshape1.position = Vector2(-6, 8)
			cshape2.shape = preload("res://Resources/no1l_capsule_shape_2d.tres")
			cshape2.position = Vector2(25, -27)
			cshape2.rotation = deg_to_rad(138.2)
		'NO2L':
			speed = randi_range(50,100)
			sprite.texture = preload("res://Assets/Asteroids/NO2L.png")
			cshape1.shape = preload("res://Resources/no2l_capsule_shape_2d.tres")
			cshape1.position = Vector2(-1, -1)
			cshape2.rotation = deg_to_rad(61.8)
			cshape2.shape = preload("res://Resources/no2l_capsule_shape_cs2.tres")
			cshape2.position = Vector2(-3, 22)
			cshape2.rotation = deg_to_rad(76.4)
		'NO3L':
			speed = randi_range(50,100)
			sprite.texture = preload("res://Assets/Asteroids/NO3L.png")
			cshape1.shape = preload("res://Resources/no3l_capsule_shape_2d.tres")
			cshape1.position = Vector2(-6, -2)
			cshape2.rotation = deg_to_rad(58.1)
			cshape2.shape = preload("res://Resources/no3l_circle_shape_2d.tres")
			cshape2.position = Vector2(34, 33)
		'NO4S':
			speed = randi_range(100,200)
			sprite.texture = preload("res://Assets/Asteroids/NO4S.png")
			cshape1.shape = preload("res://Resources/no1l_capsule_shape_2d.tres")
			cshape1.global_position = Vector2(0, 0)
			cshape2.rotation = deg_to_rad(0)
			cshape2.shape = preload("res://Resources/no1l_capsule_shape_2d.tres")
			cshape2.global_position = Vector2(0, 0)
			cshape2.rotation = deg_to_rad(0)
		'NO5S':
			speed = randi_range(100,200)
			sprite.texture = preload("res://Assets/Asteroids/NO5S.png")
			cshape1.shape = preload("res://Resources/no1l_capsule_shape_2d.tres")
			cshape1.global_position = Vector2(0, 0)
			cshape2.rotation = deg_to_rad(0)
			cshape2.shape = preload("res://Resources/no1l_capsule_shape_2d.tres")
			cshape2.global_position = Vector2(0, 0)
			cshape2.rotation = deg_to_rad(0)
		'NO6S':
			speed = randi_range(100,200)
			sprite.texture = preload("res://Assets/Asteroids/NO6S.png")
			cshape1.shape = preload("res://Resources/no1l_capsule_shape_2d.tres")
			cshape1.global_position = Vector2(0, 0)
			cshape2.rotation = deg_to_rad(0)
			cshape2.shape = preload("res://Resources/no1l_capsule_shape_2d.tres")
			cshape2.global_position = Vector2(0, 0)
			cshape2.rotation = deg_to_rad(0)


func _physics_process(delta):
	var direction = (target_position - start_postition).normalized()
	_velocity = direction * speed * delta
	move_and_collide(_velocity)
	if global_position.distance_to(target_position) < 10:
		get_points()
	if rotation_direction == 0:
		rotation += 0.007
	else:
		rotation -= 0.007


func get_points():
	match_size()
	var start_side = randi_range(1, 4)
	var target_side = randi_range(1, 4)
	if randi_range(0, 1) == 0:
		if start_side in [1, 3]:
			target_side = start_side + 1
		else:
			target_side = start_side - 1
	else:
		while start_side == target_side:
			target_side = randi_range(1, 4)
	
	start_postition = positions(start_side)
	self.global_position = start_postition
	target_position = positions(target_side)
	rotation_direction = randi_range(0, 1)


func positions(side):
	var port_size = get_viewport_rect().size
	var randi_x = randi_range(0, port_size.x)
	var randi_y = randi_range(0, port_size.y)
	@warning_ignore("unassigned_variable")
	var getting_position: Vector2
	
	if side == 1: #Top
		getting_position.x = randi_x 
		getting_position.y = 0 - radius
	elif side == 2: #Bottom
		getting_position.x = randi_x 
		getting_position.y = port_size.y + radius
	elif side == 3: #Left
		getting_position.y = randi_y
		getting_position.x = 0 - radius 
	else: #Right
		getting_position.y = randi_y
		getting_position.x = port_size.x + radius 
	return(getting_position)


func _on_area_2d_body_entered(body):
	hit.emit(body.name)
