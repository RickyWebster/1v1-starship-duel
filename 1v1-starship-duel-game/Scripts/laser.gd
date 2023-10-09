extends Area2D

@export var speed := 600
@onready var asteroid_hit_audio = $AsteroidHitAudio
var movement_vector := Vector2(0, -1)
var particle_scene = preload("res://Effects/Asteroid_particle.tscn")
var laserTextureArrow: Texture = load("res://Assets/bullets/Laser_arrow.png")


func _physics_process(delta):
	global_position += movement_vector.rotated(rotation) * speed * delta
	if passer.death == true:
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_body_entered(body):
	if body.name == ("Ship1"):
		passer.player_hit = [true, "Ship1"]
		passer.p1_health -= 4
		if $Sprite2D.texture == laserTextureArrow:
			passer.p1_health -= 71
		queue_free()
	if body.name == ("Ship2"):
		passer.player_hit = [true, "Ship2"]
		passer.p2_health -= 4
		if $Sprite2D.texture == laserTextureArrow:
			passer.p2_health -= 71
		queue_free()
	if "space_rock" in str(body.name):
		if passer.mute_sounds:
			asteroid_hit_audio.play()
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
