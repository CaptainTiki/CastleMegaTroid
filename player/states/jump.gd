extends PlayerState
class_name PlayerStateJump

@export var jump_velocity : float = 11.5

func init() -> void:
	pass

func enter() -> void:
	player.add_debug_indicator(Color.LIME_GREEN)
	player.velocity.y = jump_velocity
	player.set_collision_mask_value(2, false)

func exit() -> void:
	player.add_debug_indicator(Color.YELLOW)
	pass

func handle_input( event : InputEvent ) -> PlayerState:
	if event.is_action_released("jump"):
		player.velocity *= 0.5
		return fall
	return next_state

func process(_delta: float) -> PlayerState:
	return next_state

func physics_process(_delta: float) -> PlayerState:
	#if we get bugs where the player lands EXACTLY on the floor at 0 velocity - may need this to fix bug
	#if player.is_on_floor() and player.velocity.y <= 0:
		#return idle
	if player.velocity.y <= 0:
		return fall
	
	player.velocity.x = player.direction.x * player.move_speed
	
	return next_state
