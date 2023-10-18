extends "res://Enemies/Enemy.gd"

var _animation_player
func _ready():
	super()
	MAX_HP = 100
	SPEED = 10
	_animation_player = $AnimationPlayer
	_sprite.modulate = Color.WHITE

func take_damage(damage):
	print("Taking damage: ", damage)
	_sprite.modulate = Color.RED
	await get_tree().create_timer(.1).timeout
	_sprite.modulate = Color.WHITE
	_cur_HP -= damage
	_health_bar.value = _cur_HP
	
	print(_health_bar.value)
	if _cur_HP <= 0:
		die()

func die():
	queue_free()

func set_direction(direction):
	motion = direction

func _physics_process(_delta):
	# Handle player input
	if (motion.x < 0):
		_animation_player.play("WalkLeft")
	elif(motion.x > 0):
		_animation_player.play("WalkRight")
	else:
		_animation_player.stop()

	motion = motion.normalized() * SPEED
	set_velocity(motion)
	move_and_slide()

func set_pos(pos: Vector2):
	position = pos
