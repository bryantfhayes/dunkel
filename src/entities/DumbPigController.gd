#
# EntityController concrete class responsible for controlling a dumb goblin
#
class_name DumbPigController
extends EntityController

var movement_timeout = 2
var time_since_last_mode = 0
var direction = Dir.None

func _init():
	pass

func random_direction():
	var direction = 0
	var choice = randi() % 3
	
	if choice == 0:
		direction = Dir.Left
	elif choice == 1:
		direction = Dir.Right
	else:
		direction = Dir.None
		
	return direction

func process(entity, delta) -> void:
	time_since_last_mode += delta
	if time_since_last_mode > movement_timeout:
		entity.move(random_direction())
		time_since_last_mode = 0