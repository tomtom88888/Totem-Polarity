extends Area2D
var player
var game_started = false
var used = false
@export var radius = 300
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(position.distance_to(player.position))
	if game_started and position.distance_to(player.position) < radius and not used and position.distance_to(player.position) > 30:
		player.is_gravity = false
		player.position = player.position.move_toward(position, delta * 200)
	elif game_started and position.distance_to(player.position) < 30:
		used = true
		player.is_gravity = true
		


func start_game():
	game_started = true
