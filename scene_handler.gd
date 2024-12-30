extends Node

@onready var scene_transition_animation: AnimationPlayer = $AnimationPlayer
var current_scene
var main_menu_node
var level_menu_scene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main_menu_node = preload("res://scenes/main_menu.tscn")
	current_scene = main_menu_node.instantiate()
	add_child(current_scene)
	level_menu_scene = preload("res://scenes/level_menu.tscn")
	

func main_menu():
	scene_transition_animation.play("fade_in")
	await get_tree().create_timer(0.5).timeout
	
	current_scene.queue_free()
	current_scene = main_menu_node.instantiate()
	
	scene_transition_animation.play("fade_out")
	add_child(current_scene)

func switch_scene_to_instance(instance):
	# get instance
	scene_transition_animation.play("fade_in")
	await get_tree().create_timer(0.5).timeout
	
	current_scene.queue_free()
	current_scene = instance
	
	scene_transition_animation.play("fade_out")
	add_child(current_scene)

func switch_scene(scene):
	# get preloaded scene
	scene_transition_animation.play("fade_in")
	await get_tree().create_timer(0.5).timeout
	
	current_scene.queue_free()
	current_scene = scene.instantiate()
	
	scene_transition_animation.play("fade_out")
	add_child(current_scene)

func to_level_menu():
	switch_scene(level_menu_scene)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
