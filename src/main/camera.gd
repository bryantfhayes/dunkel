extends Camera2D

var SCREEN_HEIGHT = 640
var SCREEN_WIDTH = 960

func _process(delta):
	var pos = get_node("../player").global_position
	var x = floor(pos.x / SCREEN_WIDTH) * SCREEN_WIDTH
	var y = floor(pos.y / SCREEN_HEIGHT) * SCREEN_HEIGHT
	print(global_position)
	global_position = Vector2(x, y)
	
# TODO: Turn off enemies with Area collides with them, area being the camera...
