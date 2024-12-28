extends CharacterBody2D

var friction = 0.04
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var is_gravity = true

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		if is_gravity:
			velocity += get_gravity() * delta
		else:
			velocity.y = 0
	velocity.x = lerp(velocity.x, 0.0, friction)
	move_and_slide()
