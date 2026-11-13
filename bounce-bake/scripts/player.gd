extends RigidBody2D

@export var isDragging: bool = false
@export var dragStartPos: Vector2
@export var multiplier: int = 50
@export var minPull: int = 10
@export var maxPull: int = 150
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
