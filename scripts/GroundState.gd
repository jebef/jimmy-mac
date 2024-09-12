extends State

class_name GroundState

const JUMP_VELOCITY : float = -100.0
@export var air_state : State 
@export var jump_animation_name : String = ""

func state_input(event : InputEvent):
	if event.is_action_pressed("jump"):
		jump()
		
func state_process(delta : float) -> void:
	if not character.is_on_floor():
		next_state = air_state
		
func jump():
	character.velocity.y = JUMP_VELOCITY
	next_state = air_state
	playback.travel(jump_animation_name)
	
