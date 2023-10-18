extends CharacterBody2D

@export var SPEED = 200
@export var SHOVEL_DAMAGE = 50

var motion = Vector2()
var _facing = "right"
var _animation_player
var _sprite
var _shovel
var _shovel_collider
var _attacking

func _ready():
	_animation_player = $AnimationPlayer
	_sprite = $Sprite2D
	_facing = "right"
	_shovel = $ShovelHit
	_shovel_collider = $ShovelHit/ShovelCollider
	_attacking = false

func _physics_process(_delta):
	# Handle player input
	motion = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	).normalized() * SPEED
	
	# Handle animation
	if !Input.is_action_pressed("attack"):
		_shovel_collider.disabled = true
		if (motion.x > 0 && !_attacking):
			_animation_player.play("WalkRight")
			_facing = "right"
		elif(motion.x < 0 && !_attacking):
			_animation_player.play("WalkLeft")
			_facing = "left"
		elif (motion.y == 0):
			_stop_movement()
		
		if (abs(motion.y) > 0):
			_animation_player.play("WalkRight" if (_facing == "right") else "WalkLeft")
		elif(abs(motion.x) == 0):
			_stop_movement()
		
		# Move the player character
		set_velocity(motion)
		move_and_slide()

func _unhandled_input(event):
	if (event.is_action_pressed("attack")):
		_shovel_attack()
		pass
	pass

func _stop_movement():
	_animation_player.stop()
	_sprite.frame = 7 if (_facing == "right") else 5

func _shovel_attack():
	_stop_movement()
	
	if (_facing == "right"):
		#print("Attack Right")
		_animation_player.play("AttackRight")
	else:
		#print("Attack Left")
		_animation_player.play("AttackLeft")


func _on_shovel_hit_body_entered(body):
	print("Body Entered")
	if (body.has_method("take_damage")):
		body.take_damage(SHOVEL_DAMAGE)
