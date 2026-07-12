extends CharacterBody3D
class_name Player


const SPEED = 5.0
const JUMP_VELOCITY = 8
const GRAVITY = -16

func _physics_process(delta: float) -> void:
	velocity.x = 0
	if Input.is_action_pressed("left"):
		velocity.x = -SPEED
	elif Input.is_action_pressed("right"):
		velocity.x = SPEED
	velocity.y = velocity.y + GRAVITY * delta

	move_and_slide()
