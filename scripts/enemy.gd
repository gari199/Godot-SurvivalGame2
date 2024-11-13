extends CharacterBody2D

const SPEED = 300
#Numeros de hits antes de que se muera
var health = 5

#Inicializamos los nodos con este tipo de variable. Si no, el código se iniciará antes y tendremos error.
@onready var player = get_node("/root/Game/Player")
@onready var slime: Node2D = $Slime

func _ready():
	slime.play_walk()
	
#El enmigo necesita ir a por el jugador
func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * SPEED
	move_and_slide()

func take_damage():
	health -= 1
	slime.play_hurt()
	
	if health == 0:
		queue_free()
		player.add_monster_score()
		
	const SMOKE_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn")
	var smoke_explosion = SMOKE_SCENE.instantiate()
	#La anhadimos como hermana de "Enemy", ya que como hija desapareceria al desaparecer el enemy.
	get_parent().add_child(smoke_explosion)
	#La posicionamos en la posición del enemy
	smoke_explosion.global_position = global_position
	
	
	
