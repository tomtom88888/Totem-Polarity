extends Area2D

var player
var game_started = false
@export var radius = 200
var is_dragging = false
var mouse_offset = Vector2.ZERO
var move = false
var delete = false
var draw_circ = true


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
	pass
	
func _process(delta: float) -> void:
	if is_dragging and move:
		global_position = snapped(get_global_mouse_position() + mouse_offset, Vector2(64, 64))
	if game_started and position.distance_to(player.position) < radius:
		if position.x < player.position.x:
			player.velocity.x = 90000 / position.distance_to(player.position)
		else:
			player.velocity.x = -1 * (90000 / position.distance_to(player.position))
			
func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and !delete and move:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			if event.pressed:
				is_dragging = true
				mouse_offset = global_position - get_global_mouse_position()
			else:
				is_dragging = false
	if event is InputEventMouseButton and delete and !move:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				queue_free()


func clear_radius_circle():
	draw_circ = false
	queue_redraw()

func _draw():
	if draw_circ:
		draw_circle(Vector2(0,0), radius, Color.ORANGE, false)
