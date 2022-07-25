extends KinematicBody2D

const SPEED = 100
var velocityPlayer = Vector2(0,0)
var idle = true
var respawnPoint


func _ready():
	respawnPoint = position
	idle = true
	


func _physics_process(delta):
	velocityPlayer = move_and_slide(velocityPlayer)
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision:
			if collision.collider is TileMap:
				death()
			if collision.collider.is_in_group("Bumper"):
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
	position = respawnPoint
	
func setMovement(movement):
	velocityPlayer = movement
	idle = false

func bounce():
	print("BOUNCGE")
	print(velocityPlayer)
	print(velocityPlayer * -1)
	setMovement(velocityPlayer * -1)


func _on_Bumper_body_entered(body):
	bounce()
