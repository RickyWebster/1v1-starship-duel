extends Node2D

@onready var lasers = $Lasers
@onready var rocks = $Rocks
@onready var player1 = $Ship1
@onready var player2 = $Ship2
@export var death_effect: PackedScene

var laserTextureRed: Texture = load("res://Assets/bullets/Laser_red.png")
var laserTextureArrow: Texture = load("res://Assets/bullets/Laser_arrow.png")
var laserTextureBlue: Texture = load("res://Assets/bullets/Laser_red.png")
var rock_scene = preload("res://Scenes/asteroid.tscn")


func _ready():
	player1.connect("laser_shot1", _on_player_laser_shot1)
	player2.connect("laser_shot2", _on_player_laser_shot2)
	
	for i in range(4):
		var rok = rock_scene.instantiate()
		rocks.add_child(rok)

func _on_player_laser_shot1(laser, damaged):
	var laserParticle = laser.get_node("GPUParticles2D")
	if damaged != 4:
		var laserSprite = laser.get_node("Sprite2D")
		laserSprite.texture = laserTextureArrow
		laserParticle.set_modulate(Color8(225,0,0))
	elif passer.colour1 == 1: 
		var laserSprite = laser.get_node("Sprite2D")
		laserSprite.texture = laserTextureRed
		laserParticle.set_modulate(Color8(225,175,170))
	else:
		laserParticle.set_modulate(Color8(158,195,218))
	lasers.add_child(laser)

func _on_player_laser_shot2(laser, damaged):
	var laserParticle = laser.get_node("GPUParticles2D")
	if damaged != 4:
		var laserSprite = laser.get_node("Sprite2D")
		laserSprite.texture = laserTextureArrow
		laserParticle.set_modulate(Color8(225,0,0))
	elif passer.colour2 == 1:
		var laserSprite = laser.get_node("Sprite2D")
		laserSprite.texture = laserTextureRed
		laserParticle.set_modulate(Color8(225,175,170))
	else:
		laserParticle.set_modulate(Color8(158,195,218))
	lasers.add_child(laser)


func _on_ship_1_show_death(pos):
	for i in range(2):
		var effect_intsnace: GPUParticles2D = death_effect.instantiate()
		effect_intsnace.emitting = true
		if i == 0:
			effect_intsnace.set_self_modulate(Color8(255,58,23))
		else: 
			effect_intsnace.set_self_modulate(Color8(91,169,225))
		effect_intsnace.scale = Vector2(4, 4)
		effect_intsnace.global_position = pos
		$GUI_Elements.add_child(effect_intsnace)


func _on_ship_2_show_death(pos):
	for i in range(2):
		var effect_intsnace: GPUParticles2D = death_effect.instantiate()
		effect_intsnace.emitting = true
		if i == 0:
			effect_intsnace.set_self_modulate(Color8(255,58,23))
		else: 
			effect_intsnace.set_self_modulate(Color8(225,163,68))
		effect_intsnace.scale = Vector2(4, 4)
		effect_intsnace.global_position = pos
		$GUI_Elements.add_child(effect_intsnace)
