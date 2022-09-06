extends KinematicBody2D

const SPEED = GameManager.SPEED
var speedModifier
var velocityPlayer
var idle = true
var respawnPoint
var lastMovement



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
	
	#DOWN
	if direction.x == 0 and direction.y == 1:
		setMovement(Vector2(0, -SPEED))
		
	#LEFT
	if direction.x == -1 and direction.y == 0:
		setMovement(Vector2(SPEED, 0))
		
	#RIGHT
	if direction.x == 1 and direction.y == 0:
		setMovement(Vector2(-SPEED, 0))
	
#Fonction exécutée quand le joueur perd
func death():
	print("DEADGE")
	idle = true
	reset()
	
#Appelle le Reset le niveau
func reset():
	print("RESETGE")
	GameManager.resetLevel()
	#moveToPoint(respawnPoint)
	#speedModifier = 1
	
#Change la direction du joueur
func setMovement(movement):
	lastMovement = movement
	velocityPlayer = movement * speedModifier
	idle = false

#Inverse le mouvement du joueur
func bounce():
	setMovement(lastMovement * -1)

#Téléporte le joueur à un point donné
func moveToPoint(point):
	position = point

#Modifie la vitesse du joueur
func modifySpeedModifier(value):
	speedModifier = value
	setMovement(lastMovement)

