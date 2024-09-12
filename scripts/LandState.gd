extends State

class_name LandState

@export var ground_state : State = null # --> Ground 
@export var land_animation_name : StringName = "" # --> "land"

func on_enter():
	playback.travel(land_animation_name)
	
func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == land_animation_name:
		next_state = ground_state
