extends RigidBody2D

var player: RigidBody2D
var moving: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_collision_exception_with(player)
	await get_tree().create_timer(0.3).timeout
	remove_collision_exception_with(player)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if linear_velocity.length() > 100:
		moving = true
	if linear_velocity.length() < 70 and moving:
		queue_free()
