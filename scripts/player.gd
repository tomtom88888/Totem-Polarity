extends CharacterBody2D

var friction = 0.032
var is_gravity = false
@onready var lose_timer: Timer = $LoseTimer
var prev_pos
var game_started = false
var spam_prev = false
signal modulate_screen

@onready var multi_level_logic: Node2D = get_parent().get_parent()
@onready var lose_sound = preload("res://sounds/lose_sound.mp3")
@onready var ing_music = preload("res://sounds/InGameMusic.wav")


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
	if position.distance_to(prev_pos) < 20 and not spam_prev:
		spam_prev = true
		print("die")
		modulate_screen.emit()
		SoundPlayer.stop()
		SoundPlayer.stream = lose_sound
		SoundPlayer.play()
		await get_tree().create_timer(3).timeout
		multi_level_logic.reload_current_course()
		SoundPlayer.stream = ing_music
	else:
		prev_pos = position
		
