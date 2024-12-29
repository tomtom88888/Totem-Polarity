class_name MainMenu
extends Control

@onready var start_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/StartButton as Button
@onready var exit_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/ExitButton as Button
@onready var start_level = preload("res://scenes/level_1.tscn") as PackedScene

func _ready():
	start_button.button_down.connect(on_start_button_pressed)
	exit_button.button_down.connect(on_exit_button_pressed)

	

func on_start_button_pressed() -> void:
	get_tree().change_scene_to_packed(start_level)

func on_exit_button_pressed() -> void:
		get_tree().quit()
