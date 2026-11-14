
extends RigidBody2D

var bulletScene = preload("res://items/bullet.tscn")
var level

@onready var motionTrail: Line2D = $Line2D
@onready var gunPoint = $gunPoint
@onready var gunshot: AudioStreamPlayer2D = $gunshot
@onready var bounce: AudioStreamPlayer2D = $"../Cake/bounce"

@export var isDragging: bool = false
@export var dragStartPos: Vector2
@export var multiplier: int = 50
@export var minPull: int = 10
@export var maxPull: int = 150
@export var push: Vector2 = Vector2.ZERO


func _ready() -> void:
	level = get_tree().current_scene

	contact_monitor = true
	max_contacts_reported = 4


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				if level.pulls > 0:
					isDragging = true
					dragStartPos = get_global_mouse_position()
			else:
				if isDragging:
					var dragVector = dragStartPos - get_global_mouse_position()

					if dragVector.length() >= minPull:
						dragVector = dragVector.limit_length(maxPull)
						push = dragVector * multiplier
						level.use_pull()

					isDragging = false
					motionTrail.clear_points()

	elif event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_SPACE:
			if level.ammo > 0:
				var bullet = bulletScene.instantiate()
				bullet.player = self

				get_tree().current_scene.add_child(bullet)
				bullet.global_position = gunPoint.global_position

				var direction = (gunPoint.global_position - get_global_mouse_position()).normalized()

				gunshot.play()
				level.ammo -= 1
				bullet.apply_central_impulse(direction * 500)


func _physics_process(delta: float) -> void:
	if linear_velocity.length() < 30:
		look_at(get_global_mouse_position())
		rotation += PI

	if push != Vector2.ZERO:
		apply_central_impulse(push * delta)
		push = Vector2.ZERO


func _process(delta: float) -> void:
	if isDragging:
		var dragVector = dragStartPos - get_global_mouse_position()
		var lineLength = min(dragVector.length(), maxPull)

		if lineLength >= minPull:
			var direction = global_transform.basis_xform_inv(-dragVector.normalized())

			motionTrail.clear_points()
			motionTrail.add_point(Vector2.ZERO)
			motionTrail.add_point(direction * lineLength)
		else:
			motionTrail.clear_points()
	else:
		motionTrail.clear_points()
