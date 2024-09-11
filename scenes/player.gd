extends CharacterBody2D

@onready var animation_tree : AnimationTree = $AnimationTree

# Global vars 
var direction : float = 0.0
const SPEED = 100.0
const JUMP_VELOCITY = -200.0

func _ready():
	animation_tree.active = true
	
# A function to update advanced conditions for our animation tree 
func update_animation_parameters():
	# IDLE
	if is_on_floor() and velocity == Vector2.ZERO:
		animation_tree["parameters/conditions/is_idle"] = true
		animation_tree["parameters/conditions/is_running"] = false
	# RUN 
	else:
		animation_tree["parameters/conditions/is_idle"] = false
		animation_tree["parameters/conditions/is_running"] = true
		
	# JUMP
	if Input.is_action_just_pressed("jump") and is_on_floor():
		animation_tree["parameters/conditions/is_running"] = false
		animation_tree["parameters/conditions/is_jumping"] = true
	else:
		animation_tree["parameters/conditions/is_jumping"] = false
	# LAND
	if animation_tree["parameters/conditions/is_falling"] and is_on_floor():
		animation_tree["parameters/conditions/is_running"] = false
		animation_tree["parameters/conditions/is_landing"] = true 
	else:
		animation_tree["parameters/conditions/is_landing"] = false
	# FALL
	if not is_on_floor() and velocity.y >= 0.0:
		animation_tree["parameters/conditions/is_running"] = false
		animation_tree["parameters/conditions/is_falling"] = true 
	else:
		animation_tree["parameters/conditions/is_falling"] = false
 
	
	
		
		
	
	
	# Update blend params if necessary 
	if direction:
		animation_tree["parameters/Idle/blend_position"] = direction
		animation_tree["parameters/Run/blend_position"] = direction
		#animation_tree["parameters/Attack/blend_position"] = direction
		animation_tree["parameters/Jump/blend_position"] = direction
		animation_tree["parameters/JumpLoop/blend_position"] = direction
		animation_tree["parameters/Fall/blend_position"] = direction
		animation_tree["parameters/FallLoop/blend_position"] = direction
		animation_tree["parameters/Land/blend_position"] = direction

		
	
	
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta * 0.25

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
