extends Area2D

@export var speed := 600
var movement_vector := Vector2(0, -1)


func _physics_process(delta):
	global_position += movement_vector.rotated(rotation) * speed * delta
	if passer.death == true:
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_body_entered(body):
	if body.name == ("Ship1"):
		queue_free()
		passer.p1_health -= 4
	if body.name == ("Ship2"):
		queue_free()
		passer.p2_health -= 4
		


