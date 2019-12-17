extends Node2D

func _ready():
	SignalManager.connect("message_box_complete", self, "trigger_trap")

func _on_KingInteraction_0_body_entered(body):
	var player := body as Player
	if player != null:
		GameManager.pause_game()
		yield(get_tree().create_timer(2.0), "timeout")
		Events.EVENT_first_king_interaction()
		
func _on_KingInteraction_0_body_exited(body):
	pass
	
func trigger_trap():
	get_node("trap_door").queue_free()
