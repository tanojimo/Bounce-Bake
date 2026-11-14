extends Button

@export var normalSize: int = 24
@export var hoverSize: int = 32
@export var pressedSize: int = 20
@export var animationDuration: float = 0.15

var currentTween: Tween


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	button_down.connect(_on_button_down)
	button_up.connect(_on_button_up)
	add_theme_font_size_override("font_size", int(normalSize))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func animate_font_size(targetSize: float) -> void:
	if currentTween and currentTween.is_running():
		currentTween.kill()

	currentTween = create_tween()

	currentTween.set_trans(Tween.TRANS_BACK)
	currentTween.set_ease(Tween.EASE_OUT)

	currentTween.tween_method(
		set_font_size,
		get_theme_font_size("font_size"),
		targetSize,
		animationDuration
	)
	
func set_font_size(value: float) -> void:
	add_theme_font_size_override("font_size", roundi(value))
	
func _on_mouse_entered() -> void:
	animate_font_size(hoverSize)
	
func _on_mouse_exited() -> void:
	animate_font_size(normalSize)
	
func _on_button_down() -> void:
	animate_font_size(pressedSize)
	get_tree().quit()
	
func _on_button_up() -> void:
	if get_global_rect().has_point(get_global_mouse_position()):
		animate_font_size(hoverSize)
	else:
		animate_font_size(normalSize)
