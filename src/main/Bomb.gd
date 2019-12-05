extends KinematicBody2D

const GRAVITY = 2000

var damage = 10
var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Fuse")

func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()

func _physics_process(delta):
	# Accelerate player downward from gravity (fall faster when going down; like in mario)
	if velocity.y > 0:
		velocity.y += GRAVITY * delta
	else:
		velocity.y += GRAVITY * delta
	
	velocity = move_and_slide(velocity, Vector2(0, -1))

func _on_Area2D_body_entered(body):
	var enemy := body as Enemy
	if enemy != null:
		enemy.take_damage(damage)
	pass # Replace with function body.
