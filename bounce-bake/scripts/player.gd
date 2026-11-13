extends RigidBody2D

var bulletScene = preload("res://items/bullet.tscn")

@onready var gunPoint = $gunPoint

@export var isDragging: bool = false
@export var dragStartPos: Vector2
@export var multiplier: int = 50
@export var minPull: int = 10
@export var maxPull: int = 150
@export var push: Vector2 = Vector2.ZERO
@export var running: bool = false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				if global_position.distance_to(get_global_mouse_position()) < 35:
					isDragging = true
					dragStartPos = get_global_mouse_position()
				else:
					var bullet = bulletScene.instantiate()
					
					get_tree().current_scene.add_child(bullet)
					bullet.global_position = gunPoint.global_position
					var direction = (get_global_mouse_position() - gunPoint.global_position).normalized()
					
					bullet.apply_central_impulse(direction * 500)
					
			else:
				if isDragging:
					var dragVector = dragStartPos - get_global_mouse_position()
					if dragVector.length() >= minPull:
						dragVector = dragVector.limit_length(maxPull)
						push = dragVector * multiplier
					isDragging = false
				

func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	if push != Vector2.ZERO:
		apply_central_impulse(push * delta)
		push = Vector2.ZERO
		running = true
	if linear_velocity.length() < 70 and running == true:
		print("running velocity length zero")
		linear_velocity = Vector2.ZERO
		running = false
		
func _process(delta: float) -> void:
	pass
