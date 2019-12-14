class_name Pig
extends Enemy

var attack_damage = 1

func _init():
	health = 10

func _ready():
	flip_dir_inverted = false
	sprite_flip_right_offset = 6
	controller = DumbPigController.new()
	
func _process(delta):
	._process(delta)
	
# Override
func move(dir):
	.move(dir)
	
# Override
func jump():
	pass

# Override
func end_jump():
	pass
	
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
