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
	
	if event.is_action_pressed("attack"):
		# Attack!
		print("Attacking!")
		attack()

func attack():
	var attack_node = get_node("Area2D")
	var sprite_node = attack_node.get_child(0)
	sprite_node.visible = true
	print(attack_node)
	var animation1 = attack_node.get_child(0).get_child(0)
	print(animation1)
	animation1.play("stab")
	var animation2 = attack_node.get_child(1).get_child(0)
	print(animation2)
	animation2.play("stab")

func attack_done():
	var attack_node = get_node("Area2D")
	var sprite_node = attack_node.get_child(0)
	sprite_node.visible = false
	# Attack over
	print("Attack done!")

func _physics_process(delta):
	# Handle user input
	if input_direction:
		direction = input_direction
   
	if Input.is_action_pressed("move_left"):
		input_direction = -1
	elif Input.is_action_pressed("move_right"):
		input_direction = 1
	else:
		input_direction = 0
   
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

func _on_AnimationPlayer2_animation_finished(anim_name):
	var attack_node = get_node("Area2D")
	var sprite_node = attack_node.get_child(0)
	sprite_node.visible = false
	# Attack over
	print("Attack done!")
