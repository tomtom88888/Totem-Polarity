extends Node2D

var is_red
var is_blue
const RED_TOTEM = preload("res://scenes/red_totem.tscn")
const BLUE_TOTEM = preload("res://scenes/blue_totem.tscn")
@onready var player: CharacterBody2D = %Player
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if is_red and event is InputEventMouseButton:
		var blue_totem = BLUE_TOTEM.instantiate()
		blue_totem.player = player
		blue_totem.position = get_viewport().get_mouse_position()
		add_child(blue_totem)
	if is_red and event is InputEventMouseButton:
		var red_totem = RED_TOTEM.instantiate()
		red_totem.player = player
		red_totem.position = get_viewport().get_mouse_position()
		add_child(red_totem)


func _on_button_pressed() -> void:
	print("start")
	get_tree().call_group("totems", "start_game")


func _on_blue_button_pressed() -> void:
	if is_blue:
		is_blue = false
		is_red = false
	else:
		is_blue = true
		is_red = false

func _on_red_button_pressed() -> void:
	if is_red:
		is_blue = false
		is_red = false
	else:
		is_blue = false
		is_red = true
