extends PlayerState
class_name PlayerStateCrouch

func init() -> void:
	pass

func enter() -> void:
	player.animation_player.play("Crouching")
	player.standing_collision_shape.disabled = true
	player.crouching_collision_shape.disabled = false

func exit() -> void:
	player.standing_collision_shape.disabled = false
	player.crouching_collision_shape.disabled = true

func handle_input(event: InputEvent) -> PlayerState:
	if event.is_action_pressed("jump"):
		player.one_way_platform_check.force_shapecast_update()
		if player.one_way_platform_check.is_colliding():
			print("fall through")
			player.set_collision_mask_value(2, false)
			player.position.y -= 0.5
			return fall
	return next_state

func process(_delta: float) -> PlayerState:
	player.animation_player.pause()
	if player.direction.y <= player.crouch_deadzone:
		return idle
	return next_state

func physics_process(delta: float) -> PlayerState:
	player.velocity.x -= player.velocity.x * player.deceleration_rate * delta
	
	if player.is_on_floor() == false:
		return fall
	
	return next_state
