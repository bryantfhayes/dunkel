extends Node

var MessageBox = preload("res://src/main/MessageBox.tscn")

func _ready():
	print("Game Manager Init")

#
# Called whenever a message box is completed
#
func message_complete_callback(level_node, message_box):
	message_box.queue_free()
	pause_all_children_nodes_for_node(level_node, false)

#
# Pause/Un-pause all children for given node (physics process)
#
func pause_all_children_nodes_for_node(node, paused):
	for child in node.get_children():
		child.set_physics_process(!paused)
		child.set_process_input(!paused)

#
# Show message on a given root node
#
func show_message(level_node, messages):
	var msgbox = MessageBox.instance()
	pause_all_children_nodes_for_node(level_node, true)
	level_node.add_child(msgbox)
	msgbox.init(messages)
	msgbox.connect("message_is_complete", self, "message_complete_callback", [level_node, msgbox])

	




