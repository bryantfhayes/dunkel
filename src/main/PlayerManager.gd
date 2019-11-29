#
# PlayerManager - This module is auto-loaded and holds all state for player
#                    node. Anything that needs to persist across saves should be
#                    kept here.
#
extends Node

const DEFAULT_MAX_HEALTH = 100
const DEFAULT_MAX_ATTACK = 1

var _max_health = DEFAULT_MAX_HEALTH
var _health = DEFAULT_MAX_HEALTH
var _strength = DEFAULT_MAX_ATTACK

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

