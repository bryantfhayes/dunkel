extends CanvasLayer

var v_margin = 10
var h_margin = 10
var inner_margin = 30
var anchor_pos = Vector2(0, 0)
var _message_index = 0
var _messages = []
var current_conversation = null
export(float) var character_speed = 0.06
var init_done = false

onready var bg = get_node("background_box")
onready var textlbl = get_node("background_box/text_label")
onready var timer = get_node("background_box/character_timer")
onready var speaker_box = get_node("background_box/speaker_box")
onready var speaker_box_textlbl = get_node("background_box/speaker_box/textlbl")
onready var next_message_textlbl = get_node("background_box/next_message_textlbl")

signal message_is_complete

func _ready():
	pass
	
#
# Helper fn to display who is talking
#
func display_speaker(current_message):
	# Optionally display speaker text box
	if current_message["speaker"] == "":
		speaker_box.visible = false
	else:
		speaker_box.visible = true
		speaker_box_textlbl.set_text(current_message["speaker"])

#
# You MUST call this everytime you make a new message box
#
func init(messages):
	# Make a new message box with a specified conversation
	_messages = messages
	_message_index = 0
	timer.wait_time = character_speed
	timer.start()
	
	new_message()

	# Set position and size of background_box
	var viewport_size = get_viewport().size
	var message_box_size = bg.rect_size
	anchor_pos = Vector2((viewport_size.x - message_box_size.x) / 2, viewport_size.y - message_box_size.y - v_margin)
	bg.rect_position = anchor_pos
	
	# Set size of text_label
	textlbl.rect_position = Vector2(inner_margin, inner_margin)
	textlbl.rect_size = bg.rect_size - Vector2(h_margin, v_margin)
	
	init_done = true

func new_message():
	textlbl.set_text(_messages[_message_index]["message"])
	textlbl.set_visible_characters(0)
	
	display_speaker(_messages[_message_index])
	
	var audio_file = "res://assets/sounds/dialog/%s" % _messages[_message_index]["sound"]
	MusicController.play_track(audio_file)

#
# Called every frame. 'delta' is the elapsed time since the previous frame.
#
func _process(delta):
	poll_inputs()
	update()

#
# Update UI with misc details depending on state (e.g - When current frame is done)
#
func update():
	# Make any additional UI updates based on state
	if textlbl.get_visible_characters() >= textlbl.get_total_character_count():
		next_message_textlbl.visible = true
	else:
		next_message_textlbl.visible = false

#
# Poll for user input to continue message box
#
func poll_inputs():
	if init_done == false:
		return
		
	if Input.is_action_just_pressed("ui_accept"):
		if textlbl.get_visible_characters() == 0:
			# If no characters are availble yet, ignore ENTER. This accounts for
			# the user pressing ENTER to bring up the message box to begin with
			return
		
		print("ENTER")
		
		if textlbl.get_visible_characters() < textlbl.get_total_character_count():
			# If not all the characters are shown, show them all at once.
			textlbl.set_visible_characters(textlbl.get_total_character_count())
		elif _message_index < (len(_messages) - 1):
			_message_index += 1
			new_message()
		else:
			message_complete()

#
# Emit signal when message box is done
#
func message_complete():
	emit_signal("message_is_complete")

#
# Make a new character visible every X seconds
#
func _on_character_timer_timeout():
	if (textlbl.get_visible_characters() < textlbl.get_total_character_count()):
		textlbl.set_visible_characters(textlbl.get_visible_characters() + 1)