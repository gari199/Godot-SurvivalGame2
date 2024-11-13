extends Area2D

func _physics_process(delta: float) -> void:
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		var target_enemy = enemies_in_range[0] #enemies_in_range.front() es válido
		look_at(target_enemy.global_position)
		
func shoot():
	##IMPORTANTE: ESTE CODIGO ES LO MISMO QUE ARRASTRAR LA BALA SCENE COMO HIJA DEL SHOOTING POINT
	#Cargamos la bala
	const BULLET = preload("res://scenes/bullet.tscn")  #Preload se ejecuta antes de que el juego empiece y load() solo on-demand
	#La instanciamos
	var new_bullet = BULLET.instantiate()   
	#La posicionamos (posición relativa y rotación)    
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = %ShootingPoint.global_rotation
	#La anhade como hija
	%ShootingPoint.add_child(new_bullet)


func _on_timer_timeout() -> void:
	shoot()
