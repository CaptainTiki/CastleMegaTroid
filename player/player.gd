extends CharacterBody3D
class_name Player

#region /// State Machine Variables ///
var states : Array[ PlayerState ]
var current_state : PlayerState :
	get : return states.front()
var previous_state : PlayerState :
	get : return states[ 1 ]
#endregion

#region /// Standard Variables ///
var direction : Vector2 = Vector2.ZERO
var gravity : float = -16.5
#endregion

func _ready() -> void:
	initialize_states()

func _unhandled_input( event: InputEvent ) -> void:
	change_state( current_state.handle_input( event ) )

func _process(delta: float) -> void:
	update_direction()
	change_state( current_state.process(delta) )

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	change_state( current_state.physics_process(delta) )
	move_and_slide()


func initialize_states() -> void:
	states = []
	for c in $States.get_children():
		if c is PlayerState:
			states.append( c )
			c.player = self
	
	if states.size() == 0:
		return
	
	for state in states:
		state.init()
		
	change_state(current_state)
	current_state.enter()


func change_state( new_state : PlayerState ) -> void:
	if new_state == null:
		return
	elif new_state == current_state:
		return
	
	if current_state:
		current_state.exit()
	
	states.push_front(new_state)
	current_state.enter()
	states.resize( 3 ) #this keeps the states array - only 3 elements. 

func update_direction() -> void:
	#var prev_direction : Vector2 = direction
	direction = Input.get_vector("left", "right", "up", "down")
