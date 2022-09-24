extends KinematicBody2D

const SPEED = GameManager.SPEED
onready var trail = $Trail
onready var camera = $Camera2D
onready var animatedSprite = $AnimatedSprite
var speedModifier
var velocityPlayer
var idle = true
var isDead = false
var respawnPoint
var lastMovement

var deathParticle = load("res://Scenes/Particles/DeathParticle.tscn")
var dashParticle = load("res://Scenes/Particles/DashParticle.tscn")


func _ready():
	respawnPoint = position
	velocityPlayer = Vector2(0,0)
	lastMovement = Vector2(0,0)
	speedModifier = 1
	


func _physics_process(delta):
	velocityPlayer = move_and_slide(velocityPlayer)
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision:
			if collision.collider is TileMap or collision.collider.is_in_group("Wall"):
				death()
			if collision.collider.is_in_group("Bumper"):
				if collision.collider.has_method("move"):
					collision.collider.move(lastMovement)
					bounce()

#Récupère la direction swiper par le joueur
func _on_SwipeDetector_swiped(direction):
	
	#UP
	if direction.x == 0 and direction.y == -1:
		setMovement(Vector2(0, SPEED))
		rotation_degrees = 180
		GameManager.createParticle(dashParticle, position, rotation_degrees)
	
	#DOWN
	if direction.x == 0 and direction.y == 1:
		setMovement(Vector2(0, -SPEED))
		rotation_degrees = 0
		GameManager.createParticle(dashParticle, position, rotation_degrees)
		
	#LEFT
	if direction.x == -1 and direction.y == 0:
		setMovement(Vector2(SPEED, 0))
		rotation_degrees = 90
		GameManager.createParticle(dashParticle, position, rotation_degrees)
		
	#RIGHT
	if direction.x == 1 and direction.y == 0:
		setMovement(Vector2(-SPEED, 0))
		rotation_degrees = 270
		GameManager.createParticle(dashParticle, position, rotation_degrees)
	
#Fonction exécutée quand le joueur perd
func death():
	if !idle :
		print("DEADGE")
		idle = true
		isDead = true
		GameManager.createParticle(deathParticle, position, rotation_degrees)
		camera.apply_noise_shake(30, 60, 5)
		animatedSprite.visible = false
		trail.visible = false
		GameManager.wait(0.3, "reset", self)

	
#Appelle le Reset le niveau
func reset():
	print("RESETGE")
	GameManager.resetLevel()
	#moveToPoint(respawnPoint)
	#speedModifier = 1
	
#Change la direction du joueur
func setMovement(movement):
	if !isDead:
		lastMovement = movement
		velocityPlayer = movement * speedModifier
		idle = false
		animatedSprite.play("Dash")
		camera.apply_noise_shake(5, 5, 1)

		


#Inverse le mouvement du joueur
func bounce():
	setMovement(lastMovement * -1)
	rotation_degrees += 180
	GameManager.createParticle(dashParticle, position, rotation_degrees)
	camera.apply_noise_shake(10, 15, 3)

#Téléporte le joueur à un point donné
func moveToPoint(point):
	position = point

#Modifie la vitesse du joueur
func modifySpeedModifier(value):
	speedModifier = value
	setMovement(lastMovement)

#bloque les mouvements du joueur
func stop():
	setMovement(Vector2.ZERO)
