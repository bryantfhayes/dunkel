extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.show_message(self, [{"message" : "This is a dialog box!", "speaker" : "System"},
								    {"message" : "It can change what it says!", "speaker" : "System"},
									{"message" : "And change who says it!", "speaker" : "Bryant"}])
