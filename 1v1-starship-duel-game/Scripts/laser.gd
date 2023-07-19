extends Area2D

@export var speed := 800

var movement_vector := Vector2(0, -1)


func _physics_process(delta):
	global_position += movement_vector.rotated(rotation) * speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

