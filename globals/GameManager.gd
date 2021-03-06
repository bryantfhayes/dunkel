extends Node

var MessageBox = preload("res://ui/MessageBox.tscn")

var door_map = {
	0 : { "level" : 0, "target_door" : 1 },
	1 : { "level" : 0, "target_door" : 2 },
	2 : { "level" : 1, "target_door" : 1 },
	3 : { "level" : 1, "target_door" : 4 },
	4 : { "level" : 2, "target_door" : 3 },
	5 : { "level" : 2, "target_door" : 6 },
	6 : { "level" : 3, "target_door" : 5 },
	7 : { "level" : 3, "target_door" : 100 },
	100 : { "level" : 4, "target_door" : 7},
	101 : { "level" : 4, "target_door" : 102},
	102 : { "level" : 4, "target_door" : 101},
	103 : { "level" : 4, "target_door" : 104}, 
	104 : { "level" : 5, "target_door" : 103},
	105 : { "level" : 5, "target_door" : 108},
	106 : { "level" : 4, "target_door" : 107},
	107 : { "level" : 6, "target_door" : 106},
	108 : { "level" : 6, "target_door" : 105},
	109 : { "level" : 7, "target_door" : 108}
}

func goto_main_menu():
	get_tree().change_scene("res://menus/MainMenu.tscn")

func game_over():
	var game = get_tree().get_root().get_node("Game")
	pause_game()
	game.game_over()
	yield(game.get_node("HUD/AnimationPlayer"), "animation_finished")
	goto_main_menu()

func _ready():
	print("Game Manager Init")

#
# Called whenever a message box is completed
#
func message_complete_callback(level_node, message_box):
	message_box.queue_free()
	unpause_game()
	SignalManager.emit_signal("message_box_complete")

#
# Pause/Un-pause all children for given node (physics process)
#
func pause_all_children_nodes_for_node(node, paused):
	for child in node.get_children():
		if len(child.get_children()) > 0:
			pause_all_children_nodes_for_node(child, paused)
		
		var entity := child as Entity
		if entity != null:
			entity.paused = paused

func pause_game():
	var game = get_tree().get_root().get_node("Game")
	pause_all_children_nodes_for_node(game, true)

func unpause_game():
	var game = get_tree().get_root().get_node("Game")
	pause_all_children_nodes_for_node(game, false)

#
# Show message on a given root node
#
func show_message(messages):
	var game = get_tree().get_root().get_node("Game")
	var msgbox = MessageBox.instance()
	pause_game()
	game.add_child(msgbox)
	msgbox.init(messages)
	msgbox.connect("message_is_complete", self, "message_complete_callback", [game, msgbox])

func use_door(id):
	var door = door_map[id]
	var target_door = door_map[door["target_door"]]
	var target_level = target_door["level"]
	
	pause_game()
	
	# Remove the current level
	var game = get_tree().get_root().get_node("Game")
	var player = game.find_node("Player", true, false)
	player.get_node("AnimationPlayer").play("door_in")
	wait(0.5)
	yield(player.get_node("AnimationPlayer"), "animation_finished")
	player.visible = false
	wait(1.0)
	game.load_level(target_level, door["target_door"])
	
func wait(t: float):
	yield(get_tree().create_timer(t), "timeout")




