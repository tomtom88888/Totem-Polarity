extends Control

@onready var scene_transition_animation: AnimationPlayer = $SceneTransitionAnimation/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_tutorial_button_pressed() -> void:
	print("fuck")
	scene_transition_animation.play("fade_in")
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://scenes/level_template.tscn")



#func _on_tutorial_button_down() -> void:
	#print("fuck")
	#scene_transition_animation.play("fade_in")
	#await get_tree().create_timer(0.5).timeout
	#get_tree().change_scene_to_file("res://scenes/level_template.tscn")


func _on_back_button_pressed() -> void:
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
