extends KinematicBody2D

const SPEED = 200  # Adjust the player's movement speed as needed
var motion = Vector2()
var facing = "right"

onready var _animation_player = $Player/AnimationPlayer

func _physics_process(delta):
	# Handle player input
	motion = Vector2()
	
	if Input.is_action_pressed("move_up"):
		motion.y -= 1
	elif Input.is_action_pressed("move_down"):
		motion.y += 1
	elif Input.is_action_pressed("move_left"):
		motion.x -= 1
		_animation_player.play("WalkLeft")
		facing = "left"
	elif Input.is_action_pressed("move_right"):
		motion.x += 1
		_animation_player.play("WalkRight")
		facing = "right"

	motion = motion.normalized() * SPEED
	
	# Move the player character
	move_and_slide(motion)

