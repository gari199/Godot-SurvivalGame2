extends Node2D

#Los mobs pasamos a generarlos solo aqui
func _ready():
	#Espamea 5 mobs
	for i in range(5):
		spawn_mob()

func spawn_mob():
	#Nos saltamos un paso
	var new_slime = preload("res://scenes/enemy.tscn").instantiate()
	%PathFollow2D.progress_ratio = randfn(0.0, 1.0)
	new_slime.global_position = %PathFollow2D.global_position
	add_child(new_slime)

#Timer de 0.3 que cuando llega a 0, spawnea mob
func _on_timer_timeout() -> void:
	spawn_mob()

#La senhal custom que habiamos creade en player y emitimos cuando morimos
func _on_player_health_depleted() -> void:
	%GameOverScreen.visible = true
	#Pausamos!
	get_tree().paused = true

func _on_player_you_won() -> void:
	%WinScreen.visible = true
	get_tree().paused = true
