extends "res://Enemies/Enemy.gd"

var _animation_player
func _ready():
	super()
	MAX_HP = 100
	SPEED = 10
	_animation_player = $AnimationPlayer
	_sprite.modulate = Color(1,1,1)

func take_damage(damage):
	print("Taking damage: ", damage)
	_animation_player.play("TakeDamage")
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
