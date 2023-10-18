extends Node2D

var current_wave = 0
var enemies_in_wave = 0
var top_offset = 70
var num_lanes = 5
var lane_height = 100
var right_border = 960

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func start_next_wave():
	var wave_data = retrieve_wave_data()
	await get_tree().create_timer(0.2).timeout
	print("Starting wave " + str(current_wave))
	spawn_enemies(wave_data)

func retrieve_wave_data():
	var wave_data = [["Zombie", 1], ["Zombie", 1]]
	current_wave += 1
	enemies_in_wave = wave_data.size()
	return wave_data

func spawn_enemies(wave_data):
	for i in wave_data:
		print("Spawning " + str(i[0]))
		var new_enemy = load("res://Enemies/" + str(i[0]) + ".tscn").instantiate()
		var new_pos = Vector2(right_border, 100 * (randi()%5) + top_offset)
		print("setting position to " + str(new_pos.x) + ", " + str(new_pos.y))
		new_enemy.set_pos(new_pos)
		add_child(new_enemy, false)
	
		await get_tree().create_timer(i[1]).timeout

func hello_world():
	print("Hello world")

func _on_start_button_pressed():
	print("Start button pressed")
	start_next_wave()
