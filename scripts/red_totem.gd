extends Area2D

var player
var game_started = false
var friction = 0.04
@export var radius = 200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(position.distance_to(player.position))
	if game_started and position.distance_to(player.position) < radius:
		if position.x < player.position.x:
			player.velocity.x = 70000 / position.distance_to(player.position)
		else:
			player.velocity.x = -1 * (70000 / position.distance_to(player.position))
	else:
		player.velocity.x = lerp(player.velocity.x, 0.0, friction)

func start_game():
	game_started = true
