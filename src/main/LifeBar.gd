extends TextureRect

const MAX_HEARTS = 3

export (int) var _hearts: int = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	$Heart1/AnimationPlayer.play("heart")
	$Heart2/AnimationPlayer.play("heart")
	$Heart3/AnimationPlayer.play("heart")
	update()

func update():
	if _hearts == 0:
		$Heart1.visible = false
		$Heart2.visible = false
		$Heart3.visible = false
	elif _hearts == 1:
		$Heart1.visible = true
		$Heart2.visible = false
		$Heart3.visible = false
	elif _hearts == 2:
		$Heart1.visible = true
		$Heart2.visible = true
		$Heart3.visible = false
	elif _hearts == 3:
		$Heart1.visible = true
		$Heart2.visible = true
		$Heart3.visible = true

func set_hearts(hearts):
	if hearts < 0 or hearts > MAX_HEARTS:
		return -1
	_hearts = hearts
	update()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
