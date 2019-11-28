 extends Area2D

onready var tween = get_node("Tween")
onready var sprite = get_node("sprite3")


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Ready tween!")
	print(sprite.position)
	print(sprite.position.x)
	tween.interpolate_property(sprite, 'position:x',
		sprite.position.x, sprite.position.x + 100, 0.6,
		Tween.TRANS_LINEAR, Tween.EASE_IN)
		
	tween.interpolate_property(sprite, 'position:y',
		sprite.position.y, sprite.position.y +  -100, 0.3,
		Tween.TRANS_QUAD, Tween.EASE_OUT)

	tween.interpolate_property(sprite, 'position:y',
		sprite.position.y + -100, sprite.position.y, 0.3,
		Tween.TRANS_QUAD, Tween.EASE_IN, 0.3)

	tween.interpolate_property(sprite, "rotation_degrees", 
    	0, 1080, 0.6, 
    	Tween.TRANS_LINEAR, Tween.EASE_IN)

	#pass # Replace with function body.

func do_the_thing():
	print("do the thing?")
	print(tween)
	print(sprite)
	tween.start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
