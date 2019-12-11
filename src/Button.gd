extends StaticBody2D

export (int) var target_door = 0

var _pressed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func trigger_button():
	_pressed = true
	$AnimationPlayer.play("press")
	var door := get_parent().get_parent().find_door_for_id(target_door) as Door
	if door != null:
		door.open_door()
		door.locked = false

func _on_TriggerArea_body_entered(body):
	var player := body as Player
	if player != null:
		trigger_button()

func _on_TriggerArea_body_exited(body):
	pass # Replace with function body.
