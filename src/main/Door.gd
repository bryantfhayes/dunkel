class_name Door
extends Sprite

# Used to connect doors together
export (int) var id = 0

var _player_active = false

func _ready():
	pass
	
func _process(delta):
	if _player_active:
		if Input.is_action_just_pressed("ui_up"):
			open_door(true)
			GameManager.use_door(id)

func open_door(wait=false):
	$AnimationPlayer.play("open")
	if wait:
		yield(get_node("AnimationPlayer"), "animation_finished")
	
func close_door():
	$AnimationPlayer.play("close")

#
# Handler for when Player is touching the door
#
func _on_Area2D_body_entered(body):
	var player := body as Player
	if player != null:
		_player_active = true
		
func _on_Area2D_body_exited(body):
	var player := body as Player
	if player != null:
		_player_active = false