class_name Pig
extends Enemy

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