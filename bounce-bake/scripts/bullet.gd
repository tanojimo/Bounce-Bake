extends RigidBody2D

var player: RigidBody2D
var enemy: CharacterBody2D
var moving: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if player != null:
		add_collision_exception_with(player)
		await get_tree().create_timer(0.3).timeout
		if is_instance_valid(player):
			remove_collision_exception_with(player)
	if enemy != null:
		contact_monitor = true
		max_contacts_reported = 4
		body_entered.connect(_on_body_entered)
		
func _on_body_entered(body: Node) -> void:
	print("Bullet hit: ", body.name)
	print("Is wall: ", body.is_in_group("wall"))
	if body.is_in_group("wall"):
		queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if linear_velocity.length() > 100:
		moving = true
	if linear_velocity.length() < 70 and moving:
		queue_free()
