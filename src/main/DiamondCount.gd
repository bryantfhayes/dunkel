extends Node2D

var total_diamonds = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	$Diamond/AnimationPlayer.play("diamond")
	PlayerManager.connect("update_hud", self, "update")
	update()
	
func update():
	$Label.text = "%03d/%03d" % [PlayerManager.get_diamond_count(), total_diamonds]

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
