class_name Player
extends Entity

var current_attack = 0
var current_attack_damage = 5

func _ready():
	flip_dir_inverted = true
	sprite_flip_left_offset = -15
	controller = PlayerController.new()
	
func _process(delta):
	._process(delta)

# Override
func take_damage(dmg):
	.take_damage(dmg)
	print("Ouch!")
	health -= dmg
	
	if health < 0:
		GameManager.game_over()
	
# Override
func move(dir):
	.move(dir)
	if dir == Dir.Left:
		var attack_node = get_node("MeleeArea")
		if attack_node != null:
			attack_node.set_scale(Vector2(-1,1))
			attack_node.position.x = sprite_flip_left_offset

	elif dir == Dir.Right:
		var attack_node = get_node("MeleeArea")
		if attack_node != null:
			attack_node.set_scale(Vector2(1,1))
			attack_node.position.x = sprite_flip_right_offset


	
# Override
func jump():
	if is_on_floor():
		$JumpSoundFx.play()
		velocity.y = -JUMP_FORCE
		
	if is_on_wall() and is_on_floor() == false and can_wall_jump:
		velocity.y = -JUMP_FORCE
		can_wall_jump = false

# Override
func end_jump():
	if velocity.y < MIN_JUMP_HEIGHT:
		velocity.y = MIN_JUMP_HEIGHT
	
# Override
func attack():
	$AttackSoundFx.play()
	$AnimationPlayer.play("melee")
	
func drop_bomb():
	var scene = load("res://src/main/Bomb.tscn")
	print(scene)
	if scene != null:
		var scene_instance = scene.instance()
		var offset = 7
		if $Sprite.flip_h:
			offset = -20
		scene_instance.set_name("Bomb")
		scene_instance.position = self.position + Vector2(offset, 0)
		get_owner().add_child(scene_instance)
	print("Drop!")

func _on_Area2D_body_entered(body):
	var enemy := body as Enemy
	if enemy != null:
		enemy.take_damage(current_attack_damage)
