extends Area2D

onready var tween = get_node("Tween")
onready var sprite = get_node("sprite3")


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Ready tween!")
	tween.interpolate_property(sprite, 'scale',
		sprite.get_scale(), Vector2(2.0, 2.0), 0.3,
		Tween.TRANS_QUAD, Tween.EASE_OUT)
	#pass # Replace with function body.

func do_the_thing():
	print("do the thing?")
	print(tween)
	print(sprite)
	tween.start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
