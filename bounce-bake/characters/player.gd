extends RigidBody2D

@export var isDragging: bool = false
@export var dragStartPos: Vector2
@export var multiplier: int = 10
@export var push: Vector2 = Vector2.ZERO

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				if global_position.distance_to(get_global_mouse_position()) < 35:
					isDragging = true
					dragStartPos = get_global_mouse_position()
			else:
				if isDragging:
					push = (dragStartPos - get_global_mouse_position()) * multiplier
					isDragging = false
				

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if push != Vector2.ZERO:
		apply_central_impulse(push)
		push = Vector2.ZERO
