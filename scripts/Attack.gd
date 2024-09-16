extends State

@export var melee_animation_name : StringName = ""
@export var ground_state : State = null

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == melee_animation_name:
		next_state = ground_state
