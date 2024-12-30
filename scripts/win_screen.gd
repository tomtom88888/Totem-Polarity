extends Control

var level_menu = preload("res://scenes/level_menu.tscn")
@onready var t_itle: Label = $TItle
var level = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	t_itle.text = "You Passed Level " + str(level)

func _on_next_level_button_pressed() -> void:
	get_parent().switch_scenes(level_menu)


func _on_level_menu_button_pressed() -> void:
	get_parent().switch_scenes(level_menu)
