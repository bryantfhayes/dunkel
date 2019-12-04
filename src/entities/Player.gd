class_name Player
extends Entity

var current_attack = 0
var current_attack_damage = 5

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

func _on_Area2D_area_entered(area):
	print("Collided with area:")
	print(area)
	pass # Replace with function body.


func _on_Area2D_body_entered(body):
	print("Collided with body:")
	print(body)
	var player := body as Entity
	if player != null:
		player.take_damage(current_attack_damage)
	pass # Replace with function body.
