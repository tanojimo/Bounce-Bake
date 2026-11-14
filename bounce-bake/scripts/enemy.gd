extends CharacterBody2D

var deathEffect = preload("res://items/deathEffect.tscn")

func _physics_process(delta: float) -> void:
	move_and_slide()
	
	for i in get_slide_collision_count():
		var collision := get_slide_collision(i)
		var collider := collision.get_collider()
		
		if collider.is_in_group("player") or collider.is_in_group("bullet"):
			var effect = deathEffect.instantiate()
			get_tree().current_scene.add_child(effect)
			effect.global_position = global_position
			queue_free()
			if collider.is_in_group("bullet"):
				collider.queue_free()
