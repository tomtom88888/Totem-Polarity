extends Node2D

@onready var delete_button: Button = $Control/HBoxContainer/DeleteButton
@onready var blue_button: Button = $Control/HBoxContainer/BlueButton
@onready var red_button: Button = $Control/HBoxContainer/RedButton
@onready var move_button: Button = $Control/HBoxContainer/MoveButton
@onready var player: CharacterBody2D = %Player
var is_red = false
var is_blue = false
var move = false
var delete = false
const RED_TOTEM = preload("res://scenes/red_totem.tscn")
const BLUE_TOTEM = preload("res://scenes/blue_totem.tscn")
var start_game
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if start_game:
		is_blue = false
		is_red = false
		move = false
		delete = false
		red_button.visible = false
		blue_button.visible = false
		move_button.visible = false
		delete_button.visible = false

func _input(event: InputEvent) -> void:
	var mouse_pos = get_global_mouse_position()
	if is_blue and event is InputEventMouseButton and mouse_pos.y > 130:
		var blue_totem = BLUE_TOTEM.instantiate()
		blue_totem.player = player
		blue_totem.global_position = mouse_pos
		add_child(blue_totem)
	elif is_red and event is InputEventMouseButton and mouse_pos.y > 130:
		var red_totem = RED_TOTEM.instantiate()
		red_totem.player = player
		red_totem.global_position = mouse_pos
		add_child(red_totem)


func _on_start_button_pressed() -> void:
	get_tree().call_group("totems", "start_game")
	start_game = true


func _on_blue_button_pressed() -> void:
	if is_blue:
		is_blue = false
		is_red = false
		move = false
		delete = false
		get_tree().call_group("totems", "change_move_false")
		get_tree().call_group("totems", "change_delete_false")
	else:
		is_blue = true
		is_red = false
		move = false
		delete = false
		get_tree().call_group("totems", "change_move_false")
		get_tree().call_group("totems", "change_delete_false")

func _on_red_button_pressed() -> void:
	if is_red:
		is_blue = false
		is_red = false
		move = false
		delete = false
		get_tree().call_group("totems", "change_move_false")
		get_tree().call_group("totems", "change_delete_false")
	else:
		is_blue = false
		is_red = true
		move = false
		delete = false
		get_tree().call_group("totems", "change_move_false")
		get_tree().call_group("totems", "change_delete_false")


func _on_move_button_pressed() -> void:
	if move:
		is_blue = false
		is_red = false
		move = false
		delete = false
		get_tree().call_group("totems", "change_move_false")
		get_tree().call_group("totems", "change_delete_false")
	else:
		is_blue = false
		is_red = false
		move = true
		delete = false
		get_tree().call_group("totems", "change_move_true")
		get_tree().call_group("totems", "change_delete_false")
		
func _on_delete_button_pressed() -> void:
	if delete:
		is_blue = false
		is_red = false
		move = false
		delete = false
		get_tree().call_group("totems", "change_move_false")
		get_tree().call_group("totems", "change_delete_false")
	else:
		is_blue = false
		is_red = false
		delete = true
		move = false
		get_tree().call_group("totems", "change_move_false")
		get_tree().call_group("totems", "change_delete_true")
	print(delete)
