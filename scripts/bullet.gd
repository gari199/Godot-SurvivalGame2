extends Area2D

const BULLET_SPEED = 1200
const BULLET_RANGE = 1300
var travel_distance = 0

#La funcion move_and_slide de characters aplica directamente "delta".
#Con Area2D, tenemos que aplicarla nosotros.
func _physics_process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation) #Rotation e spropiedad del area2D (bullet)
	position += direction * BULLET_SPEED * delta
	
	#Increase distance with time until it stops
	if travel_distance < BULLET_RANGE:
		travel_distance += BULLET_SPEED * delta
	else:
		queue_free()

#Hacer que la bala pegue a los enemigos
func _on_body_entered(body: Node2D) -> void:
	queue_free()  #Espera 1 frame para borrar
	if body.has_method("take_damage"):
		body.take_damage()
	
