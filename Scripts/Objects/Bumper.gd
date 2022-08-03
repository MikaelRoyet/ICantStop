extends KinematicBody2D

const SPEED = GameManager.SPEED
var velocityBumper = Vector2(0,0)
var lastMovement



func _ready():
	lastMovement = Vector2(0,0)

func _physics_process(delta):
	velocityBumper = move_and_slide(velocityBumper)
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision:
			if collision.collider.is_in_group("Bumper"):
				print("collisionge")
				if collision.collider.has_method("move"):
					print("collisionge2")
					collision.collider.move(lastMovement)
					bounce()



func move(movement):
	velocityBumper = movement
	lastMovement = movement


func bounce():
	move(lastMovement * -1)

func moveToPoint(point):
	position = point
