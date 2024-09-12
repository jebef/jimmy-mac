extends Node

class_name State 

@export var can_move : bool = true 

var character : CharacterBody2D
var next_state : State
var playback : AnimationNodeStateMachinePlayback

func state_process(delta : float) -> void:
	pass

# Handles player input in a given state 
func state_input(event : InputEvent) -> void:
	pass 
	
# How we enter a state 
func on_enter():
	pass
	
# How we exit a state 
func on_exit():
	pass
	
