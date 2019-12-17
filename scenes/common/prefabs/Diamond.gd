tool
extends Node2D

var picked_up: bool = false

export (String) var id = -1
export (bool) var single_use = true setget set_single_use, get_single_use

func set_single_use(val):
	single_use = val
	id = uuid.new().generate_uuid()
	
func get_single_use():
	return single_use

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
