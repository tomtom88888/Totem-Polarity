class_name MainMenu
extends Control

@onready var start_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/StartButton as Button
@onready var start_level = preload("res://scenes/level_menu.tscn") as PackedScene

func _ready():
	start_button.button_down.connect(on_start_button_pressed)

func on_start_button_pressed() -> void:
	get_tree().change_scene_to_packed(start_level)


func _on_main_menu_music_finished() -> void:
	$menu_music.play()
