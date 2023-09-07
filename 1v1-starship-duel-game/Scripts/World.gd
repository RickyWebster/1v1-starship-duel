extends Node2D

@onready var lasers = $Lasers
@onready var rocks = $Rocks
@onready var player1 = $Ship1
@onready var player2 = $Ship2

var laserTextureRed: Texture = load("res://Assets/bullets/Laser_red.png")
var laserTextureBlue: Texture = load("res://Assets/bullets/Laser_red.png")
var rock_scene = preload("res://Scenes/asteroid.tscn")


func _ready():
	player1.connect("laser_shot1", _on_player_laser_shot1)
	player2.connect("laser_shot2", _on_player_laser_shot2)
	
	for i in range(4):
		var rok = rock_scene.instantiate()
		rocks.add_child(rok)

func _on_player_laser_shot1(laser):
	if passer.colour1 == 1:
		var laserSprite = laser.get_node("Sprite2D")
		laserSprite.texture = laserTextureRed
		#var laserParticle = laser.get_node("GPUParticles2D")
	lasers.add_child(laser)

func _on_player_laser_shot2(laser):
	if passer.colour2 == 1:
		var laserSprite = laser.get_node("Sprite2D")
		laserSprite.texture = laserTextureRed
	lasers.add_child(laser)
