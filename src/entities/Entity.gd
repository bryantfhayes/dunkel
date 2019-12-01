class_name Entity
extends KinematicBody2D

var paused = false

# Lateral movement adjustments
export var MAX_SPEED = 500
export var ACCELERATION = 30
export var DECELERATION = 70

# Jump adjustments
export var JUMP_FORCE = 800
export var GRAVITY = 2000
export (float) var FALL_MULTIPLIER = 2
export var MIN_JUMP_HEIGHT = -300

var controller: EntityController

# Fix these in child class to make sprite make sense
var flip_dir_inverted = false
var sprite_flip_left_offset = 0
var sprite_flip_right_offset = 0

var movement_direction = Dir.None
var current_direction = Dir.None
var speed_x = 0
var velocity = Vector2()
var can_wall_jump = true

func _ready():
	set_process(true)
	set_process_input(true)

# Virtual
func move(dir):
	if dir == Dir.Left:
		$Sprite.set_flip_h(flip_dir_inverted)
		$Sprite.offset.x = sprite_flip_left_offset
	elif dir == Dir.Right:
		$Sprite.set_flip_h(!flip_dir_inverted)
		$Sprite.offset.x = sprite_flip_right_offset
	movement_direction = dir

func take_damage(dmg):
	pass

# Virtual
func jump():
	pass
	
# Virtual
func end_jump():
	pass
	
# Virtual
func attack():
	pass

#
# Handles input when there is some
#
func _process(delta):
	if !paused:
		controller.process(self, delta)
	else:
		movement_direction = Dir.None

#
# Handles physics process each frame
#
func _physics_process(delta):
	var anim = get_node("AnimationPlayer")
	
	if movement_direction != Dir.None:
		current_direction = movement_direction
		
	if is_on_floor():
		can_wall_jump = true
	
	# Make sure animation matches movement
	if anim.current_animation != "melee" and anim.current_animation != "door_in" and anim.current_animation != "door_out":
		if is_on_floor() == false:
			if velocity.y < 0:
				anim.play("jumping")
			else:
				anim.play("falling")
		elif movement_direction != Dir.None:
			anim.play("running")
		else:
			anim.play("idle")
   
	# Check for change in direction
	if movement_direction == Dir.Left and velocity.x > 0:
		speed_x /= 3
	elif movement_direction == Dir.Right and velocity.x < 0:
		speed_x /= 3
		
	# Check if we stopped moving
	if movement_direction != Dir.None:
		speed_x += ACCELERATION
	else:
		speed_x -= DECELERATION
		
	# Clamp speed so we don't move too fast!
	speed_x = clamp(speed_x, 0, MAX_SPEED)
	
	# Accelerate player downward from gravity (fall faster when going down; like in mario)
	if velocity.y > 0:
		velocity.y += GRAVITY * FALL_MULTIPLIER * delta
	else:
		velocity.y += GRAVITY * delta
	
	velocity.x = speed_x * current_direction
	velocity = move_and_slide(velocity, Vector2(0, -1))