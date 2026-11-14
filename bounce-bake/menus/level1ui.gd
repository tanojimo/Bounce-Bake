extends Control

@onready var label1 = $Label
@onready var label2 = $Label2

var level

func _ready():
	level = owner

func _process(delta):
	label1.text = "x %d" % level.ammo
	label2.text = "x %d" % level.pulls
