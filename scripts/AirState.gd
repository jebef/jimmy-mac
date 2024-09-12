extends State

class_name AirState

@export var land_state : State # --> Land
@export var fall_animation_name : StringName = "" # --> "fall"
@export var land_animation_name : StringName = "" # --> "land"
const DOUBLE_JUMP_VELOCITY : float = -100.0
var has_double_jumped : bool = false

func state_process(delta : float) -> void:
	# Check if player is falling and trigger fall animation 
	if character.velocity.y >= 0.0 and not character.is_on_floor():
		playback.travel(fall_animation_name)
	# Check if player has landed, play land animation and update state
	elif character.is_on_floor():
		next_state = land_state
		
		
func state_input(event : InputEvent) -> void:
	pass
	#if event.is_action_pressed("jump") and not has_double_jumped:
		#double_jump();
		
func double_jump() -> void:
	pass
	#character.velocity.y = DOUBLE_JUMP_VELOCITY
	#has_double_jumped = true 
	
func on_exit() -> void:
	if next_state == land_state:
		has_double_jumped = false
