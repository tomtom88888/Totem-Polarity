extends Node2D


@export var camera_zoom = 1.0
@onready var delete_button: Button = $Control/HBoxContainer/DeleteButton
@onready var blue_button: Button = $Control/HBoxContainer/BlueButton
@onready var red_button: Button = $Control/HBoxContainer/RedButton
@onready var player: CharacterBody2D = %Player

@onready var blue_totems_left: Label = $Control/HBoxContainer/BlueButton/BlueTotemsLeft
@onready var red_totems_left: Label = $Control/HBoxContainer/RedButton/RedTotemsLeft

@export var red_totem_amount = 20
@export var blue_totem_amount = 20
@export var level = 0
@export var course = 3

@onready var red_totem_timer: Timer = $RedTotemTimer
@onready var blue_totem_timer: Timer = $BlueTotemTimer
@onready var win_scene = preload("res://scenes/win.tscn") as PackedScene

signal goIntoExit


var draw_grid = true
var is_red = false
var is_blue = false

const RED_TOTEM = preload("res://scenes/red_totem.tscn")
const BLUE_TOTEM = preload("res://scenes/blue_totem.tscn")

var start_game
var can_place_blue = true
var can_place_red = true

func delete_grid():
	draw_grid = false
	queue_redraw()

func _draw() -> void:
	if draw_grid:
		for row in range(32, 1500, 64):
			draw_line(Vector2(row, 0), Vector2(row, 1000), Color(0,0,0,0.2), 1.0)
		for col in range(32, 1500, 64):
			draw_line(Vector2(0, col), Vector2(1500, col), Color(0,0,0,0.2), 1.0)

func _ready() -> void:
	$Camera2D.zoom.x = camera_zoom
	$Camera2D.zoom.y = camera_zoom
	$Control.scale.x = 1/camera_zoom
	$Control.scale.y = 1/camera_zoom
	SoundPlayer.stop()


func _process(_delta: float) -> void:
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
	#if event.button_index == MOUSE_BUTTON_RIGHT:
		#print("fuck")
		#get_tree().call_group("totems", "change_move_true")
		#return
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
	get_tree().call_group("totems", "clear_radius_circle")
	delete_grid()
	player.is_gravity = true
	player.game_started = true
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


func _on_win_entered(body: Node2D) -> void:
	goIntoExit.emit()


func _on_delete_area_area_entered(area: Area2D) -> void:
	if area.is_blue:
		blue_totem_amount += 1
	else:
		red_totem_amount += 1
	area.queue_free()


func _on_back_button_pressed() -> void:
	#get_tree().change_scene_to_file("res://scenes/level_menu.tscn")
	#get_parent().switch_scene(preload("res://scenes/level_menu.tscn"))
	get_parent().get_parent().to_level_menu()


func _on_level_anim_finished() -> void:
	SoundPlayer.stream = preload("res://sounds/InGameMusic.wav")
	SoundPlayer.play()


func _on_grid_button_toggled(toggled_on: bool) -> void:
	draw_grid = toggled_on
	queue_redraw()
		
