extends Area2D

const BULLET_SPEED = 1200
const BULLET_RANGE = 1300
var travel_distance = 0

#La funcion move_and_slide de characters aplica directamente "delta".
#Con Area2D, tenemos que aplicarla nosotros.
func _physics_process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation) #Rotation es propiedad del area2D (bullet)
	position += direction * BULLET_SPEED * delta
	
	#Incrementa la posicion con la velocidad hasta que se sale de rango y desaparece
	if travel_distance < BULLET_RANGE:
		travel_distance += BULLET_SPEED * delta
	else:
		queue_free()

#Hacer que la bala pegue a los enemigos
func _on_body_entered(body: Node2D) -> void:
	#PRIMERA COSA MIA!!! IMPACTO!!!
	const IMPACT = preload("res://pistol/impact/impact.tscn")
	var impact = IMPACT.instantiate()
	impact.global_position = global_position
	get_parent().add_child(impact)
	
	queue_free()  #Espera 1 frame para borrar
	if body.has_method("take_damage"):
		body.take_damage()
	
