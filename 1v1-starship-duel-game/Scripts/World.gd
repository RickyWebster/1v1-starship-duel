extends Node2D

@onready var lasers = $Lasers
@onready var player1 = $Ship1
@onready var player2 = $Ship2

func _ready():
	player1.connect("laser_shot", _on_player_laser_shot)
	player2.connect("laser_shot", _on_player_laser_shot)

func _on_player_laser_shot(laser):
	lasers.add_child(laser)
