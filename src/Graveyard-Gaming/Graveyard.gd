extends Node2D

var current_wave = 0
var enemies_in_wave = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func start_next_wave():
	var wave_data = retrieve_wave_data()
	await get_tree().create_timer(0.2).timeout
	spawn_enemies(wave_data)

func retrieve_wave_data():
	var wave_data = [["Zombie", 0.7], ["Zombie", 0.1]]
	current_wave += 1
	enemies_in_wave = wave_data.size()
	return wave_data

func spawn_enemies(wave_data):
	for i in wave_data:
		var new_enemy = load()
