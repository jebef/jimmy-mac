extends CharacterBody2D

@onready var animation_tree : AnimationTree = $AnimationTree

# Global vars 
var direction : float = 0.0
const SPEED = 75.0
const JUMP_VELOCITY = -250.0

func _ready():
	animation_tree.active = true
	
# A function to update advanced conditions for our animation tree 
func update_animation_parameters():
	# Check if the player is moving and update params accordingly 
	if velocity == Vector2.ZERO:
		animation_tree["parameters/conditions/is_idle"] = true
		animation_tree["parameters/conditions/is_moving"] = false
	else:
		animation_tree["parameters/conditions/is_idle"] = false
		animation_tree["parameters/conditions/is_moving"] = true
		
	animation_tree["parameters/conditions/is_attacking"] = false
	if Input.is_action_just_pressed("attack"):
		animation_tree["parameters/conditions/is_attacking"] = true
	
	# Update blend params if necessary 
	if direction:
		animation_tree["parameters/Idle/blend_position"] = direction
		animation_tree["parameters/Run/blend_position"] = direction
		animation_tree["parameters/Attack/blend_position"] = direction
		
	
	
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	update_animation_parameters()
	move_and_slide()
