extends PlayerState
class_name PlayerStateCrouch



func init() -> void:
	pass

func enter() -> void:
	player.standing_collision_shape.disabled = true
	player.crouching_collision_shape.disabled = false
	player.mesh_instance.scale.y = 0.5
	player.mesh_instance.position.y -= 0.5

func exit() -> void:
	player.standing_collision_shape.disabled = false
	player.crouching_collision_shape.disabled = true
	player.mesh_instance.scale.y = 1
	player.mesh_instance.position.y += 0.5

func handle_input( _event : InputEvent ) -> PlayerState:
	if _event.is_action_pressed("jump"):
		if player.fall_raycast.is_colliding():
			player.set_collision_mask_value(2, false)
			return fall
		return jump
	return next_state

func process(_delta: float) -> PlayerState:
	if player.direction.y <= player.crouch_deadzone:
		return idle
	return next_state

func physics_process(delta: float) -> PlayerState:
	player.velocity.x -= player.velocity.x * player.deceleration_rate * delta
	
	if player.is_on_floor() == false:
		return fall
	
	return next_state
