extends StaticBody2D

export (int) var target_door = 0

var _pressed = false

func trigger_button():
	_pressed = true
	$AnimationPlayer.play("press")
	SignalManager.emit_signal("button_pressed", target_door)

func _on_TriggerArea_body_entered(body):
	var player := body as Player
	if player != null:
		if _pressed == false:
			trigger_button()

func _on_TriggerArea_body_exited(body):
	pass
