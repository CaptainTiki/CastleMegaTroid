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
		if check_oneway_platform():
			player.dropping_through_one_way = true
			player.set_collision_mask_value(2, false)
			player.velocity.y = -1.5
			return fall
		return jump
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

func check_oneway_platform() -> bool:
	for r in player.one_way_detector.get_children():
		if r is RayCast3D:
			if r.is_colliding():
				return true
	return false
