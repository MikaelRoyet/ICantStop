extends KinematicBody2D


const SPEED = GameManager.SPEED
var velocityBumper = Vector2(0,0)
var lastMovement
var bumpingPlayer = false
var isMovingBumper = false
var speedModifier

export (Vector2) var directionStart = Vector2(0,0)


func _ready():
	lastMovement = Vector2(0,0)
	speedModifier = 1
	if directionStart != Vector2(0,0):
		velocityBumper = directionStart * SPEED
		lastMovement = directionStart * SPEED

func _physics_process(delta):
	velocityBumper = move_and_slide(velocityBumper)
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision:
			if collision.collider.is_in_group("Bumper"):
				if collision.collider.has_method("move"):
					collision.collider.move(lastMovement)
					bounce()
				AudioManager.playSound(AudioManager.soundEffectBump)



func move(movement):
	velocityBumper = movement * speedModifier
	lastMovement = movement 

func modifySpeedModifier(value):
	speedModifier = value
	move(lastMovement)
	
func bounce():
	move(lastMovement * -1)

func moveToPoint(point):
	position = point
