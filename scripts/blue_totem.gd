extends Area2D
var player
var game_started = false
var used = false
@export var radius = 300
var is_dragging = false
var mouse_offset = Vector2.ZERO
var move = false
var delete
# Called when the node enters the scene tree for the first time.

func change_move_true():
	move = true
	
func change_move_false():
	move = false

func change_delete_true():
	delete = true
	
func change_delete_false():
	delete = false

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_dragging and move:
		global_position = snapped(get_global_mouse_position() + mouse_offset, Vector2(64, 64))
	if game_started and position.distance_to(player.position) < radius and not used and position.distance_to(player.position) > 30:
		player.is_gravity = false
		player.position = player.position.move_toward(position, delta * 200)
	elif game_started and position.distance_to(player.position) < 30:
		used = true
		player.is_gravity = true

func start_game():
	game_started = true
	
func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
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
