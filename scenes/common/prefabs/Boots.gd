extends Sprite

func _ready():
	$AnimationPlayer.play("idle")

func _on_Area2D_body_entered(body):
	var player := body as Player
	if player != null:
		Events.EVENT_pickup_boots()
		player.pickup_boots()
		queue_free()
