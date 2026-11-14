extends CharacterBody2D

var bulletScene = preload("res://items/bullet.tscn")
var deathEffect = preload("res://items/deathEffect.tscn")
@onready var enemy_death: AudioStreamPlayer2D = $"enemy death"

@onready var gunPoint = $gunPoint

func die():
	get_tree().current_scene.enemy_died()
	queue_free()

func _physics_process(delta: float) -> void:
	move_and_slide()
	
	for i in get_slide_collision_count():
		var collision := get_slide_collision(i)
		var collider := collision.get_collider()
		
		if collider.is_in_group("player") or collider.is_in_group("bullet"):
			var effect = deathEffect.instantiate()
			get_tree().current_scene.add_child(effect)
			effect.global_position = global_position
			enemy_death.play()
			die()
			queue_free()
			
			if collider.is_in_group("bullet"):
				collider.queue_free()


func _on_timer_timeout() -> void:
	print("Timer Out")
	var bullet = bulletScene.instantiate()
	bullet.enemy = self
	
	get_tree().current_scene.add_child(bullet)
	bullet.global_position = gunPoint.global_position
	var direction = Vector2.RIGHT.rotated(global_rotation)
	
	bullet.apply_central_impulse(direction * 500)
