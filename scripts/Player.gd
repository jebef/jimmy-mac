extends CharacterBody2D

@onready var sprite : Sprite2D = $Sprite2D
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine : CharacterStateMachine = $CharacterStateMachine

# Global vars 
var direction : Vector2 = Vector2.ZERO
const SPEED = 75.0
const JUMP_VELOCITY = -300.0

func _ready():
	animation_tree.active = true
	
# A function to update advanced conditions for our animation tree 
func update_animation_parameters():
	animation_tree["parameters/Move/blend_position"] = direction.x

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta 

	# Get input direction 
	direction = Input.get_vector("left", "right", "up", "down")
	
	# Handle movement updates 
	if direction.x != 0.0 and state_machine.check_if_can_move():
		velocity.x = direction.x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	move_and_slide()
	update_animation_parameters()
	update_sprite_direction()
	
# Simple function to flip facing direction of sprite based on player movement 
func update_sprite_direction():
	if direction.x < 0.0:
		sprite.flip_h = false
	elif direction.x > 0.0:
		sprite.flip_h = true 
	
