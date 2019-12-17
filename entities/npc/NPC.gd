extends Entity

var player_nearby = false

func _ready():
	controller = NPCController.new()

func _input(event):
	if event.is_action_pressed("ui_accept") and player_nearby and !paused:
		GameManager.show_message([{"message" : "Hello there", "speaker" : "npc"}])

# Override
func move(dir):
	movement_direction = dir

func _on_Area2D_body_entered(body):
	var player := body as Player
	if player != null:
		player_nearby = true

func _on_Area2D_body_exited(body):
	var player := body as Player
	if player != null:
		player_nearby = false
