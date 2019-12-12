extends Node

# CONSUMABLES
var _diamonds_collected = {}

# EVENTS
var _intro_message_complete = false
var _first_diamond_complete = false
var _first_king_interaction = false

# SPEAKERS
var _speaker_king_brax = "King Brax"
var _speaker_king_piggy = "King Piggy"

# DIALOGS
var _dialog_intro_message_0 = "The pig king has stolen my queen! I have come to this castle to break her free."
var _dialog_intro_message_1 = "First, I need to figure out my way around this place..."
var _dialog_first_diamond_0 = "You steal my wife, I steal your diamonds!"
var _dialog_first_king_interaction_0 = "Muhaha I see you are foolish enough to break into my castle!?"
var _dialog_first_king_interaction_1 = "I see YOU were foolish enough to kidnap my queen!"
var _dialog_first_king_interaction_2 = "Prepare to die!"
var _dialog_first_king_interaction_3 = "Yes, you should..."

func EVENT_intro_message():
	if !_intro_message_complete:
		GameManager.show_message([{"message" : _dialog_intro_message_0, "speaker" : _speaker_king_brax},
											  {"message" : _dialog_intro_message_1, "speaker" : _speaker_king_brax}])
		_intro_message_complete = true

func EVENT_first_diamond():
	if !_first_diamond_complete:
		GameManager.show_message([{"message" : _dialog_first_diamond_0, "speaker" : _speaker_king_brax}])
		_first_diamond_complete = true
		
func EVENT_first_king_interaction():
	if !_first_king_interaction:
		GameManager.show_message([{"message" : _dialog_first_king_interaction_0, "speaker" : _speaker_king_piggy},
		                          {"message" : _dialog_first_king_interaction_1, "speaker" : _speaker_king_brax},
								  {"message" : _dialog_first_king_interaction_2, "speaker" : _speaker_king_brax},
								  {"message" : _dialog_first_king_interaction_3, "speaker" : _speaker_king_piggy}])
		_first_king_interaction = true

	
func collect_diamond(id):
	_diamonds_collected[id] = true
	
func is_diamond_already_collected(id):
	if id in _diamonds_collected:
		return true
	return false
	
func reset():
	_diamonds_collected = {}
	_intro_message_complete = true
	_first_diamond_complete = true
