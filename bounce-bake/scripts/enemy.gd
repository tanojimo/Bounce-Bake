extends CharacterBody2D




func _physics_process(delta: float) -> void:
	move_and_slide()
	
	for i in get_slide_collision_count():
		var collision := get_slide_collision(i)
		var collider := collision.get_collider()
		
		if collider.is_in_group("player") or collider.is_in_group("bullet"):
			queue_free()
			if collider.is_in_group("bullet"):
				collider.queue_free()
