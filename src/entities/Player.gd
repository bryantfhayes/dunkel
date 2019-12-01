class_name Player
extends Entity

func _ready():
	flip_dir_inverted = true
	sprite_flip_left_offset = -15
	controller = PlayerController.new()
	
func _process(delta):
	._process(delta)

# Override
func take_damage(dmg):
	.take_damage(dmg)
	print("Ouch!")
	
# Override
func move(dir):
	.move(dir)
	
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