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
			if collision.collider is TileMap:
				death()
			if collision.collider.is_in_group("Bumper"):
				if collision.collider.has_method("move"):
					collision.collider.move(lastMovement)
					bounce()


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
	
func death():
	print("DEADGE")
	idle = true
	reset()
	
func reset():
	print("RESETGE")
	moveToPoint(respawnPoint)
	speedModifier = 1
	
func setMovement(movement):
	lastMovement = movement
	velocityPlayer = movement * speedModifier
	idle = false

func bounce():
	setMovement(lastMovement * -1)

func moveToPoint(point):
	position = point

func modifySpeedModifier(value):
	speedModifier = value
	setMovement(lastMovement)

