extends Node

class_name CharacterStateMachine

# These export vars are assigned via the inspector tab 
@export var character : CharacterBody2D # --> Player 
@export var current_state : State # --> Ground 
@export var animation_tree : AnimationTree # --> AnimationTree

var states : Array[State]

# Called when game is booted up 
func _ready():
	for child in get_children():
		if child is State:
			states.append(child)
			
			# Provide each state with a reference to the player's CharacterBody2D node 
			child.character = character
			# Playback allows us to control logic for animation transitions 
			child.playback = animation_tree["parameters/playback"]
			
		else:
			push_warning("Child " + child.name + " is not a State for CharacterStateMachine")
			
func _physics_process(delta: float) -> void:
	# If there is a new state to enter, update current state 
	if current_state.next_state != null:
		switch_states(current_state.next_state)
	
	# Perform state specific processing 
	current_state.state_process(delta)
	
# Checks for player input and passes input events to the current state's handler 
func _input(event : InputEvent):
	current_state.state_input(event)
		
	
			
func check_if_can_move():
	return current_state.can_move
	
func switch_states(new_state : State) -> void:
	# Exit current state 
	if current_state != null:
		current_state.on_exit()
		current_state.next_state = null
	
	# Update current state 
	current_state = new_state
	
	# Enter updated current state 
	current_state.on_enter()
	
