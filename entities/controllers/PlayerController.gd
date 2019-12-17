#
# EntityController concrete class responsible for controlling player
#
class_name PlayerController
extends EntityController

var time_since_last_attack: float = 0.0
var attack_cooldown: float = 0.7

func process(entity, delta) -> void:
	# Jump Movement
	if Input.is_action_just_pressed("jump"):
		entity.jump()
	if Input.is_action_just_released("jump"):
		entity.end_jump()
	
	time_since_last_attack += delta
	if Input.is_action_just_pressed("attack") and time_since_last_attack >= attack_cooldown:
		time_since_last_attack = 0
		entity.attack()
	
	if Input.is_action_just_pressed("bomb") and time_since_last_attack >= attack_cooldown:
		time_since_last_attack = 0
		entity.drop_bomb()

	
	# Left/Right Movement
	if Input.is_action_pressed("move_left"):
		entity.move(Dir.Left)
	elif Input.is_action_pressed("move_right"):
		entity.move(Dir.Right)
	else:
		entity.move(Dir.None)