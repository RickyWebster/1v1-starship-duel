extends Area2D

enum AsteroidNo{NO1L, NO2L, NO3L, NO4S, NO5S, NO6S}
@export var WhatAsteroid = AsteroidNo.NO1L

var movement_vector = Vector2(0, -1)
var speed = 50
@onready var sprite = $Sprite2D


func _ready():
#	rotation = randi_range(0, 2*PI)
	
	match WhatAsteroid:
		AsteroidNo.NO1L:
			speed = randi_range(50,100)
			sprite.texture = preload("res://Assets/Asteroids/NO1L.png")
		AsteroidNo.NO2L:
			speed = randi_range(50,100)
			sprite.texture = preload("res://Assets/Asteroids/NO2L.png")
		AsteroidNo.NO3L:
			speed = randi_range(50,100)
			sprite.texture = preload("res://Assets/Asteroids/NO3L.png")


func _process(delta):
	global_position += movement_vector.rotated(rotation) * speed * delta
