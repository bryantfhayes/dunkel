#
# PlayerManager - This module is auto-loaded and holds all state for player
#                    node. Anything that needs to persist across saves should be
#                    kept here.
#
extends Node

signal update_hud

const DEFAULT_MAX_HEALTH = 100
const DEFAULT_MAX_ATTACK = 1
const DEFAULT_DIAMONDS = 0

var _max_health = DEFAULT_MAX_HEALTH
var _health = DEFAULT_MAX_HEALTH
var _strength = DEFAULT_MAX_ATTACK
var _diamonds: int = DEFAULT_DIAMONDS

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func get_diamond_count():
	return _diamonds

func add_diamonds(diamonds):
	_diamonds += diamonds
	emit_signal("update_hud")
	
func reset():
	_diamonds = 0
	
