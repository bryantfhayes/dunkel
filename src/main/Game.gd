extends Node2D

var _current_level_id = 0
var _last_used_door = 0

func _ready():
	load_level(_current_level_id, _last_used_door)

func spawn_player_at_door(door_id):
	print("spawning at door %d..." % door_id)
	var level = get_node("Level%d" % _current_level_id)
	for child in level.get_children():
		var door := child as Door
		if door != null:
			if door.id == door_id:
				print("found the door!")
				var player := level.get_node("Player") as Player
				if player != null:
					player.position = door.position
					door.open_door(true)
					yield(door.get_node("AnimationPlayer"), "animation_finished")
					player.get_node("AnimationPlayer").play("door_out")
					player.visible = true
					yield(player.get_node("AnimationPlayer"), "animation_finished")
					door.close_door()
					GameManager.unpause_game()
					
					Events.EVENT_intro_message()

func remove_collectibles(level):
	var diamonds = level.get_node("Diamonds")
	if diamonds:
		for diamond in diamonds.get_children():
			if Events.is_diamond_already_collected(diamond.id):
				diamond.queue_free()

func load_level(level_id, door_id):
	_current_level_id = level_id
	
	# Remove the current level (if there is one)
	var level = find_node("Level*", true, false)
	if level != null:
		remove_child(level)
		level.call_deferred("free")

	# Add the next level
	var next_level_resource = load("res://src/main/levels/Level%d.tscn" % level_id)
	var next_level = next_level_resource.instance()

	remove_collectibles(next_level)

	next_level.get_node("Player").visible = false
	add_child(next_level)
	GameManager.pause_game()
	spawn_player_at_door(door_id)