extends Node2D

enum eSelectedButton { NewGame, Continue, Quit }
enum eButtonMovement { Up, Down }

const POINTER_OFFSET = 10
const BUTTON_PRESS_TIMEOUT = 0.35

var _button_down = false
var _selected_button = eSelectedButton.NewGame
var _active_pointer = "pointer_new_game"
var _pointer_actuated = false

onready var _pointer_starting_pos = get_node("pointer_new_game").rect_position

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _input(event):
	if event.is_action_pressed("ui_down") and _button_down == false:
		_button_down = true
		move_selected(eButtonMovement.Down)
	elif event.is_action_pressed("ui_up") and _button_down == false:
		_button_down = true
		move_selected(eButtonMovement.Up)
	elif event.is_action_released("ui_down") or event.is_action_released("ui_up") or event.is_action_released("ui_accept"):
		_button_down = false
	
	if event.is_action_pressed("ui_accept") and _button_down == false:
		_button_down = true
		select_button()

func new_game():
	get_tree().change_scene("res://src/main/town.tscn")
	
func continue_game():
	print("Continue button pressed!")
	
func quit_game():
	get_tree().quit()

func select_button():
	if _selected_button == eSelectedButton.NewGame:
		var sound_fx: AudioStreamPlayer2D = get_node("select_sound_fx")
		sound_fx.play()
		get_node("new_game_button").set_normal_texture(load("res://assets/ui/pressed_new_game_button.png"))
		yield(get_tree().create_timer(BUTTON_PRESS_TIMEOUT), "timeout")
		get_node("new_game_button").set_normal_texture(load("res://assets/new_game_button.png"))
		new_game()
	elif _selected_button == eSelectedButton.Continue:
		var sound_fx: AudioStreamPlayer2D = get_node("error_sound_fx")
		sound_fx.play()
		get_node("continue_button").set_normal_texture(load("res://assets/ui/pressed_continue_button.png"))
		yield(get_tree().create_timer(BUTTON_PRESS_TIMEOUT), "timeout")
		get_node("continue_button").set_normal_texture(load("res://assets/ui/continue_button.png"))
		continue_game()
	elif _selected_button == eSelectedButton.Quit:
		var sound_fx: AudioStreamPlayer2D = get_node("select_sound_fx")
		sound_fx.play()
		get_node("quit_button").set_normal_texture(load("res://assets/ui/pressed_quit_button.png"))
		yield(get_tree().create_timer(BUTTON_PRESS_TIMEOUT), "timeout")
		get_node("quit_button").set_normal_texture(load("res://assets/ui/quit_button.png"))
		quit_game()

func move_selected(direction):
	var sound_fx: AudioStreamPlayer2D = get_node("swipe_sound_fx")
	sound_fx.play()
	
	if direction == eButtonMovement.Up:
		_selected_button -= 1
	elif direction == eButtonMovement.Down:
		_selected_button += 1
	
	# Constrain to 0, 1, and 2
	_selected_button = clamp(_selected_button, 0, 2)
	
	if _selected_button == eSelectedButton.NewGame:
		_active_pointer = "pointer_new_game"
	elif _selected_button == eSelectedButton.Continue:
		_active_pointer = "pointer_continue"
	elif _selected_button == eSelectedButton.Quit:
		_active_pointer = "pointer_quit"

	# Turn off all pointers
	get_node("pointer_new_game").visible = false
	get_node("pointer_continue").visible = false
	get_node("pointer_quit").visible = false

	# Then turn on the active one
	get_node(_active_pointer).visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_pointer_blink_timer_timeout():
	_pointer_actuated = !_pointer_actuated
	if _pointer_actuated:
		get_node(_active_pointer).rect_position.x = _pointer_starting_pos.x + POINTER_OFFSET
	else:
		get_node(_active_pointer).rect_position.x = _pointer_starting_pos.x
