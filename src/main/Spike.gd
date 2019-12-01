extends Sprite

var _damage = 99999

func _on_Area2D_body_entered(body):
	var player := body as Player
	if player != null:
		player.take_damage(_damage)
