extends Node2D

var pulls: int = 3
var ammo: float = 3
var enemies_left: int = 0

var has_ended: bool = false

var winDialogue = preload("res://menus/win.tscn")
var failDialogue = preload("res://menus/fail.tscn")

func _ready() -> void:
	enemies_left = get_tree().get_nodes_in_group("enemy").size()
	check_win()

func use_pull():
	pulls -= 1

	if pulls <= 0:
		show_fail()

func enemy_died():
	enemies_left -= 1
	check_win()

func check_win():
	if enemies_left <= 0:
		show_win()

func show_win():
	if has_ended:
		return

	has_ended = true
	show_dialogue(winDialogue)

func show_fail():
	if has_ended:
		return

	has_ended = true
	show_dialogue(failDialogue)

func show_dialogue(scene):
	var dialogue = scene.instantiate()
	dialogue.process_mode = Node.PROCESS_MODE_ALWAYS
	add_child(dialogue)
	get_tree().paused = true
	
func _process(delta: float) -> void:
	print(enemies_left)
