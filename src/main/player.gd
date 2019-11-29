extends KinematicBody2D

var input_direction = 0
var direction = 0
var speed_x = 0
var velocity = Vector2()
var can_wall_jump = true
 
# Lateral movement adjustments
export var MAX_SPEED = 500
export var ACCELERATION = 30
export var DECELERATION = 70

# Jump adjustments
export var JUMP_FORCE = 800
export var GRAVITY = 2000
export var FALL_MULTIPLIER = 2
export var MIN_JUMP_HEIGHT = -300

export var torch_enabled = true

func _ready():
	set_process(true)
	set_process_input(true)
	$torch.visible = torch_enabled
	$anim.play("idle")

 
func _input(event):
	if is_on_floor():
		can_wall_jump = true
	
	# Pressed jump button
	if event.is_action_pressed("jump") and is_on_floor():
		velocity.y = -JUMP_FORCE
		
	# Cancel jump by releasing early (only works when you are going up!
	if event.is_action_released("jump") and velocity.y < MIN_JUMP_HEIGHT:
		velocity.y = MIN_JUMP_HEIGHT
		
	if event.is_action_pressed("jump") and is_on_wall() and is_on_floor() == false and can_wall_jump:
		velocity.y = -JUMP_FORCE
		can_wall_jump = false

func _physics_process(delta):
	# Handle user input
	if input_direction:
		direction = input_direction
		
	if Input.is_action_pressed("move_left"):
		get_node("sprite").set_flip_h(true)
		input_direction = -1
	elif Input.is_action_pressed("move_right"):
		get_node("sprite").set_flip_h(false)
		input_direction = 1
	else:
		input_direction = 0
	
	if input_direction == 0:
		$anim.play("idle")
	else:
		$anim.play("running")
   
	# Apply user movement
	if input_direction == - direction:
		speed_x /= 3
	if input_direction:
		speed_x += ACCELERATION
	else:
		speed_x -= DECELERATION
	speed_x = clamp(speed_x, 0, MAX_SPEED)
	
	# Accelerate player downward from gravity (fall faster when going down; like in mario)
	if velocity.y > 0:
		velocity.y += GRAVITY * FALL_MULTIPLIER * delta
	else:
		velocity.y += GRAVITY * delta
	   
	velocity.x = speed_x * direction
	velocity = move_and_slide(velocity, Vector2(0, -1))