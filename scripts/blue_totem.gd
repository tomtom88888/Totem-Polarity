extends Area2D

var player
var game_started = false
var radius = 300
@onready var is_blue = true

var is_dragging = false
var mouse_offset = Vector2.ZERO
var move = false
var delete = false
var draw_circ = true
var used = false
var prepeling

func change_move_true():
	move = true
	
func change_move_false():
	move = false

func change_delete_true():
	delete = true
	
func change_delete_false():
	delete = false

func start_game():
	game_started = true

func _ready() -> void:
	$Audio.play()
	
func _process(delta: float) -> void:
	if is_dragging and not game_started:
		global_position = snapped(get_global_mouse_position() + mouse_offset, Vector2(64, 64))
	var distance_from_player = position - player.position
	if is_dragging and move and not game_started:
		global_position = snapped(get_global_mouse_position() + mouse_offset, Vector2(64, 64))
	if game_started and position.distance_to(player.position) < 100:
		prepeling = true
		player.is_gravity = false
		var move_to_velocity = -(player.position.move_toward(position, delta * 200) - player.position) * 4
		used = false
		player.velocity += move_to_velocity
	elif prepeling and game_started and position.distance_to(player.position) < radius + 30:
		player.is_gravity = false
		var move_to_velocity = -(player.position.move_toward(position, delta * 200) - player.position) * 4
		player.velocity += move_to_velocity
		used = false
	elif position.distance_to(player.position) > radius and !used:
		prepeling = false
		player.is_gravity = true
		used = true
		
func timeout_drag():
	await get_tree().create_timer(0.5).timeout
	is_dragging = false

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and !delete and not get_parent().start_game:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			if event.is_pressed():
				is_dragging = true
				mouse_offset = global_position - get_global_mouse_position()
				timeout_drag()
			else:
				is_dragging=false
	if event is InputEventMouseButton and delete and !move:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				queue_free()


func clear_radius_circle():
	draw_circ = false
	queue_redraw()

func _draw():
	if draw_circ:
		draw_circle(Vector2(0,0), radius * 1.5, Color("2500CA"), false)
		draw_circle(Vector2(0,0), 100 * 1.5, Color("2500CA"), false)
