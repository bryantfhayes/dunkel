class_name Pig
extends Enemy


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
	$AnimationPlayer.play("death")
	yield(get_node("AnimationPlayer"), "animation_finished")
	self.queue_free()
	
func take_damage(amount):
	health -= amount
	print("Pig health remaining: %d" % health)
	$AnimationPlayer.play("hit")
	yield(get_node("AnimationPlayer"), "animation_finished")
	
	if health <= 0:
		die()