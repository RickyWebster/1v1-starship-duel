extends Area2D

@export var speed := 600
var movement_vector := Vector2(0, -1)
var particle_scene = preload("res://Effects/death_particle.tscn")


func _physics_process(delta):
	global_position += movement_vector.rotated(rotation) * speed * delta
	if passer.death == true:
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_body_entered(body):
	if body.name == ("Ship1"):
		passer.player_hit = [true, "Ship1"]
		queue_free()
		passer.p1_health -= 4
	if body.name == ("Ship2"):
		passer.player_hit = [true, "Ship2"]
		emit_signal("player_hit", "Ship2")
		queue_free()
		passer.p2_health -= 4
	if "space_rock" in str(body.name):
		for i in range(20):
			var particle = particle_scene.instantiate()
			particle.rotation = rotation + deg_to_rad(i * 18)
			particle.z_index = 100
			$Particles.add_child(particle)
		if $Sprite2D:
			$Sprite2D.queue_free()
		if $GPUParticles2D:
			$GPUParticles2D.queue_free()
		if $CollisionShape2D:
			$CollisionShape2D.queue_free()
		await get_tree().create_timer(0.3).timeout
		queue_free()
