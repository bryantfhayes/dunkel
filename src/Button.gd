extends StaticBody2D

var _pressed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_TriggerArea_body_entered(body):
	var player := body as Player
	if player != null:
		_pressed = true
		$AnimationPlayer.play("press")


func _on_TriggerArea_body_exited(body):
	pass # Replace with function body.
