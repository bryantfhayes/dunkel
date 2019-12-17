extends Node2D
tool

export(bool) var update_overlay = false setget update_overlay
export(int, 0, 4) var grid_size = 2

const SCREEN_SIZE = Vector2(960, 640)

func update_overlay(value):
	update()
	
func _draw():
	if grid_size == 0:
		return
	for i in 30:
		draw_line(Vector2(i * SCREEN_SIZE.x, 0), Vector2(i * SCREEN_SIZE.x, 32 * SCREEN_SIZE.x), Color("020202"), grid_size)
		draw_line(Vector2(0, i * SCREEN_SIZE.y), Vector2(32 * SCREEN_SIZE.y, i * SCREEN_SIZE.y), Color("020202"), grid_size)
		
func _ready():
	if !Engine.editor_hint:
		queue_free()