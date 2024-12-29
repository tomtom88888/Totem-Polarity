extends CharacterBody2D

var friction = 0.04
var is_gravity = false
@onready var lose_timer: Timer = $LoseTimer
var prev_pos
var game_started = false

func _ready() -> void:
	game_started = false
	prev_pos = position

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		if is_gravity:
			velocity += get_gravity() * delta
	velocity.x = lerp(velocity.x, 0.0, friction)
	move_and_slide()

func _process(delta: float) -> void:
	if game_started:
		lose_timer.start()
		game_started = false


func _on_lose_timer_timeout() -> void:
	if prev_pos == position:
		get_tree().reload_current_scene()
	else:
		prev_pos = position
