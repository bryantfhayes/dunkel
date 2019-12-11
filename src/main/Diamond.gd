extends Node2D

var picked_up: bool = false

export (int) var id = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("floating_diamond")

func _process(delta):
	if picked_up:
		if (!get_node("PickupSoundFx").playing):
			queue_free()

func pickup():
	if !picked_up:
		Events.EVENT_first_diamond()
		Events.collect_diamond(id)
		$PickupArea/CollisionShape2D.disabled = true
		$PickupSoundFx.play()
		PlayerManager.add_diamonds(1)
		visible = false
		picked_up = true

func _on_PickupArea_body_entered(body):
	var player := body as Player
	if player != null:
		pickup()
