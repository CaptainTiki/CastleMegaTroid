extends PlayerState
class_name PlayerStateFall

@export var coyote_time : float = 0.125
@export var gravity_fall_multiplier : float = 1.75
@export var jump_buffer_time : float = 0.125

var coyote_timer : float = 0
var gravity_at_jump = 1.0
var jump_buffer_timer : float = 0

func init() -> void:
	pass

func enter() -> void:
	if player.debug:
		player.gravity_fall_multiplier = gravity_fall_multiplier
	
	gravity_at_jump = player.gravity_fall_multiplier
	if player.previous_state == jump:
		coyote_timer = 0
	else:
		coyote_timer = coyote_time

func exit() -> void:
	player.gravity_fall_multiplier = gravity_at_jump
	player.add_debug_indicator(Color.RED)
	pass

func handle_input( event : InputEvent ) -> PlayerState:
	if event.is_action_pressed("jump"):
		if coyote_timer > 0:
			return jump
		else: 
			jump_buffer_timer = jump_buffer_time
			player.add_debug_indicator(Color.BLUE)
	return next_state

func process(delta: float) -> PlayerState:
	coyote_timer -= delta
	jump_buffer_timer -= delta
	return next_state

func physics_process(_delta: float) -> PlayerState:
	if player.is_on_floor():
		if jump_buffer_timer >= 0:
			return jump
		return idle
		
	player.velocity.x = player.direction.x * player.move_speed
	
	return next_state
