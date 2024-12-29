extends Node2D

@onready var delete_button: Button = $Control/HBoxContainer/DeleteButton
@onready var blue_button: Button = $Control/HBoxContainer/BlueButton
@onready var red_button: Button = $Control/HBoxContainer/RedButton
@onready var player: CharacterBody2D = %Player

@onready var blue_totems_left: Label = $Control/HBoxContainer/BlueButton/BlueTotemsLeft
@onready var red_totems_left: Label = $Control/HBoxContainer/RedButton/RedTotemsLeft

@export var red_totem_amount = 4
@export var blue_totem_amount = 3

@onready var red_totem_timer: Timer = $RedTotemTimer
@onready var blue_totem_timer: Timer = $BlueTotemTimer

var is_red = false
var is_blue = false

const RED_TOTEM = preload("res://scenes/red_totem.tscn")
const BLUE_TOTEM = preload("res://scenes/blue_totem.tscn")

var start_game
var can_place_blue = true
var can_place_red = true

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	blue_totems_left.text = str(blue_totem_amount)
	red_totems_left.text = str(red_totem_amount)
	
	if blue_totem_amount == 0:
		blue_button.modulate = Color("gray", 0.5)
	if red_totem_amount == 0:
		red_button.modulate = Color("gray", 0.5)
	if start_game:
		is_blue = false
		is_red = false
		red_button.visible = false
		blue_button.visible = false
		delete_button.visible = false

func _input(event: InputEvent) -> void:
	var mouse_pos = get_global_mouse_position()
	if event is not InputEventMouseButton:
		return
	if event.button_index != MOUSE_BUTTON_RIGHT and event.button_index != MOUSE_BUTTON_LEFT:
		return
	if event.button_index == MOUSE_BUTTON_RIGHT:
		print("fuck")
		get_tree().call_group("totems", "change_move_true")
		return
	if event.button_index == MOUSE_BUTTON_LEFT:
		get_tree().call_group("totems", "change_move_false")


	if is_blue and mouse_pos.y > 130 and event.button_index == MOUSE_BUTTON_LEFT and blue_totem_amount > 0 and can_place_blue:
		var blue_totem = BLUE_TOTEM.instantiate()
		blue_totem.player = player
		print("blue totem")
		blue_totem.global_position = snapped(mouse_pos, Vector2(64, 64))
		add_child(blue_totem)
		blue_totem_amount -= 1
		can_place_blue = false
		print(blue_totem_amount)
		blue_totem_timer.start()
	elif is_red and mouse_pos.y > 130 and event.button_index == MOUSE_BUTTON_LEFT and red_totem_amount > 0 and can_place_red:
		var red_totem = RED_TOTEM.instantiate()
		red_totem.player = player
		red_totem.global_position = snapped(mouse_pos, Vector2(64, 64))
		add_child(red_totem)
		red_totem_amount -= 1
		can_place_red = false
		red_totem_timer.start()


func _on_start_button_pressed() -> void:
	get_tree().call_group("totems", "start_game")
	player.is_gravity = true
	start_game = true


func _on_blue_button_pressed() -> void:
	if blue_totem_amount == 0:
		return
	if is_blue:
		is_blue = false
		is_red = false
		get_tree().call_group("totems", "change_move_false")
		get_tree().call_group("totems", "change_delete_false")
	else:
		is_blue = true
		is_red = false
		get_tree().call_group("totems", "change_move_false")
		get_tree().call_group("totems", "change_delete_false")

func _on_red_button_pressed() -> void:
	if red_totem_amount == 0:
		return
	if is_red:
		is_blue = false
		is_red = false
		get_tree().call_group("totems", "change_move_false")
		get_tree().call_group("totems", "change_delete_false")
	else:
		is_blue = false
		is_red = true
		get_tree().call_group("totems", "change_move_false")
		get_tree().call_group("totems", "change_delete_false")



func _on_red_totem_timer_timeout() -> void:
	can_place_red = true


func _on_blue_totem_timer_timeout() -> void:
	can_place_blue = true
