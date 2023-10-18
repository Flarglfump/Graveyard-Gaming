extends CharacterBody2D

@export var MAX_HP: int = 75
@export var SPEED: int = 15
var motion = Vector2()

var _health_bar
var _cur_HP: int
var _sprite

func _ready():
	_cur_HP = MAX_HP
	motion = Vector2.LEFT
	_health_bar = $Control/HealthBar
	_health_bar.max_value = MAX_HP
	_health_bar.value = MAX_HP
	_sprite = $Sprite2D

func take_damage(damage):
	print("Taking damage: ", damage)
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

	motion = motion.normalized() * SPEED
	
	set_velocity(motion)
	move_and_slide()
