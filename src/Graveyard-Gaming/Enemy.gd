extends KinematicBody2D

export var MAX_HP: int = 100
export var SPEED: int = 15
var motion = Vector2()

var cur_HP: int

func _ready():
	cur_HP = MAX_HP
	motion = Vector2.LEFT

func take_damage(damage):
	print("Taking damage: ", damage)
	cur_HP -= damage
	if cur_HP <= 0:
		die()

func die():
	queue_free()

func set_direction(direction):
	motion = direction

func _physics_process(_delta):
	# Handle player input

	motion = motion.normalized() * SPEED
	
	# Move the player character
	move_and_slide(motion)
