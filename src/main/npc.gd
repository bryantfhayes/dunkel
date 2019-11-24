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

var player_nearby = false

func _ready():
	set_process(true)
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("ui_accept") and player_nearby:
		GameManager.show_message(self.get_parent(), [{"message" : "Hello there", "speaker" : "npc"}])

func _physics_process(delta):
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

func _on_event_area_body_entered(body):
	if body.get_name() == "player":
		player_nearby = true

func _on_event_area_body_exited(body):
	if body.get_name() == "player":
		player_nearby = false
