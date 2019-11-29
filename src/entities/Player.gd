class_name Player
extends Entity

func _ready():
	controller = PlayerController.new()
	
func _process(delta):
	._process(delta)
	
# Override
func move(dir):
	if dir == Dir.Left:
		$Sprite.set_flip_h(true)
		$Sprite.offset.x = -15
	elif dir == Dir.Right:
		$Sprite.set_flip_h(false)
		$Sprite.offset.x = 0
	movement_direction = dir
	
# Override
func jump():
	if is_on_floor():
		$JumpSoundFx.play()
		velocity.y = -JUMP_FORCE
		
	if is_on_wall() and is_on_floor() == false and can_wall_jump:
		velocity.y = -JUMP_FORCE
		can_wall_jump = false

# Override
func end_jump():
	if velocity.y < MIN_JUMP_HEIGHT:
		velocity.y = MIN_JUMP_HEIGHT
	
# Override
func attack():
	$AttackSoundFx.play()
	$AnimationPlayer.play("melee")