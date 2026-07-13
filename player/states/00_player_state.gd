@icon("uid://dsmiqgkibw5mn")
extends Node
class_name PlayerState


var player : Player
var next_state : PlayerState

#region /// state references ///
@onready var idle: PlayerStateIdle = %Idle
@onready var run: PlayerStateRun = %Run
@onready var jump: PlayerStateJump = %Jump
@onready var fall: PlayerStateFall = %Fall
#endregion

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
