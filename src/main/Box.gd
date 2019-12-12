class_name Box
extends KinematicBody2D

const GRAVITY = 2000

var velocity = Vector2()

func _physics_process(delta):
	# Accelerate player downward from gravity (fall faster when going down; like in mario)
	if velocity.y > 0:
		velocity.y += GRAVITY * delta
	else:
		velocity.y += GRAVITY * delta
	
	velocity.x = 0
	velocity = move_and_slide(velocity, Vector2(0, -1))
	
func explode():
	# TODO: Make box blow up! Animation!
	queue_free()
