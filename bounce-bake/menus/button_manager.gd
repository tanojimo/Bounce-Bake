extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$level1.pressed.connect(change_scene.bind("res://levels/level1.tscn"))
	$level2.pressed.connect(change_scene.bind("res://levels/level2.tscn"))
	$level3.pressed.connect(change_scene.bind("res://levels/level3.tscn"))
	$level4.pressed.connect(change_scene.bind("res://levels/level4.tscn"))
	$level5.pressed.connect(change_scene.bind("res://levels/level5.tscn"))

func change_scene(path: String) -> void:
	get_tree().change_scene_to_file(path)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
