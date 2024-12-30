extends Control

var level_menu = preload("res://scenes/level_menu.tscn")
@onready var t_itle: Label = $TItle
var level = 1

var levels_scene_dict = {
	0: preload("res://levels/0/0_multi_level.tscn"),
	1: preload("res://levels/1/1_multi_level.tscn")
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	t_itle.text = "You Passed Level " + str(level)

func _on_next_level_button_pressed() -> void:
	get_parent().switch_scene(levels_scene_dict[LevelData.level + 1])


func _on_level_menu_button_pressed() -> void:
	get_parent().switch_scene(level_menu)
