class_name JumpPig
extends Enemy

var attack_damage = 1

func _init():
	health = 10

func _ready():
	flip_dir_inverted = false
	sprite_flip_right_offset = 6
	controller = JumpPigController.new()
	
func _process(delta):
	._process(delta)
	
# Override
func move(dir):
	.move(dir)
	
# Override
func jump():
	if is_on_floor() and !dead:
		$JumpSoundFx.play()
		velocity.y = -JUMP_FORCE
		
	if is_on_wall() and is_on_floor() == false and can_wall_jump and !dead:
		velocity.y = -JUMP_FORCE
		can_wall_jump = false

# Override
func end_jump():
	if velocity.y < MIN_JUMP_HEIGHT:
		velocity.y = MIN_JUMP_HEIGHT
	
# Override
func attack():
	pass
	
func die():
	dead = true
	$AnimationPlayer.play("death")
	yield(get_node("AnimationPlayer"), "animation_finished")
	self.queue_free()
	
func take_damage(amount):
	if dead == false:
		health -= amount
		print("Pig health remaining: %d" % health)
		$AnimationPlayer.play("hit")
		yield(get_node("AnimationPlayer"), "animation_finished")
		
		if health <= 0:
			die()

func _on_Area2D_body_entered(body):
	var player := body as Player
	if player != null and dead == false:
		player.take_damage(attack_damage)