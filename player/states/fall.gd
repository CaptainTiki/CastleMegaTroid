extends PlayerState
class_name PlayerStateFall

@export var coyote_time: float = 0.125
@export var gravity_fall_multiplier: float = 1.75
@export var jump_buffer_time: float = 0.125

var coyote_timer: float = 0.0
var jump_buffer_timer: float = 0.0
var previous_gravity_multiplier: float = 1.0

var one_way_collision_interruption : bool = false

func enter() -> void:
	player.animation_player.play("Jump_Idle")
	
	previous_gravity_multiplier = player.gravity_fall_multiplier
	player.gravity_fall_multiplier = gravity_fall_multiplier
	
	coyote_timer = 0.0
	jump_buffer_timer = 0.0
	
	if player.previous_state != jump:
		coyote_timer = coyote_time
	
	player.one_way_detector.force_shapecast_update()
	if not player.one_way_detector.is_colliding():
		player.set_collision_mask_value(2, true)
	else:
		one_way_collision_interruption = true

func exit() -> void:
	player.animation_player.play("Jump_Land")
	player.gravity_fall_multiplier = previous_gravity_multiplier
	player.add_debug_indicator(Color.RED)
	player.one_way_detector.enabled = false
	jump_buffer_timer = 0

func handle_input(event: InputEvent) -> PlayerState:
	if event.is_action_pressed("jump"):
		if coyote_timer > 0.0:
			return jump
		jump_buffer_timer = jump_buffer_time
		player.add_debug_indicator(Color.BLUE)
	return next_state


func process(_delta: float) -> PlayerState:
	return next_state


func physics_process(delta: float) -> PlayerState:
	coyote_timer -= delta
	jump_buffer_timer -= delta
	player.velocity.x = player.direction.x * player.move_speed
	
	if one_way_collision_interruption:
		if not player.one_way_detector.is_colliding():
			one_way_collision_interruption = false
			player.set_collision_mask_value(2, true)
	
	if player.is_on_floor():
		if jump_buffer_timer > 0.0:
			return jump
		return idle
	return next_state
