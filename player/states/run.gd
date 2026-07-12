extends PlayerState
class_name PlayerRunState

func init() -> void:
	pass

func enter() -> void:
	pass

func exit() -> void:
	pass

func handle_input( _event : InputEvent ) -> PlayerState:
	return next_state

func process(_delta: float) -> PlayerState:
	return next_state

func physics_process(_delta: float) -> PlayerState:
	return next_state
