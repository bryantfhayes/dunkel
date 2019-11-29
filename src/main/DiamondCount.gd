extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$Diamond/AnimationPlayer.play("diamond")
	PlayerManager.connect("update_hud", self, "update")
	update()
	
func update():
	$Label.text = "%04d" % PlayerManager.get_diamond_count()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
