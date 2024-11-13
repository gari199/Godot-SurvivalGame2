extends CharacterBody2D

#Senhal custom para game_over
signal health_depleted
#Senhal custom para ganar el juego
signal you_won

#Variables
var health = 100.0
var monster_score = 0

#Constantes
const SPEED = 600.0
const DAMAGE_RATE = 5.0

#onready
@onready var happy_boo: Node2D = $HappyBoo

func _physics_process(delta: float) -> void:
	
	#Manera interesante de hacer moviemiento con Vector2D y simple
	var direction = Input.get_vector("move_left", "move_right","move_up", "move_down")
	velocity = direction * SPEED
	move_and_slide()
	
	#Si se define como absoluto (%) %HappyBoo como absolute path
	if velocity.length() > 0:
		happy_boo.play_walk_animation() 
	else:
		happy_boo.play_idle_animation()
	
	#array de bichos pegados
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		%ProgressBar.value = health
		if health <= 0.0:
			health_depleted.emit()
			
#Funcion extra para contar el numero de monstruos matados			
func add_monster_score():
	if monster_score < 10:
		monster_score += 1
		%MonsterScore.text = "Youve killed " + str(monster_score) + " enemies"
	if monster_score == 5:
		you_won.emit()
		
	
			
	
