extends Area2D

@onready var player: CharacterBody2D = %"Player"
var game_started = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(position.distance_to(player.position))
	if game_started and position.distance_to(player.position) < 200:
		player.is_gravity = false
		player.position = player.position.move_toward(position, delta * 200)
	else:
		player.is_gravity = true


func start_game():
	game_started = true
