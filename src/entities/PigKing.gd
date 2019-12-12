class_name PigKing
extends Entity

func _init():
	health = 10
	controller = NPCController.new()

func _ready():
	pass
	
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