extends PlayerState
class_name PlayerStateJump

@export var jump_velocity : float = 11.5

func init() -> void:
	pass

func enter() -> void:
	player.animation_player.play("Jump_Start")
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
	if player.velocity.y <= 0:
		return fall
	
	player.velocity.x = player.direction.x * player.move_speed
	
	return next_state
