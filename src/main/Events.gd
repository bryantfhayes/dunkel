extends Node

# CONSUMABLES
var _diamonds_collected = {}

# EVENTS
var _intro_message_complete = false
var _first_diamond_complete = false

# SPEAKERS
var _speaker_king_brax = "King Brax"

# DIALOGS
var _dialog_intro_message_0 = "The goblin king has stolen my queen! I have come to this castle to break her free."
var _dialog_intro_message_1 = "First, I need to figure out my way around this place..."
var _dialog_first_diamond_0 = "You steal my wife, I steal your diamonds!"

func EVENT_intro_message():
	if !_intro_message_complete:
		GameManager.show_message([{"message" : _dialog_intro_message_0, "speaker" : _speaker_king_brax},
											  {"message" : _dialog_intro_message_1, "speaker" : _speaker_king_brax}])
		_intro_message_complete = true

func EVENT_first_diamond():
	if !_first_diamond_complete:
		GameManager.show_message([{"message" : _dialog_first_diamond_0, "speaker" : _speaker_king_brax}])
		_first_diamond_complete = true
	
func collect_diamond(id):
	_diamonds_collected[id] = true
	
func is_diamond_already_collected(id):
	if id in _diamonds_collected:
		return true
	return false