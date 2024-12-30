extends Area2D
var player
var game_started = false
var used = false
var radius = 320
@onready var is_blue = false

var no_spam_drag = false
var is_dragging = false
var mouse_offset = Vector2.ZERO
var move = false
var delete
# Called when the node enters the scene tree for the first time.
var draw_circ = true

func clear_radius_circle():
	draw_circ = false
	queue_redraw()

func change_move_true():
	move = true
	
func change_move_false():
	move = false

func change_delete_true():
	delete = true
	
func change_delete_false():
	delete = false

func _draw():
	if draw_circ:
		draw_circle(Vector2(0,0), radius * 1.3, Color("CA3131"), false)


func _ready() -> void:
	$Audio.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_dragging and not game_started:
		global_position = snapped(get_global_mouse_position() + mouse_offset, Vector2(64, 64))
	if position.distance_to(player.position) < radius:
		print(position.distance_to(player.position))
	if game_started and position.distance_to(player.position) < radius and not used and position.distance_to(player.position) > 70:
		print(position.distance_to(player.position))
		player.is_gravity = false
		var move_to_velocity = (player.position.move_toward(position, delta * 200) - player.position) * 4
		# move_to_velocity.y = move_to_velocity.y * 10
		player.velocity += move_to_velocity
	elif game_started and position.distance_to(player.position) < 70:
		used = true
		player.is_gravity = true

func start_game():
	game_started = true



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
