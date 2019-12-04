extends Node2D

var damage = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Fuse")
	pass # Replace with function body.


func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
	pass # Replace with function body.


func _on_Area2D_body_entered(body):
	print("Collided with body:")
	print(body)
	var enemy := body as Enemy
	if enemy != null:
		enemy.take_damage(damage)
	pass # Replace with function body.
