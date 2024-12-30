extends Control

#@onready var main_menu = preload("res://scenes/main_menu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_back_button_pressed() -> void:
	get_parent().main_menu()

func _on_tutorial_button_pressed() -> void:
	get_parent().switch_scene(preload("res://levels/0/0_multi_level.tscn"))


func _on_level_1_button_pressed() -> void:
	pass # Replace with function body.
